# Generated by Django 4.0.2 on 2022-04-11 10:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('MainSGPMS', '0004_alter_newvisitor_approval_alter_newvisitor_exit_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='newvisitor',
            name='profile_image',
        ),
    ]