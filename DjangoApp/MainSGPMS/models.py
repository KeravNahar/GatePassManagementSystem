from datetime import datetime
import email
from django.db import models
from pandas import notnull

Fac_CHOICE=(
    ('email chief','Cheif Warden (Boys)'),
    ('email cheif','Cheif Warden (Girls)'),
    ('email deen','Student Deen Affairs'),
    )


class newVisitor(models.Model):
    id = models.CharField(max_length=100,primary_key=True)
    name = models.CharField(max_length=100)
    mobile = models.PositiveIntegerField()
    email = models.EmailField()
    datetime_oa = models.CharField(max_length=100,default=datetime.now)
    city = models.CharField(max_length=100)
    reason = models.CharField(max_length=1000)
    novisitor = models.PositiveIntegerField()
    faculty = models.CharField(choices=Fac_CHOICE, max_length=50)
    approval = models.CharField(max_length=100,null=True,blank=True)
    exit = models.CharField(max_length=100,null=True,blank=True)