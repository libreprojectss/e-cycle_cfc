from django.db import models
from account.models import User
def product_image_upload_to(instance, filename):
    # Get the user's email from the related carrier
    id_var= instance.id
    role=instance.role
    # Append the filename to the product id and return the complete path
    return f"{id_var}/product_image/{filename}"
# Create your models here.
class products(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    title=models.CharField(max_length=255)
    image=models.ImageField(upload_to=product_image_upload_to,default=None,blank=True,null=True)
    description=models.CharField(max_length=255)
    usable=models.BooleanField()

class pickups(models.Model):
    product=models.ManyToManyField(products,related_name="product")
    lat=models.FloatField() # For lattitude
    long=models.FloatField() # For longitude
    picked_on=models.DateTimeField(default=None,blank=True,null=True)

    @property
    def is_picked(self):
        if self.picked_on:
            return True
        return False


class donate(models.Model):
    product=models.ForeignKey(products,on_delete=models.CASCADE)
    donated_on=models.DateTimeField()
    verified_status=models.BooleanField() # true for verified and false for not verified
    




