from django.urls import path
from django.contrib.auth import views as auth_views
from . import views  # Импорт всех views из текущего приложения

urlpatterns = [
    path('', views.register, name='register'),
    path('login/', auth_views.LoginView.as_view(), name='login'),
]
