import re
from config import Config
from rest_framework.views import APIView
from stree import models as stree_models
from stree import serializers as stree_serializers
from permissions import models as permissions_models
from hosts import serializers as hosts_serializers
from hosts import models as hosts_models


from users import models as users_models

from django.http.response import JsonResponse
from django.db import transaction
import utils
from django.db.models import Q


class Init(APIView):
    def get(self, request):
        stree_nodes = stree_models.TreeNode.objects.filter(
            path__regex="^%s\.%s$" % (Config.NAME_REGEX, Config.NAME_REGEX)
        )
        return JsonResponse(dict(data=self.init_tree_node(stree_nodes)))

    def init_tree_node(self, tree_nodes):
        tree_node_data = dict()
        tree_node_data_cache = list()
        for tree_node in tree_nodes:
            root_tree_node_parttern = re.compile(
                r"^(?P<path>%s)(\..*)?" % (Config.NAME_REGEX)
            )
            m = root_tree_node_parttern.match(tree_node.path)
            if m:
                root_tree_node_path = m.groupdict().get("path")
                if root_tree_node_path not in tree_node_data_cache:
                    root_tree_node = stree_models.TreeNode.objects.filter(
                        path=root_tree_node_path
                    ).first()
                    tree_node_data = stree_serializers.TreeNodeSerializer(root_tree_node).data
                    tree_node_data_cache.append(root_tree_node_path)

        second_level_tree_node_paths = list()
        for tree_node in tree_nodes:
            second_level_tree_node_parttern = re.compile(
                r"^(?P<path>%s\.%s)(\..*)?" % (Config.NAME_REGEX, Config.NAME_REGEX)
            )
            m = second_level_tree_node_parttern.match(tree_node.path)
            if m:
                second_level_tree_node_path = m.groupdict().get("path")
                if second_level_tree_node_path not in second_level_tree_node_paths:
                    second_level_tree_node_paths.append(second_level_tree_node_path)

        second_level_tree_nodes = stree_models.TreeNode.objects.filter(
            path__in=second_level_tree_node_paths
        ).order_by("name")
        tree_node_data["children"] = stree_serializers.TreeNodeSerializer(
            second_level_tree_nodes, many=True
        ).data
        return tree_node_data


