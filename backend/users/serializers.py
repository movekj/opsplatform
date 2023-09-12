from rest_framework import serializers


class UserSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    username = serializers.CharField()
    cname = serializers.CharField()
    email = serializers.CharField()
    phone = serializers.CharField()

