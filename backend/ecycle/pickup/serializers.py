from .models import *
from rest_framework import serializers,status
class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model=products
        fields="__all__"
        read_only_fields=["user"]
    

class PickupSerializer(serializers.ModelSerializer):
    products=ProductSerializer(many=True,read_only=True)
    class Meta:
        model=pickups
        fields=['products','lat','long','picked_on','is_picked']
    
    