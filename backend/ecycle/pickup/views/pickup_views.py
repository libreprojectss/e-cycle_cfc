from django.shortcuts import render
from rest_framework.views import APIView
from pickup.serializers import *
from rest_framework.response import Response
from pickup.helpers.pickups_by_location import get_arranged_pickups_by_location
from rest_framework.permissions import IsAuthenticated
# Create your views here.
class PickupView(APIView):
    def get(self,request,pickup_id=None):
        # if pickup_id:
        #     pickup_objects=pickups.objects.filter(product__user=pickup_id)
        #     serialized_data=PickupSerializer(pickup_objects)
        #     data=serialized_data.data
        # else:
            # pickup_objects=pickups.objects.all()
            # serialized_data=PickupSerializer(pickup_objects,many=True)
        data=get_arranged_pickups_by_location()
        return Response({"message":"Data fetched sucessfully","type":"success","data":data})
    
class CreatePickupView(APIView):
        permission_classes=[IsAuthenticated]
        def post(self,request):
            if not request.data.get("products",""):
                return Response({"message":"Product field is required","type":"error"},400)
            serialized_data=ProductSerializer(data=request.data["products"],many=True)
            if serialized_data.is_valid(raise_exception=True):
                serialized_data.save()
            serialized_data=PickupSerializer(data=request.data)
            if serialized_data.is_valid(raise_exception=True):
                serialized_data.save()
                return Response({"message":"Pickup request recorded sucessfully","type":"success"},status=status.HTTP_201_CREATED)
        