from .forms import AddRoleForm, ModifyRoleForm, DeleteRoleForm
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

