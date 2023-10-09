from django.db import models
def product_image_upload_to(instance, filename):
    # Get the user's email from the related carrier
    id_var= instance.id
    role=instance.role
    # Append the filename to the product id and return the complete path
    return f"{id_var}/handler_image/{filename}"
# Create your models here.
class products(models.Model):
    user=models.ForeignKey(User,on_delete=models.Cascade)
    title=models.CharField(max_length=255)
    image=models.ImageField(upload_to=product_image_upload_to,default=None,blank=True,null=True)
    description=models.CharField(max_length=255)
    usable=models.BooleanField()

class donate(models.Model):
    product=models.ForeignKey(products,on_delete=models.Cascade)
    donated_on=models.DateTimeField()
    verified_status=models.BooleanField() # true for verified and false for not verified
    




