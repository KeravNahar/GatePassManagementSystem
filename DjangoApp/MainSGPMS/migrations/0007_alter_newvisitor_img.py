<<<<<<< HEAD
# Generated by Django 4.0.2 on 2022-05-11 11:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MainSGPMS', '0006_newvisitor_img_alter_newvisitor_faculty'),
    ]

    operations = [
        migrations.AlterField(
            model_name='newvisitor',
            name='img',
            field=models.ImageField(blank=True, upload_to='VisitorImg'),
        ),
    ]
=======
# Generated by Django 4.0.2 on 2022-05-11 11:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MainSGPMS', '0006_newvisitor_img_alter_newvisitor_faculty'),
    ]

    operations = [
        migrations.AlterField(
            model_name='newvisitor',
            name='img',
            field=models.ImageField(blank=True, upload_to='VisitorImg'),
        ),
    ]
>>>>>>> fa57a6c3dfd12bc8125e3c08c6c8300112f8360f
