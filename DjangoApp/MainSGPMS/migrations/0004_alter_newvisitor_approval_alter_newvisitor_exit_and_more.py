# Generated by Django 4.0.2 on 2022-04-11 06:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MainSGPMS', '0003_alter_newvisitor_approval_alter_newvisitor_exit'),
    ]

    operations = [
        migrations.AlterField(
            model_name='newvisitor',
            name='approval',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='newvisitor',
            name='exit',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='newvisitor',
            name='profile_image',
            field=models.ImageField(blank=True, upload_to='images/'),
        ),
    ]
