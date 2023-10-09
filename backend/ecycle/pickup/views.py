from django.shortcuts import render
from rest_framework.views import APIView
from pickup.serializers import *
# Create your views here.
class PickupView(APIView):
    def get(self,request,pickup_id=None):
        if pickup_id:
            pickup_objects=pickups.objects.filter(user=pickup_id)
            serialized_data=PickupSerializer(pickup_objects)
        else:
            pickup_objects=pickups.objects.all()
            serialized_data=PickupSerializer(pickup_objects,many=True)
        return Response({"message":"Data fetched sucessfully","type":"success","data":serialized_data.data})
    
    def post(self,request,pickup_id=None):
        serialized_data=PickupSerializer(data=request.data)
        if serialized_data.is_valid(raise_exception=True):
            serialized_data.save()
            return Response({"message":"Pickup request recorded sucessfully","type":"success"},status=status.HTTP_201_CREATED)
       

    
