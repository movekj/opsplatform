from django.db import models
from users import models as users_model

# Create your models here.


class Role(models.Model):
    name = models.CharField(max_length=128)

    def __str__(self):
        return self.name


class Resource(models.Model):
    name = models.CharField(max_length=128)
    ref = models.CharField(max_length=128)
    type = models.CharField(max_length=128)

    def __str__(self):
        return self.name + "-" + self.type + "-" + self.ref


class Verb(models.Model):
    name = models.CharField(max_length=128)

    def __str__(self):
        return self.name


class RoleRule(models.Model):
    Role = models.ForeignKey(Role, on_delete=models.CASCADE)
    Resource = models.ForeignKey(Resource, on_delete=models.CASCADE)

    def __str__(self):
        return self.Role.name + "-" + self.Resource.name


class RoleRuleVerb(models.Model):
    RoleRule = models.ForeignKey(RoleRule, on_delete=models.CASCADE, null=True)
    Verb = models.ForeignKey(Verb, on_delete=models.CASCADE)

    def __str__(self):
        return self.RoleRule.Role.name + "-" + self.Verb.name


class UserRoleBinding(models.Model):
    Role = models.ForeignKey(Role, on_delete=models.CASCADE)
    User = models.ForeignKey(users_model.User, on_delete=models.CASCADE)

    def __str__(self):
        return self.Role.name + "-" + self.User

