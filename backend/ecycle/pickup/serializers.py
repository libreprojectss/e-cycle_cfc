from .models import *
from rest_framework import serializers,status
from django.core.files.base import ContentFile
import base64,os
from django.conf import settings
class ProductSerializer(serializers.ModelSerializer):
    image_64 = serializers.CharField(write_only=True)
    class Meta:
        model=products
        fields="__all__"
        read_only_fields=["user"]
    
    def create(self, validated_data):
        # Extract the base64 content from the received data
        image_data = validated_data.pop('image_64', None)

        if image_data:
            padding = '=' * (4 - (len(image_data) % 4))
            image_data += padding
              # Decode the base64 string and create a ContentFile
            decoded_image = ContentFile(base64.b64decode(image_data.encode()), name='uploaded_image.png')

            # Get the path to the media directory
            media_path = os.path.join(settings.MEDIA_ROOT, 'uploaded_images')

            # Create the media directory if it doesn't exist
            os.makedirs(media_path, exist_ok=True)

            # Set the file path within the media directory
            file_path = os.path.join(media_path, 'uploaded_image.png')

            # Save the ContentFile to the specified path
            with open(file_path, 'wb') as f:
                f.write(decoded_image.read())
            validated_data['image_64'] = file_path
            validated_data["image"]=decoded_image

        return super().create(validated_data)
class PickupSerializer(serializers.ModelSerializer):
    products=ProductSerializer(many=True,read_only=True)
    class Meta:
        model=pickups
        fields=['products','lat','long','picked_on','is_picked']

    
    