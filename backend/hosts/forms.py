from django.forms import Form
from django.forms import CharField, EmailField, IntegerField


class AddHostForm(Form):
    hostname = CharField(required=True, error_messages={'required': '请输入主机名'})
    ip = CharField(required=True, error_messages={'required': '请输入ip地址'})
    cpu = CharField(required=True, error_messages={'required': '请输入cpu核心数'})
    memory = CharField(required=True, error_messages={'required': '请输入内存大小'})
    os = CharField(required=True, error_messages={'required': '请输入系类型统'})
    username = CharField(required=True, error_messages={'required': '请输入管理用户名'})
    password = CharField(required=True, error_messages={'required': '请输入管理密码'})
    position = CharField(required=True, error_messages={'required': '请输入主机位置'})


class ModifyHostForm(AddHostForm):
    id = CharField(required=True, error_messages={'required': '请输入ID'})


class DeleteHostForm(Form):
    id = CharField(required=True, error_messages={'required': '请输入ID'})
