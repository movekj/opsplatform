import re
from config import Config
from rest_framework.views import APIView
from stree import models as stree_models
from stree import serializers as stree_serializers
from permissions import models as permissions_models

from users import models as users_models

from django.http.response import JsonResponse
from django.db import transaction
import utils


class Init(APIView):
    def get(self, request):
        stree_nodes = stree_models.TreeNode.objects.filter(
            path__regex="^%s\.%s$" % (Config.NAME_REGEX, Config.NAME_REGEX)
        )
        print(stree_nodes)
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
    def get(self, request):
        tree_id = request.GET.get('tree_id')
        if not tree_id:
            return JsonResponse(dict(code=400, errors=[dict(tree_id="tree_id不能为空")]))
        parent_tree_node = stree_models.TreeNode.objects.filter(id=tree_id).first()

        tree_nodes = stree_models.TreeNode.objects.filter(
            path__regex="^%s\.%s$" % (parent_tree_node.path, Config.NAME_REGEX)
        )
        data = stree_serializers.TreeNodeSerializer(tree_nodes, many=True).data
        return JsonResponse(dict(data=data))

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

        stree_models.TreeNode(
            name=name,
            path=path,
            typ=typ,
        ).save()

        return JsonResponse(dict(data='ok'))

    def delete(self, request):
        tree_id = request.data.get('id')
        if not tree_id:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="id不能为空")]), status=400)
        tree_node = stree_models.TreeNode.objects.filter(id=tree_id).first()
        if not tree_node:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="节点[%s]不存在" % tree_id)]), status=400)
        if stree_models.TreeNode.objects.filter(path__regex="^%s.%s$" %(tree_node.path, Config.NAME_REGEX)).count() > 1:
            return JsonResponse(data=dict(code=400, errors=[dict(parent_id="该节点存在其他子节点，无删除法" % tree_id)]), status=400)
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
                print(children_node.path)
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
