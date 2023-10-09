from .models import *
class ProductSerializer(serializers.Serializer):
    class Meta:
        model=products
        fields="__all__"
    

class PickupSerializer(serializers.Serializer):
    products=ProductSerializer(many=True)
    class Meta:
        model=pickups
        fields=['products','lat','long','picked_on','is_picked']