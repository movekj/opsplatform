from django.shortcuts import render

import utils
from . import forms
from config import Config
from utils import with_rbac_perms
from users import models as users_models
from rest_framework.views import APIView
from datetime import datetime, timedelta
from . import serializers as user_serializers
from django.http.response import JsonResponse
from permissions import models as permissions_models
from rest_framework_jwt.settings import api_settings


# Create your views here.

class Users(APIView):
    # @with_rbac_perms(perms=[dict(ref="api.users", verb="get"), dict(ref="module.users", verb="read")])
    def get(self, request):
        user_id = request.GET.get("id")

        if user_id:
            user = users_models.User.objects.filter(id=user_id).first()
            return JsonResponse(dict(code=200, data=user_serializers.UserSerializer(user).data))

        users = users_models.User.objects.all()
        return JsonResponse(dict(code=200, data=user_serializers.UserSerializer(users, many=True).data))

    @with_rbac_perms(perms=[dict(ref="api.users", verb="get"), dict(ref="module.users", verb="write")])
    def post(self, request):
        form = forms.AddUserForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            username = clean_data.get('username')
            password = clean_data.get('password')
            confirm_password = clean_data.get('confirm_password')
            email = clean_data.get('email')
            phone = clean_data.get('phone')
            cname = clean_data.get('cname')
            if users_models.User.objects.filter(username=username).exists():
                return JsonResponse(dict(code=400, message="用户名已存在"))

            if password != confirm_password:
                form.errors['confirm_password'] = '两次密码不一致'
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)

            salt = utils.get_user_salt()
            encrypt_password = utils.get_user_password_hash(password, salt)

            users_models.User.objects.create(
                username=username,
                password=encrypt_password,
                salt=salt,
                email=email,
                phone=phone,
                cname=cname
            )
            return JsonResponse(dict(code=200, data='ok'))

        else:
            return JsonResponse(data=dict(code=400, errors=form.errors), status=400)

    @with_rbac_perms(perms=[dict(ref="api.users", verb="put"), dict(ref="module.users", verb="write")])
    def put(self, request):
        form = forms.ModifyUserForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            _id = clean_data.get('id')
            user = users_models.User.objects.filter(id=_id).first()
            if not user:
                return JsonResponse(dict(code=400, message="用户id[%s]不存在" % _id))

            username = clean_data.get('username')
            email = clean_data.get('email')
            phone = clean_data.get('phone')
            cname = clean_data.get('cname')

            if username:
                user.username = username

            if email:
                user.email = email

            if phone:
                user.phone = phone

            if cname:
                user.cname = cname

            user.save()
        return JsonResponse(dict(code=200, data='ok'))

    @with_rbac_perms(perms=[dict(ref="api.users", verb="delete"), dict(ref="module.users", verb="write")])
    def delete(self, request):
        user_id = request.data.get('id')
        if not user_id:
            return JsonResponse(dict(code=400, message="id不能为空"))

        user = None
        if user_id:
            user = users_models.User.objects.filter(id=user_id).first()

        if not user:
            return JsonResponse(dict(code=400, message="用户[%s]不存在" % user_id))
        user.delete()
        return JsonResponse(dict(code=200, data='ok'))


class UserLogin(APIView):

    def post(self, request):
        form = forms.UserLoginForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            username = clean_data.get('username')
            password = clean_data.get('password')
            user = users_models.User.objects.filter(username=username).first()
            if not user:
                return JsonResponse(dict(code=400, message="用户名或密码错误"))
            if utils.get_user_password_hash(password, user.salt) == user.password:
                payload = api_settings.JWT_PAYLOAD_HANDLER(user)
                payload['exp'] = datetime.utcnow() + timedelta(days=Config.TOKEN_EXPIRE_DAYS)
                token = api_settings.JWT_ENCODE_HANDLER(payload)
                return JsonResponse(dict(code=200, data=dict(token=token)))
            else:
                return JsonResponse(dict(code=400, message="用户名或密码错误"))
        return JsonResponse(dict(code=200, error=form.errors))


class UserRoleBinding(APIView):
    @with_rbac_perms(perms=[dict(ref="api.users", verb="delete"), dict(ref="module.users", verb="write")])
    def post(self, request):
        user_id = request.data.get('id')
        role_ids = request.data.get('roleIds')

        errors = dict()
        if not user_id:
            errors['id'] = 'id不能为空'
            return JsonResponse(dict(code=400, errors=errors))

        user = None
        if user_id:
            user = users_models.User.objects.filter(id=user_id).first()

        if not user:
            return JsonResponse(dict(code=400, message="用户[%s]不存在" % user_id))

        roles = permissions_models.Role.objects.filter(id__in=role_ids)
        user_role_bindings = list()
        for role in roles:
            if not permissions_models.UserRoleBinding.objects.filter(Role=role, User=user).exists():
                user_role_binding = permissions_models.UserRoleBinding(
                    User=user,
                    Role=role
                )
                user_role_bindings.append(user_role_binding)
        permissions_models.UserRoleBinding.objects.bulk_create(user_role_bindings)
        return JsonResponse(dict(code=200, data='ok'))

    @with_rbac_perms(perms=[dict(ref="api.users", verb="delete"), dict(ref="module.users", verb="write")])
    def delete(self, request):
        user_id = request.data.get('id')
        role_id = request.data.get('roleId')
        errors = dict()
        if not user_id:
            errors['id'] = 'id不能为空'
            return JsonResponse(dict(code=400, errors=errors))

        if not role_id:
            errors['roleId'] = '角色不能为空'
            return JsonResponse(dict(code=400, errors=errors))

        permissions_models.UserRoleBinding.objects.filter(User__id=user_id, Role__id=role_id).delete()
        return JsonResponse(dict(code=200, data='ok'))


class UserInfo(APIView):
    def get(self, request):
        user = request.USER
        return JsonResponse(dict(code=200, data=user_serializers.UserInfoWithRbacSerializer(user).data))
