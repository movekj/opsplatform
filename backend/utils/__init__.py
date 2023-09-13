import string
import random
import hashlib
from django.http.response import JsonResponse
from permissions import models as permissions_models

def generate_random_string(length=20):
    return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(length))


def get_user_salt():
    return generate_random_string(18)


def get_user_password_hash(password, salt):
    return hashlib.sha224((password + salt).encode('utf-8')).hexdigest()


def with_rbac_perms(perms=None):
    def decorator(func):
        def wrapper(*args, **kwargs):
            request = args[1]

            roles = [user_role_binding.Role for user_role_binding in
                     permissions_models.UserRoleBinding.objects.filter(User=request.USER)]
            has_perm = False
            for perm in perms:
                if permissions_models.RoleRuleVerb.objects.filter(
                    RoleRule__Role__in=roles,
                    RoleRule__Resource__ref=perm.get('ref'),
                    Verb__name=perm.get('verb')
                ).exists():
                    has_perm = True
                    continue
            if not has_perm:
                return JsonResponse(data=dict(code=403, msg='没有权限'), status=403)
            return func(*args, **kwargs)
        return wrapper
    return decorator

