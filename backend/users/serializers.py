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

