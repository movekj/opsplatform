from django.shortcuts import render

from . import forms
import utils
from rest_framework.views import APIView
from users import models as users_models
from django.http.response import JsonResponse

# Create your views here.

class Users(APIView):
    def get(self, request):
        users_models.User.objects.all()
        return JsonResponse(dict(code=200, data='ok'))

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
                return JsonResponse(dict(code=400, errors=form.errors))

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
        else:
            return JsonResponse(dict(code=400, errors=form.errors))
        return JsonResponse(dict(code=200, data='ok'))




