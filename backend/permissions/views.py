from .forms import AddRoleForm, ModifyRoleForm, DeleteRoleForm, AddResourceForm, \
    ModifyResourceForm, DeleteResourceForm, AddVerbForm, ModifyVerbForm, DeleteVerbForm
from rest_framework.views import APIView
from django.http.response import JsonResponse

from permissions import models as permissions_models
from permissions import serializers as permissions_serializers
from django.db import transaction


# Create your views here.


class Role(APIView):
    def get(self, request):
        role_id = request.GET.get("id")
        if role_id:
            user = permissions_models.Role.objects.filter(id=role_id).first()
            return JsonResponse(dict(code=200, data=permissions_serializers.RoleSerializer(user).data))
        roles = permissions_models.Role.objects.all()
        return JsonResponse(dict(code=200, data=permissions_serializers.RoleSerializer(roles, many=True).data))

    def post(self, request):
        form = AddRoleForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            role = permissions_models.Role.objects.filter(name=name).first()
            if role:
                form.errors["name"] = "角色[%s]已存在" % name
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            permissions_models.Role(name=name).save()
        else:
            return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
        return JsonResponse(dict(code=200, data='ok'))

    def put(self, request):
        form = ModifyRoleForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            _id = clean_data.get("id")
            role = permissions_models.Role.objects.filter(id=_id).first()
            if not role:
                form.errors["id"] = "角色[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            role.name = name
            role.save()
        return JsonResponse(dict(code=200, data='ok'))

    def delete(self, request):
        form = DeleteRoleForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            _id = clean_data.get("id")
            role = permissions_models.Role.objects.filter(id=_id).first()
            if not role:
                form.errors["id"] = "角色[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            role.delete()
        return JsonResponse(dict(code=200, data='ok'))


class Resource(APIView):
    def get(self, request):
        resource_id = request.GET.get("id")
        if resource_id:
            user = permissions_models.Resource.objects.filter(id=resource_id).first()
            return JsonResponse(dict(code=200, data=permissions_serializers.ResourceSerializer(user).data))
        roles = permissions_models.Resource.objects.all()
        return JsonResponse(dict(code=200, data=permissions_serializers.ResourceSerializer(roles, many=True).data))

    def post(self, request):
        form = AddResourceForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            ref = clean_data.get("ref")
            _type = clean_data.get("type")
            if permissions_models.Resource.objects.filter(ref=ref).exists():
                form.errors["ref"] = "资源[%s]已存在" % name
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            permissions_models.Resource(name=name, ref=ref, type=_type).save()
            return JsonResponse(dict(code=200, data='ok'))
        return JsonResponse(data=dict(code=400, errors=form.errors), status=400)

    def put(self, request):
        form = ModifyResourceForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            _id = clean_data.get("id")
            resource = permissions_models.Resource.objects.filter(id=_id).first()
            if not resource:
                form.errors["id"] = "资源[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            resource.name = name
            resource.save()
        return JsonResponse(dict(code=200, data='ok'))

    def delete(self, request):
        form = DeleteResourceForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            _id = clean_data.get("id")
            resource = permissions_models.Resource.objects.filter(id=_id).first()
            if not resource:
                form.errors["id"] = "资源[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            resource.delete()
        return JsonResponse(dict(code=200, data='ok'))


class Verb(APIView):
    def get(self, request):
        verb_id = request.GET.get("id")
        if verb_id:
            verb = permissions_models.Verb.objects.filter(id=verb_id).first()
            return JsonResponse(dict(code=200, data=permissions_serializers.VerbSerializer(verb).data))
        verbs = permissions_models.Verb.objects.all()
        return JsonResponse(dict(code=200, data=permissions_serializers.VerbSerializer(verbs, many=True).data))

    def post(self, request):
        form = AddRoleForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            if permissions_models.Verb.objects.filter(name=name).exists():
                form.errors["name"] = "动作[%s]已存在" % name
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            permissions_models.Verb(name=name).save()
            return JsonResponse(dict(code=200, data='ok'))
        return JsonResponse(data=dict(code=400, errors=form.errors), status=400)

    def put(self, request):
        form = ModifyVerbForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            _id = clean_data.get("id")
            verb = permissions_models.Verb.objects.filter(id=_id).first()
            if not verb:
                form.errors["id"] = "动作[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            verb.name = name
            verb.save()
        return JsonResponse(dict(code=200, data='ok'))

    def delete(self, request):
        form = DeleteVerbForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            _id = clean_data.get("id")
            verb = permissions_models.Verb.objects.filter(id=_id).first()
            if not verb:
                form.errors["id"] = "动作[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            verb.delete()
        return JsonResponse(dict(code=200, data='ok'))


