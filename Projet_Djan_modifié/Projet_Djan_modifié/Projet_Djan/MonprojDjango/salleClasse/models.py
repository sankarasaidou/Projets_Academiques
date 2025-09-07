from django.db import models

# Create your models here.
class User(models.Model):
    name= models.CharField(max_length=70,unique=True)
    date= models.CharField(max_length=20)
    password= models.CharField(max_length=10,unique=True)
    principal= models.CharField(max_length=70,unique=True)