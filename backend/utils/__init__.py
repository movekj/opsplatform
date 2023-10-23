import string
import random
import hashlib
from threading import Thread
from django.http.response import JsonResponse
from permissions import models as permissions_models
from stree import models as tree_models
import time
import datetime
import subprocess
from stree import  models as stree_models
import  paramiko

def generate_random_string(length=20):
    return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(length))


def get_user_salt():
    return generate_random_string(18)


def get_user_password_hash(password, salt):
    return hashlib.sha224((password + salt).encode('utf-8')).hexdigest()


def with_rbac_perms(perms=None):
    def decorator(func):
        def wrapper(*args, **kwargs):
            request = args[1]

            roles = [user_role_binding.Role for user_role_binding in
                     permissions_models.UserRoleBinding.objects.filter(User=request.USER)]
            has_perm = False
            for perm in perms:
                if permissions_models.RoleRuleVerb.objects.filter(
                    RoleRule__Role__in=roles,
                    RoleRule__Resource__ref=perm.get('ref'),
                    Verb__name=perm.get('verb')
                ).exists():
                    has_perm = True
                    continue
            if not has_perm:
                return JsonResponse(data=dict(code=403, error='没有权限'), status=403)
            return func(*args, **kwargs)
        return wrapper
    return decorator


def get_parent_tree_node(path):
    parent_path = '.'.join(path.split(".")[:-1])
    return tree_models.TreeNode.objects.filter(path=parent_path).first()

def get_parent_tree_node_paths(path):
    path_slices = path.split(".")
    parent_paths = list()
    cache = list()
    for path_slice in path_slices:
        cache.append(path_slice)
        parent_paths.append('.'.join(cache))
    return parent_paths


class BuildThread(Thread):
    def __init__(self, history_id):
        Thread.__init__(self)
        self.history_id = history_id

    def run(self):
        build_history = tree_models.BuildHistory.objects.filter(id=self.history_id).first()
        service_conf = tree_models.ServiceConf.objects.filter(service=build_history.service_env.service).first()
        if not service_conf:
            build_history.build_log += "服务配置信息不存在"
            build_history.status = "FAIL"
            build_history.stop_time = datetime.datetime.now()
            build_history.save()
            return

        if not service_conf.build_command:
            build_history.build_log += "服务没有配置构建命令"
            build_history.status = "FAIL"
            build_history.stop_time = datetime.datetime.now()
            build_history.save()
            return

        if build_history.build_log is None:
            build_history.build_log = ''
        for service_env_host in tree_models.ServiceEnvHost.objects.filter(service_env=build_history.service_env):
            build_history.build_log += "开始在服务器[%s@%s]上执行构建操作\n" %(service_env_host.host.ip,service_env_host.host.hostname)
            build_history.save()
            ssh = paramiko.SSHClient()
            ssh.load_system_host_keys()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            try:

                ssh.connect(hostname=service_env_host.host.ip, username=service_env_host.host.username, password=service_env_host.host.password)
                channel = ssh.get_transport().open_session()
                channel.exec_command(service_conf.build_command)

                while True:

                    if channel.exit_status_ready():
                        break

                    # 检查通道是否有错误输出可读
                    if channel.recv_stderr_ready():
                        line = channel.recv_stderr(1024).decode('utf-8')
                        if line:
                            build_history.build_log += line
                            build_history.save()

                    # 检查通道是否有数据可读
                    if channel.recv_ready():
                        line = channel.recv(1024).decode('utf-8')
                        if line:
                            build_history.build_log += line
                            build_history.save()


                line = channel.recv(1024).decode('utf-8')
                if line:
                    build_history.build_log += line
                    build_history.save()

                # 检查通道是否有错误输出可读
                line = channel.recv_stderr(1024).decode('utf-8')
                if line:
                    build_history.build_log += line
                    build_history.save()

                if channel.recv_exit_status() == 0:
                    pass
                else:
                    build_history.status = "FAIL"
                    build_history.stop_time = datetime.datetime.now()
                    return
            except Exception as e:
                build_history.build_log += str(e)
                build_history.status = "FAIL"
                build_history.stop_time = datetime.datetime.now()
                return 
            finally:
                ssh.close()
            build_history.build_log += "结束在服务器[%s@%s]上的构建操作\n" %(service_env_host.host.ip,service_env_host.host.hostname)
            build_history.build_log += "结束时间: %s\n" % build_history.stop_time.strftime("%Y-%m-%d %H:%M:%SZ")
            build_history.save()
            ssh.close()
        build_history.status = "SUCCESS"
        build_history.save()

