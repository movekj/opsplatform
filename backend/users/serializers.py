from rest_framework import serializers
from permissions import models as permissions_models
from permissions import serializers as permissions_serializers

class UserSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    username = serializers.CharField()
    cname = serializers.CharField()
    email = serializers.CharField()
    phone = serializers.CharField()

    roles = serializers.SerializerMethodField()

    def get_roles(self, user):
        roles = [user_role_binding.Role for user_role_binding in
                 permissions_models.UserRoleBinding.objects.filter(User=user)]
        data = permissions_serializers.RoleSerializer(roles, many=True).data
        return data


class UserInfoWithRbacSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    username = serializers.CharField()
    cname = serializers.CharField()
    email = serializers.CharField()
    phone = serializers.CharField()
    rbac = serializers.SerializerMethodField()

    def get_rbac(self, user):
        roles = [user_role_binding.Role for user_role_binding in
                 permissions_models.UserRoleBinding.objects.filter(User=user)]
        role_rule_verbs = permissions_models.RoleRuleVerb.objects.filter(RoleRule__Role__in=roles)
        data = [dict(
                resource_ref=role_rule_verb.RoleRule.Resource.ref,
                resource_type=role_rule_verb.RoleRule.Resource.type,
                verb=role_rule_verb.Verb.name) for role_rule_verb in role_rule_verbs]
        return data

