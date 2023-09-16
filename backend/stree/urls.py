"""
URL configuration for opsplatform project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.urls import path, re_path
from stree import views


urlpatterns = [
    path('init/', views.Init.as_view()),
    re_path(r'^children(/)?(?P<tree_id>\d+)?$', views.Children.as_view()),
    path('children/move', views.ChildrenMove.as_view()),
    path('node/detail', views.TreeNodeDetail.as_view()),
    path('node/perm', views.TreeNodePerm.as_view()),
    path('service/conf', views.ServiceConf.as_view()),
    path('service/env/host', views.ServiceEnvHost.as_view()),

]
