from django.contrib import admin
from django.urls import path
from .views import *

urlpatterns = [
    path('all/<str:pickup_id>/', PickupView.as_view()),
    path('pickup/<str:pickup_id>/', PickupView.as_view()),
    path('amenity/all/',GetAmenity.as_view())

]