class Children(APIView):

    def parent_tree_node_path__eq__has_perm_tree_node_paths(
        self, has_perm_tree_node_paths, parent_tree_node_path
    ):
        for has_perm_tree_node_path in has_perm_tree_node_paths:
            if (
                has_perm_tree_node_path.startswith(parent_tree_node_path)
                and parent_tree_node_path == has_perm_tree_node_path
            ):
                return True
        return False

    def parent_tree_node_path__gt__has_perm_tree_node_paths(
        self, has_perm_tree_node_paths, parent_tree_node_path
    ):
        for has_perm_tree_node_path in has_perm_tree_node_paths:
            if (
                parent_tree_node_path.startswith(has_perm_tree_node_path)
                and parent_tree_node_path > has_perm_tree_node_path
            ):
                return True
        return False

    def parent_tree_node_path__lt__has_perm_tree_node_paths(
        self, has_perm_tree_node_paths, parent_tree_node_path
    ):
        for has_perm_tree_node_path in has_perm_tree_node_paths:
            if (
                has_perm_tree_node_path.startswith(parent_tree_node_path)
                and parent_tree_node_path <= has_perm_tree_node_path
            ):
                return True
        return False

    def get(self, request):
        tree_id = request.GET.get('tree_id')
        if not tree_id:
            return JsonResponse(dict(code=400, errors=[dict(tree_id="tree_id不能为空")]))
        parent_tree_node = stree_models.TreeNode.objects.filter(
            id=tree_id
        ).first()

        has_perm_tree_nodes = [
            tur.tree_node
            for tur in stree_models.TreeUserRole.objects.filter(
                user_id=request.USER
            ).order_by("tree_node__path")
        ]
        has_perm_tree_node_paths = [
            has_perm_tree_node.path
            for has_perm_tree_node in has_perm_tree_nodes
        ]

        children_paths = list()

        if self.parent_tree_node_path__eq__has_perm_tree_node_paths(
                has_perm_tree_node_paths, parent_tree_node.path
        ) or self.parent_tree_node_path__gt__has_perm_tree_node_paths(
            has_perm_tree_node_paths, parent_tree_node.path
        ):
            tree_nodes = stree_models.TreeNode.objects.filter(
                Q(
                    path__regex="^%s\.%s$"
                                % (parent_tree_node.path, Config.NAME_REGEX)
                )
            ).order_by("path")

        elif self.parent_tree_node_path__lt__has_perm_tree_node_paths(
                has_perm_tree_node_paths, parent_tree_node.path
        ):

            for has_perm_tree_node in has_perm_tree_nodes:
                parttern = re.compile(
                    r"^(?P<path>%s\.%s)"
                    % (parent_tree_node.path, Config.NAME_REGEX)
                )
                m = parttern.match(has_perm_tree_node.path)
                if m:
                    children_path = m.groupdict().get("path")
                    if children_path not in children_paths:
                        children_paths.append(children_path)
            tree_nodes = stree_models.TreeNode.objects.filter(
                Q(path__in=children_paths)
            ).order_by("path")
        else:
            return JsonResponse(dict(data=list(), status=200))
        return JsonResponse(dict(data=stree_serializers.TreeNodeSerializer(tree_nodes, many=True).data, status=200))

    def put(self, request):
        tree_id = request.data.get('id')
        name = request.data.get('name')

        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(id="tree_id不能为空")]), status=400)

        if not name:
            return JsonResponse(data=dict(code=400, errors=[dict(id="name不能为空")]), status=400)

        tree_node = stree_models.TreeNode.objects.filter(id=tree_id).first()

        if not tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(id="节点[%s]不存在" % tree_id)]), status=400)

        new_path = tree_node.path.replace(tree_node.name, name, 1)
        if stree_models.TreeNode.objects.filter(path=new_path).exists():
            return JsonResponse(data=dict(code=400, errors=[dict(id="节点已存在")]), status=400)

        children_nodes = stree_models.TreeNode.objects.filter(
                path__regex="^%s\.%s" % (tree_node.path, Config.NAME_REGEX)
            )
        for children_node in children_nodes:
            children_node.path = new_path + children_node.path.replace(
                tree_node.path, "", 1
            )
            children_node.save()

        tree_node.name = name
        tree_node.path = new_path
        tree_node.save()
        return JsonResponse(dict(data='ok'))

    def post(self, request):
        parent_id = request.data.get('parent_id')
        name = request.data.get('name')
        typ = request.data.get('type')

        if not typ:
            return JsonResponse(data=dict(code=400, errors=[dict(type="type不能为空")]), status=400)
        if not name:
            return JsonResponse(data=dict(code=400, errors=[dict(name="name不能为空")]), status=400)
        if not parent_id:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="parent_id不能为空")]), status=400)
        parent_tree_node = stree_models.TreeNode.objects.filter(id=parent_id).first()
        if not parent_tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="节点[%s]不存在" % parent_id)]), status=400)
        path = parent_tree_node.path + '.' + name
        if stree_models.TreeNode.objects.filter(path=path).exists():
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="节点[%s]已存在" % path)]), status=400)

        with transaction.atomic():

            tree_node = stree_models.TreeNode(
                name=name,
                path=path,
                typ=typ,
            )
            tree_node.save()
            if typ == "service":
                if stree_models.Service.objects.filter(name=name).exists():
                    return JsonResponse(data=dict(code=400, errors=[dict(parent_id="服务[%s]已存在" % path)]), status=400)
                stree_models.Service(name=name, tree_node=tree_node).save()
            if typ == "service_env":
                service = stree_models.Service.objects.filter(tree_node=parent_tree_node).first()
                if stree_models.ServiceEnv.objects.filter(tree_node=tree_node, name=name).exists():
                    return JsonResponse(data=dict(code=400, errors=[dict(parent_id="环境[%s]已存在" % path)]),status=400)
                stree_models.ServiceEnv(tree_node=tree_node, name=name, service=service).save()
        return JsonResponse(dict(data='ok'))

    def delete(self, request):
        tree_id = request.data.get('id')
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="id不能为空")]), status=400)
        tree_node = stree_models.TreeNode.objects.filter(id=tree_id).first()
        if not tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="节点[%s]不存在" % tree_id)]), status=400)
        if stree_models.TreeNode.objects.filter(path__regex="^%s.%s$" %(tree_node.path, Config.NAME_REGEX)).count() > 1:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="该节点存在其他子节点，无删除法")]), status=400)
        tree_node.delete()
        return JsonResponse(dict(data='ok'))


