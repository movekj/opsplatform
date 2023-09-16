from rest_framework import serializers


class HostSerializer(serializers.Serializer):
    id = serializers.CharField()
    hostname = serializers.CharField()
    ip = serializers.CharField()
    cpu = serializers.CharField()
    memory = serializers.CharField()
    os = serializers.CharField()
    username = serializers.CharField()
    password = serializers.CharField()
    position = serializers.CharField()
