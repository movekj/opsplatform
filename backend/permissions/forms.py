from django.forms import Form
from django.forms import CharField, EmailField


class AddRoleForm(Form):
    name = CharField(required=True, error_messages={'required': '请输入角色名'})


class ModifyRoleForm(Form):
    name = CharField(required=True, error_messages={'required': '请输入角色名'})
    id = CharField(required=True, error_messages={'required': '角色ID不能为空'})


class DeleteRoleForm(Form):
    id = CharField(required=True, error_messages={'required': '角色ID不能为空'})


class AddResourceForm(Form):
    name = CharField(required=True, error_messages={'required': '请输入资源名'})
    ref = CharField(required=True, error_messages={'required': '请输入资源引用'})
    type = CharField(required=True, error_messages={'required': '请输入资源类型'})


class ModifyResourceForm(Form):
    id = CharField(required=True, error_messages={'required': '角色ID不能为空'})
    name = CharField(required=True, error_messages={'required': '请输入资源名'})


class DeleteResourceForm(Form):
    id = CharField(required=True, error_messages={'required': '角色ID不能为空'})
