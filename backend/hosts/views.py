from django.http.response import  JsonResponse
from hosts import models as hosts_models
from . import serializers as hosts_serializers
from rest_framework.views import APIView
from .forms import AddHostForm, ModifyHostForm, DeleteHostForm

# Create your views here.

class Host(APIView):
    def get(self, request):
        host_id = request.GET.get("id")
        if host_id:
            user = hosts_models.Host.objects.filter(id=host_id).first()
            return JsonResponse(dict(code=200, data=hosts_serializers.HostSerializer(user).data))
        hosts = hosts_models.Host.objects.all()
        return JsonResponse(dict(code=200, data=hosts_serializers.HostSerializer(hosts, many=True).data))

    def post(self, request):
        form = AddHostForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            hostname = clean_data.get("hostname")
            ip = clean_data.get("ip")
            cpu = clean_data.get("cpu")
            memory = clean_data.get("memory")
            os = clean_data.get("os")
            username = clean_data.get("username")
            password = clean_data.get("password")
            position = clean_data.get("position")

            host = hosts_models.Host.objects.filter(ip=ip).first()
            if host:
                form.errors["ip"] = "ip地址[%s]已存在" % ip
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            host = hosts_models.Host.objects.filter(hostname=hostname).first()
            if host:
                form.errors["hostname"] = "主机名[%s]已存在" % hostname
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            hosts_models.Host(
                hostname=hostname,
                ip=ip,
                cpu=cpu,
                memory=memory,
                os=os,
                username=username,
                password=password,
                position=position
            ).save()
        else:
            return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
        return JsonResponse(dict(code=200, data='ok'))

    def put(self, request):
        form = ModifyHostForm(request.data)

        if form.is_valid():
            clean_data = form.clean()
            hostname = clean_data.get("hostname")
            ip = clean_data.get("ip")
            cpu = clean_data.get("cpu")
            memory = clean_data.get("memory")
            os = clean_data.get("os")
            username = clean_data.get("username")
            password = clean_data.get("password")
            position = clean_data.get("position")
            _id = clean_data.get("id")
            host = hosts_models.Host.objects.filter(id=_id).first()
            if not host:
                form.errors["id"] = "主机[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            print(clean_data)
            if hostname:
                host.hostname = hostname
            if ip:
                host.ip = ip
            if cpu:
                host.cpu = cpu
            if memory:
                host.memory = memory
            if os:
                host.os = os
            if username:
                host.username = username
            if password:
                host.password = password
            if position:
                host.position = position
            host.save()
        print(form.errors)
        return JsonResponse(dict(code=200, data='ok'))

    def delete(self, request):
        form = DeleteHostForm(request.data)
        if form.is_valid():
            clean_data = form.clean()
            _id = clean_data.get("id")
            host = hosts_models.Host.objects.filter(id=_id).first()
            if not host:
                form.errors["id"] = "主机[%s]不存在" % _id
                return JsonResponse(data=dict(code=400, errors=form.errors), status=400)
            host.delete()
        return JsonResponse(dict(code=200, data='ok'))
