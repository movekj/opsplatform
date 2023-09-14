from rest_framework import serializers


class TreeNodeSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField()
    typ = serializers.CharField()
    path = serializers.CharField()

