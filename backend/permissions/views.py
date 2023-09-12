from .forms import AddRoleForm, ModifyRoleForm, DeleteRoleForm, AddResourceForm, \
    ModifyResourceForm,  DeleteResourceForm
from rest_framework.views import APIView
from django.http.response import JsonResponse

from permissions import models as permissions_models
from permissions import serializers as permissions_serializers


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
                return JsonResponse(dict(code=400, errors=form.errors))
            permissions_models.Role(name=name).save()
        else:
            return JsonResponse(dict(code=400, errors=form.errors))
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
                return JsonResponse(dict(code=400, errors=form.errors))
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
                return JsonResponse(dict(code=400, errors=form.errors))
            role.delete()
        return JsonResponse(dict(code=200, data='ok'))


class Resource(APIView):
    def get(self, request):
        resource_id = request.GET.get("id")
        if resource_id:
            user = permissions_models.Resource.objects.filter(id=resource_id).first()
            return JsonResponse(dict(code=200, data=permissions_serializers.ResourcecSerializer(user).data))
        roles = permissions_models.Resource.objects.all()
        return JsonResponse(dict(code=200, data=permissions_serializers.ResourcecSerializer(roles, many=True).data))

    def post(self, request):
        form = AddResourceForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            ref = clean_data.get("ref")
            _type = clean_data.get("type")
            if permissions_models.Resource.objects.filter(ref=ref).exists():
                form.errors["ref"] = "资源[%s]已存在" % name
                return JsonResponse(dict(code=400, errors=form.errors))
            permissions_models.Resource(name=name, ref=ref, type=_type).save()
            return JsonResponse(dict(code=200, data='ok'))
        return JsonResponse(dict(code=400, errors=form.errors))

    def put(self, request):
        form = ModifyResourceForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            name = clean_data.get("name")
            _id = clean_data.get("id")
            resource = permissions_models.Resource.objects.filter(id=_id).first()
            if not resource:
                form.errors["id"] = "资源[%s]不存在" % _id
                return JsonResponse(dict(code=400, errors=form.errors))
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
                return JsonResponse(dict(code=400, errors=form.errors))
            resource.delete()
        return JsonResponse(dict(code=200, data='ok'))
