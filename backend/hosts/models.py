from django.db import models

# Create your models here.


class Host(models.Model):
    hostname = models.CharField(max_length=256)
    ip = models.CharField(max_length=128)
    cpu = models.CharField(max_length=128)
    memory = models.CharField(max_length=128)
    os = models.CharField(max_length=128)
    username = models.CharField(max_length=128)
    password = models.CharField(max_length=128)
    permission = models.CharField(max_length=128)