class ChildrenMove(APIView):
    def post(self, request):
        dest_id = request.data.get('dest_id')
        src_id = request.data.get('src_id')
        if not dest_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="dest_id不能为空")]), status=400)
        if not src_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="src_id不能为空")]), status=400)

        dest_tree_node = stree_models.TreeNode.objects.filter(id=dest_id).first()

        if not dest_tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(type="目标节点不存在")]), status=400)

        src_tree_node = stree_models.TreeNode.objects.filter(id=src_id).first()
        if not src_tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(type="目标节点不存在")]), status=400)

        src_parent_tree_node = utils.get_parent_tree_node(src_tree_node.path)
        if src_parent_tree_node.typ in ('dir', 'bu') and dest_tree_node.typ == 'dir':
            pass
        elif src_parent_tree_node.typ != dest_tree_node.typ:
            return JsonResponse(data=dict(code=400, errors=[dict(type="仅允许同一层级的移动操作")]), status=400)

        new_path = dest_tree_node.path + "." + src_tree_node.name
        with transaction.atomic():

            children_nodes = stree_models.TreeNode.objects.filter(
                path__regex="^%s\.%s" % (src_tree_node.path, Config.NAME_REGEX)
            )
            for children_node in children_nodes:
                children_node.path = new_path + children_node.path.replace(
                    src_tree_node.path, "", 1
                )
                children_node.save()
            src_tree_node.path = new_path
            src_tree_node.save()
        return JsonResponse(dict(data='ok'))


class TreeNodeDetail(APIView):
    def get(self, request):
        tree_id = request.GET.get('id')
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)
        tree_node = stree_models.TreeNode.objects.filter(id=tree_id).first()
        if not tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(type="节点不存在")]), status=400)
        return JsonResponse(dict(data=stree_serializers.TreeNodeSerializer(tree_node).data))


class TreeNodePerm(APIView):
    def post(self, request):
        tree_id = request.data.get('tree_id')
        tree_node = stree_models.TreeNode.objects.filter(id=tree_id).first()
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)

        if not tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(type="节点不存在")]), status=400)

        role_id = request.data.get('role_id')
        if not role_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="role_id不能为空")]), status=400)
        tree_role = stree_models.TreeRole.objects.filter(id=role_id).first()
        if not tree_role:
            return JsonResponse(data=dict(code=400, errors=[dict(type="角色不存在")]), status=400)

        user_ids = request.data.get('user_ids')
        if not user_ids:
            return JsonResponse(data=dict(code=400, errors=[dict(type="user_ids不能为空")]), status=400)

        users = users_models.User.objects.filter(id__in=user_ids)
        if not users:
            return JsonResponse(data=dict(code=400, errors=[dict(type="用不存在户")]), status=400)

        turs = list()

        for user in users:
            if not stree_models.TreeUserRole.objects.filter(user=user, role=tree_role, tree_node=tree_node).exists():
                tur = stree_models.TreeUserRole(
                    user=user, role=tree_role, tree_node=tree_node
                )
                turs.append(tur)
        stree_models.TreeUserRole.objects.bulk_create(turs)
        return JsonResponse(dict(data="ok"))

    def delete(self, request):
        tree_id = request.data.get('tree_id')
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)

        role_id = request.data.get('role_id')
        if not role_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="role_id不能为空")]), status=400)

        user_id = request.data.get('user_id')
        if not user_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="user_id不能为空")]), status=400)

        stree_models.TreeUserRole.objects.filter(user_id=user_id, role_id=role_id, tree_node_id=tree_id).delete()
        return JsonResponse(dict(data="ok"))

    def get(self, request):
        tree_id = request.GET.get('id')
        tree_node = stree_models.TreeNode.objects.filter(id=tree_id).first()
        if not tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(type="节点不存在")]), status=400)

        is_admin = 0

        if utils.with_rbac_perms(perms=[dict(ref="stree.module", verb="write")]):
            is_admin = 1

        role_users = dict()
        role_users_cache = dict()
        data = dict(
            result=list()
        )

        def do(tree_node):
            readonly = 1
            if tree_node.id == int(tree_id):
                readonly = 0

            for tur in stree_models.TreeUserRole.objects.select_related("role").filter(
                tree_node=tree_node
            ):
                role_name = tur.role.name
                if role_name not in role_users:
                    role_users[role_name] = list()
                if role_name not in role_users_cache:
                    role_users_cache[role_name] = list()

                user = tur.user
                if not user:
                    continue

                if user.username not in role_users_cache[role_name]:
                    role_users[role_name].append(
                        dict(
                            id=user.id,
                            tur_id=tur.id,
                            cname=user.cname,
                            phone=user.phone,
                            readonly=readonly,
                            username=user.username,
                        )
                    )
                    role_users_cache[role_name].append(user.username)
                if tur.role.name not in data:
                    data[tur.role.name] = list()
                data[tur.role.name].append(tur.user.username)

        while tree_node.parent_path != "":
            do(tree_node)
            tree_node = stree_models.TreeNode.objects.filter(
                path=tree_node.parent_path
            ).first()
        do(tree_node)

        for tree_role in stree_models.TreeRole.objects.order_by("name"):
            data['result'].append(
                dict(
                    id=tree_role.id,
                    name=tree_role.name,
                    description=tree_role.description,
                    is_admin=is_admin,
                    users=role_users.get(tree_role.name, []),
                )
            )

        return JsonResponse(dict(data=data))


