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


class BuildHistorySerializer(serializers.Serializer):
    id = serializers.IntegerField()
    version = serializers.CharField()
    build_log = serializers.CharField()
    build_cmd = serializers.CharField()
    start_time = serializers.DateTimeField()
    stop_time = serializers.DateTimeField()
    status = serializers.CharField()
    operator = serializers.CharField()


class PubHistorySerializer(serializers.Serializer):
    id = serializers.IntegerField()
    version = serializers.CharField()
    pub_log = serializers.CharField()
    pub_cmd = serializers.CharField()
    start_time = serializers.DateTimeField()
    stop_time = serializers.DateTimeField()
    status = serializers.CharField()
    operator = serializers.CharField()

