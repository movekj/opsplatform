from rest_framework import serializers


class RoleSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()


class ResourceSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()
    type = serializers.CharField()
    ref = serializers.CharField()


class VerbSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()