class PubThread(Thread):
    def __init__(self, history_id):
        Thread.__init__(self)
        self.history_id = history_id

    def run(self):
        pub_hsitory = tree_models.PubHistory.objects.filter(id=self.history_id).first()
        service_conf = tree_models.ServiceConf.objects.filter(service=pub_hsitory.service_env.service).first()
        if not service_conf:
            pub_hsitory.pub_log += "服务配置信息不存在"
            pub_hsitory.status = "FAIL"
            pub_hsitory.stop_time = datetime.datetime.now()
            pub_hsitory.save()
            return

        if not service_conf.start_command:
            pub_hsitory.pub_log += "服务没有配置启动命令"
            pub_hsitory.status = "FAIL"
            pub_hsitory.stop_time = datetime.datetime.now()
            pub_hsitory.save()
            return

        if pub_hsitory.pub_log is None:
            pub_hsitory.pub_log = ''

        for service_env_host in tree_models.ServiceEnvHost.objects.filter(service_env=pub_hsitory.service_env):
            pub_hsitory.pub_log += "开始发布服务器[%s@%s]上的服务\n" %(service_env_host.host.ip,service_env_host.host.hostname)
            pub_hsitory.save()
            ssh = paramiko.SSHClient()
            ssh.load_system_host_keys()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            try:
                ssh.connect(hostname=service_env_host.host.ip, username=service_env_host.host.username, password=service_env_host.host.password)
                channel = ssh.get_transport().open_session()
                channel.exec_command(service_conf.start_command)

                while True:

                    if channel.exit_status_ready():
                        break

                    # 检查通道是否有错误输出可读
                    if channel.recv_stderr_ready():
                        line = channel.recv_stderr(1024).decode('utf-8')
                        if line:
                            pub_hsitory.pub_log += line
                            pub_hsitory.save()

                    # 检查通道是否有数据可读
                    if channel.recv_ready():
                        line = channel.recv(1024).decode('utf-8')
                        if line:
                            pub_hsitory.pub_log += line
                            pub_hsitory.save()

                line = channel.recv(1024).decode('utf-8')
                if line:
                    pub_hsitory.pub_log += line
                    pub_hsitory.save()

                # 检查通道是否有错误输出可读
                line = channel.recv_stderr(1024).decode('utf-8')
                if line:
                    pub_hsitory.pub_log += line
                    pub_hsitory.save()
                if channel.recv_exit_status() == 0:
                    pass
                else:
                    pub_hsitory.status = "FAIL"
                    pub_hsitory.stop_time = datetime.datetime.now()
                    pub_hsitory.save()
                    return
            except Exception as e:
                pub_hsitory.pub_log += str(e)
                pub_hsitory.status = "FAIL"
                pub_hsitory.stop_time = datetime.datetime.now()
                pub_hsitory.save()
                return
            finally:
                ssh.close()
            pub_hsitory.pub_log += "结束在服务器[%s@%s]的发布操作\n" %(service_env_host.host.ip,service_env_host.host.hostname)
            pub_hsitory.pub_log += "结束时间:  %s\n" % pub_hsitory.stop_time.strftime("%Y-%m-%d %H:%M:%SZ")
            pub_hsitory.save()
            ssh.close()
        pub_hsitory.status = "SUCCESS"
        pub_hsitory.save()



# class PubThread(Thread):
#     def __init__(self, history_id):
#         Thread.__init__(self)
#         self.history_id = history_id
#
#     def run(self):
#         pub_hsitory = tree_models.PubHistory.objects.filter(id=self.history_id).first()
#         pub_cmd_file_path = "/tmp/pub-%s.sh" % pub_hsitory.id
#         # pub_hosts_file = "/tmp/pub-hosts-%s" % pub_hsitory.id
#
#         with open(pub_cmd_file_path, 'w') as f:
#             f.write(pub_hsitory.pub_cmd)
#
#         hosts = [service_env_host.host.ip for service_env_host in stree_models.ServiceEnvHost.objects.filter(service_env=pub_hsitory.service_env)]
#         # with open(pub_hosts_file, 'w') as hf:
#         #     f.write(' '.join(hosts))
#
#         process = subprocess.Popen("bash -x " + pub_cmd_file_path, stderr=subprocess.PIPE, env={'hosts': ' '.join(hosts)},
#                                    stdout=subprocess.PIPE, shell=True)
#
#         while process.poll() is None:
#             line = process.stderr.readline() + process.stdout.readline()
#             if pub_hsitory.pub_log is None:
#                 pub_hsitory.pub_log = ''
#             pub_hsitory.pub_log += str(line.decode())
#             pub_hsitory.save()
#             time.sleep(0.5)
#
#         if process.returncode == 0:
#             pub_hsitory.status = "SUCCESS"
#         else:
#             pub_hsitory.status = "FAIL"
#         pub_hsitory.stop_time = datetime.datetime.now()
#         pub_hsitory.save()