class RoleRule(APIView):
    def get(self, request):
        role_id = request.GET.get("id")
        errors = dict()
        if not role_id:
            errors['roleId'] = "角色不能为空"
            return JsonResponse(dict(code=400, errors=errors))
        role_rules = permissions_models.RoleRule.objects.filter(Role_id=role_id)
        if not role_rules:
            return JsonResponse(dict(code=200, data=list()))
        data = list()
        for role_rule in role_rules:
            resource = permissions_serializers.ResourceSerializer(role_rule.Resource).data
            verbs = [role_rule_verb.Verb for role_rule_verb in
                     permissions_models.RoleRuleVerb.objects.filter(RoleRule=role_rule)]
            resource['verbs'] = permissions_serializers.VerbSerializer(verbs, many=True).data
            data.append(resource)
        return JsonResponse(dict(code=200, data=data))

    def post(self, request):
        resource_id = request.data.get("resourceId")
        errors = dict()
        if not resource_id:
            errors['resourceId'] = "资源不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        resource = permissions_models.Resource.objects.filter(id=resource_id).first()
        if not resource:
            errors['resourceId'] = "资源[%s]不存在" % resource_id
            return JsonResponse(dict(code=400, errors=errors))

        role_id = request.data.get("roleId")
        if not role_id:
            errors['roleId'] = "角色不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        role = permissions_models.Role.objects.filter(id=role_id).first()
        if not role:
            errors['roleId'] = "角色[%s]不存在" % role_id
            return JsonResponse(dict(code=400, errors=errors))

        verb_ids = request.data.get("verbIds")
        if not verb_ids:
            errors['verbIds'] = "动作不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        verb_ids = [int(verb_id) for verb_id in verb_ids]
        verbs = permissions_models.Verb.objects.filter(id__in=verb_ids)
        if not verbs:
            errors['verbIds'] = "动作[%s]不存在" % verb_ids
            return JsonResponse(dict(code=400, errors=errors))

        with transaction.atomic():
            role_rule = permissions_models.RoleRule.objects.filter(Role=role, Resource=resource).first()
            if not role_rule:
                role_rule = permissions_models.RoleRule(
                    Role=role,
                    Resource=resource
                )
                role_rule.save()
            role_rule_verbs = list()
            for verb in verbs:
                if not permissions_models.RoleRuleVerb.objects.filter(RoleRule=role_rule, Verb=verb).exists():
                    role_rule_verb = permissions_models.RoleRuleVerb(RoleRule=role_rule, Verb=verb)
                    role_rule_verbs.append(role_rule_verb)
            permissions_models.RoleRuleVerb.objects.bulk_create(role_rule_verbs)
        return JsonResponse(dict(code=200, data='ok'))

    def delete(self, request):
        role_id = request.data.get('role_id')
        resource_id = request.data.get('resource_id')
        errors = dict()
        if not role_id:
            errors['role_id'] = "角色不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        role = permissions_models.Role.objects.filter(id=resource_id).first()
        if not role:
            errors['role_id'] = "角色[%s]不存在" % role_id
            return JsonResponse(dict(code=400, errors=errors))

        if not resource_id:
            errors['resource_id'] = "资源不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        resource = permissions_models.Resource.objects.filter(id=resource_id).first()
        if not resource:
            errors['resource_id'] = "资源不存在" % role_id
            return JsonResponse(dict(code=400, errors=errors))
        permissions_models.RoleRule.objects.filter(Role__id=role_id, Resource__id=resource_id).delete()
        return JsonResponse(dict(code=200, data='ok'))


class RoleRuleVerb(APIView):
    def delete(self, request):
        role_id = request.data.get('role_id')
        verb_id = request.data.get('verb_id')
        resource_id = request.data.get('resource_id')

        errors = dict()
        if not role_id:
            errors['role_id'] = "角色不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        role = permissions_models.Role.objects.filter(id=resource_id).first()
        if not role:
            errors['role_id'] = "角色[%s]不存在" % role_id
            return JsonResponse(dict(code=400, errors=errors))

        if not verb_id:
            errors['verb_id'] = "动作不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        verb = permissions_models.Verb.objects.filter(id=verb_id).first()
        if not verb:
            errors['verb_id'] = "动作不存在" % role_id
            return JsonResponse(dict(code=400, errors=errors))

        if not resource_id:
            errors['resource_id'] = "资源不能为空"
            return JsonResponse(dict(code=400, errors=errors))

        resource = permissions_models.Resource.objects.filter(id=resource_id).first()
        if not resource:
            errors['resource_id'] = "资源不存在" % role_id
            return JsonResponse(dict(code=400, errors=errors))

        permissions_models.RoleRuleVerb.objects.filter(
            RoleRule__Resource__id=resource_id,
            RoleRule__Role__id=role_id,
            Verb__id=verb_id
        ).delete()
        return JsonResponse(dict(code=200, data='ok'))
