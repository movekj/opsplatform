from django.forms import Form
from django.forms import ModelForm
from django.forms import CharField, EmailField
from .models import User


class AddUserForm(Form):
    username = CharField(required=True, error_messages={'required': '请输入用户名'})
    password = CharField(required=True, error_messages={'required': '请输入密码'})
    confirm_password = CharField(required=True, error_messages={'required': '请再次输入密码'})
    email = EmailField(required=True, error_messages={'required': '请输入邮箱地址'})
    phone = CharField(required=False)
    cname = CharField(required=True, error_messages={'required': '请输入中文名'})

