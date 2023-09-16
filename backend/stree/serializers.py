from rest_framework import serializers


class TreeNodeSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()
    typ = serializers.CharField()
    path = serializers.CharField()


class ServiceConfSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    git = serializers.CharField()
    opadmin = serializers.CharField()
    rdadmin = serializers.CharField()
    domain = serializers.CharField()
    start_command = serializers.CharField()
    build_command = serializers.CharField()

