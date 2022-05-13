# Generated by Django 4.0.2 on 2022-04-09 09:49

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Login',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('email', models.EmailField(max_length=254)),
                ('password', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='newVisitor',
            fields=[
                ('id', models.CharField(max_length=100, primary_key=True, serialize=False)),
                ('profile_image', models.ImageField(blank=True, upload_to='profileimg')),
                ('name', models.CharField(max_length=100)),
                ('mobile', models.PositiveIntegerField()),
                ('email', models.EmailField(max_length=254)),
                ('datetime_oa', models.CharField(default=datetime.datetime.now, max_length=100)),
                ('city', models.CharField(max_length=100)),
                ('reason', models.CharField(max_length=1000)),
                ('novisitor', models.PositiveIntegerField()),
                ('faculty', models.CharField(choices=[('email chief', 'Cheif Warden (Boys)'), ('email cheif', 'Cheif Warden (Girls)'), ('email deen', 'Student Deen Affairs')], max_length=50)),
                ('approval', models.CharField(max_length=100)),
                ('exit', models.CharField(max_length=100)),
            ],
        ),
    ]
