from django.db import models

# Create your models here.


class User(models.Model):
    username = models.CharField(max_length=256)
    password = models.CharField(max_length=512)
    salt = models.CharField(max_length=128)
    phone = models.CharField(max_length=128)
    email = models.EmailField(max_length=128)
    cname = models.CharField(max_length=256)

    def __str__(self):
        return self.username
