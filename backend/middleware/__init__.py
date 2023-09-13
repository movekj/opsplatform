from config import Config
from users import models as user_models
from jwt.exceptions import ExpiredSignature
from django.http.response import JsonResponse
from django.utils.deprecation import MiddlewareMixin
from rest_framework_jwt.settings import api_settings


class JwtAuthMiddleware(MiddlewareMixin):
    def process_request(self, request):
        if request.path in Config.AUTH_WHITE_LIST:
            return
        authorization = request.META.get('HTTP_AUTHORIZATION')
        proto, token = authorization.split(' ')
        if proto == "JWT":
            try:
                payload = api_settings.JWT_DECODE_HANDLER(token)
                user = user_models.User.objects.filter(id=payload.get('user_id')).first()
                if user:
                    request.USER = user
                    return
                else:
                    return JsonResponse(data=dict(code=401, error="用户不存在"), status=401)
            except ExpiredSignature:
                return JsonResponse(data=dict(code=401, error="token过期"), status=401)
            except Exception as e:
                return JsonResponse(data=dict(code=500, error=str(e)), status=500)