class ServiceConf(APIView):
    def get(self, request):
        tree_id = request.GET.get('tree_id')
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)
        service_conf = stree_models.ServiceConf.objects.filter(service__tree_node__id=tree_id).first()
        data = stree_serializers.ServiceConfSerializer().data
        if service_conf:
            data = stree_serializers.ServiceConfSerializer(service_conf).data
        return JsonResponse(dict(data=data))

    def post(self, request):
        tree_id = request.data.get('tree_id')
        domain = request.data.get('domain')
        rdadmin = request.data.get('rdadmin')
        opadmin = request.data.get('opadmin')
        git = request.data.get('git')
        start_command = request.data.get('start_command')
        build_command = request.data.get('build_command')

        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)
        service = stree_models.Service.objects.filter(tree_node__id=tree_id).first()
        if not service:
            return JsonResponse(data=dict(code=400, errors=[dict(type="服务不存在")]), status=400)

        service_conf = stree_models.ServiceConf.objects.filter(service__tree_node__id=tree_id).first()
        if not service_conf:
            service_conf = stree_models.ServiceConf(service=service)
        if domain:
            service_conf.domain = domain
        if rdadmin:
            service_conf.rdadmin = rdadmin
        if opadmin:
            service_conf.opadmin = opadmin
        if git:
            service_conf.git = git
        if start_command:
            service_conf.start_command = start_command
        if build_command:
            service_conf.build_command = build_command
        service_conf.save()
        return JsonResponse(dict(data='ok'))


class ServiceEnvHost(APIView):
    def get(self, request):
        tree_id = request.GET.get('tree_id')
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)

        hosts = [
            service_env_host.host
            for service_env_host in
            stree_models.ServiceEnvHost.objects.filter(service_env__tree_node_id=tree_id)
        ]

        data = hosts_serializers.HostSerializer(hosts, many=True).data
        return JsonResponse(dict(data=data))

    def post(self, request):
        tree_id = request.data.get('tree_id')
        host_ids = request.data.get('hostIds')

        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)

        if not host_ids:
            return JsonResponse(data=dict(code=400, errors=[dict(type="hostIds不能为空")]), status=400)

        service_env = stree_models.ServiceEnv.objects.filter(tree_node__id=tree_id).first()
        if not service_env:
            return JsonResponse(data=dict(code=400, errors=[dict(type="环境不存在")]), status=400)

        service_env_hosts = list()
        for host_id in host_ids:

            if not stree_models.ServiceEnvHost.objects.filter(service_env__tree_node__id=tree_id, host__id=host_id).exists():
                service_env_host = stree_models.ServiceEnvHost(service_env=service_env,host_id=host_id)
                service_env_hosts.append(service_env_host)
        stree_models.ServiceEnvHost.objects.bulk_create(service_env_hosts)
        return JsonResponse(dict(data='ok'))


    def delete(self, request):
        tree_id = request.data.get('tree_id')
        host_id = request.data.get('host_id')
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="tree_id不能为空")]), status=400)

        if not host_id:
            return JsonResponse(data=dict(code=400, errors=[dict(type="hostIds不能为空")]), status=400)

        stree_models.ServiceEnvHost.objects.filter(service_env__tree_node__id=tree_id, host__id=host_id).delete()
        return JsonResponse(dict(data='ok'))
