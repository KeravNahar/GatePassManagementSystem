# Generated by Django 4.0.2 on 2022-05-12 17:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MainSGPMS', '0007_alter_newvisitor_img'),
    ]

    operations = [
        migrations.AlterField(
            model_name='newvisitor',
            name='img',
            field=models.ImageField(blank=True, upload_to=''),
        ),
    ]
