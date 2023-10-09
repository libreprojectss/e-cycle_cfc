
class PickupSerializer(serializers.Serializer):
    class Meta:
        model=User
        fields="__all__"