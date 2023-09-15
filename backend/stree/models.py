from django.db import models
from hosts import models as hosts_models
from users import models as users_models

# Create your models here.


class TreeNode(models.Model):
    path = models.CharField(max_length=1024)
    name = models.CharField(max_length=255)
    typ = models.CharField(max_length=255)

    def __str__(self):
        return self.path + " (" + self.typ + ")"

    @property
    def parent_path(self):
        return '.'.join(self.path.split('.')[:-1])


class TreeRole(models.Model):
    name = models.CharField(max_length=255)
    description = models.CharField(max_length=255, null=True)

    def __str__(self):
        return self.name


class TreeUserRole(models.Model):
    user = models.ForeignKey(users_models.User, on_delete=models.CASCADE)
    role = models.ForeignKey(TreeRole, on_delete=models.CASCADE)
    tree_node = models.ForeignKey(TreeNode, on_delete=models.CASCADE)

    def __str__(self):
        return self.user.cname + " (" + self.role.name + ")" + " [" + self.tree_node.id + "]"


class Service(models.Model):
    name = models.CharField(max_length=255)
    tree_node = models.OneToOneField(TreeNode, on_delete=models.CASCADE)

    def __str__(self):
        return self.name


class ServiceConf(models.Model):
    service = models.OneToOneField(Service, on_delete=models.CASCADE)
    git = models.CharField(max_length=255)
    opadmin = models.CharField(max_length=255)
    rdadmin = models.CharField(max_length=255)
    domain = models.CharField(max_length=255)
    command = models.CharField(max_length=255)

    def __str__(self):
        return self.service.name


class ServiceEnv(models.Model):
    name = models.CharField(max_length=255)
    tree_node = models.OneToOneField(TreeNode, on_delete=models.CASCADE)
    service = models.ForeignKey(Service, on_delete=models.CASCADE, null=True)


    def __str__(self):
        return self.name


class ServiceEnvHost(models.Model):
    service_env = models.ForeignKey(ServiceEnv, on_delete=models.CASCADE)
    host = models.ForeignKey(hosts_models.Host, on_delete=models.CASCADE)

    def __str__(self):
        return self.service_env.name + " (" + self.host.name + ")"
