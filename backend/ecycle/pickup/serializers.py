from .models import *
from rest_framework import serializers,status
class ProductSerializer(serializers.Serializer):
    class Meta:
        model=products
        fields="__all__"
    

class PickupSerializer(serializers.Serializer):
    products=ProductSerializer(many=True)
    class Meta:
        model=pickups
        fields=['products','lat','long','picked_on','is_picked']
    def create(self, validated_data):
        return User.objects.create_user(**validated_data)
    