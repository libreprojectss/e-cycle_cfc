# Generated by Django 4.2.6 on 2023-10-09 14:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pickup', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='pickups',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('lat', models.FloatField()),
                ('long', models.FloatField()),
                ('picked_on', models.DateTimeField(blank=True, default=None, null=True)),
                ('product', models.ManyToManyField(related_name='product', to='pickup.products')),
            ],
        ),
    ]