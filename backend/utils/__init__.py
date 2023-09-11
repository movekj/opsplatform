import string
import random
import hashlib


def generate_random_string(length=20):
    return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(length))


def get_user_salt():
    return generate_random_string(18)


def get_user_password_hash(password, salt):
    return hashlib.sha224((password + salt).encode('utf-8')).hexdigest()

