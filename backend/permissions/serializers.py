from rest_framework import serializers


class RoleSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()


