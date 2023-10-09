from django.contrib import admin
from django.urls import path
from .views import *
urlpatterns = [
    path('signup/',UserCreateView.as_view()),
    path('login/', LoginView.as_view())
]
