# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django_mysql.models import Bit1BooleanField
from datetime import datetime

class ActivationEmail(models.Model):
    to_user = models.ForeignKey('User', models.DO_NOTHING)
    is_expired = Bit1BooleanField(default=False)
    random_string = models.CharField(max_length=70)
    send_time = models.DateTimeField()
    expire_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'activation_email'

class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=80)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Carousel(models.Model):
    name = models.CharField(max_length=45)
    img_path = models.CharField(max_length=255)
    is_enabled = Bit1BooleanField(default=True)

    class Meta:
        managed = False
        db_table = 'carousel'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class LimitedTimeProduct(models.Model):
    product = models.ForeignKey('Product', models.DO_NOTHING)
    special_price = models.IntegerField()
    stock = models.IntegerField()
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    create_time = models.DateTimeField()
    is_enabled = Bit1BooleanField(default=False)

    class Meta:
        managed = False
        db_table = 'limited_time_product'


class Order(models.Model):
    user = models.ForeignKey('User', models.DO_NOTHING)
    product = models.ForeignKey('Product', models.DO_NOTHING)
    order_status = models.ForeignKey('OrderStatus', models.DO_NOTHING)
    number = models.IntegerField()
    price = models.IntegerField()
    amount = models.IntegerField()
    buy_time = models.DateTimeField(blank=True, null=True)
    pay_time = models.DateTimeField(blank=True, null=True)
    transport_time = models.DateTimeField(blank=True, null=True)
    receive_time = models.DateTimeField(blank=True, null=True)
    cancel_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'order'


class OrderStatus(models.Model):
    name = models.CharField(max_length=45, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'order_status'


class User(models.Model):
    email = models.CharField(unique=True, max_length=255)
    telephone = models.CharField(unique=True, max_length=255)
    account = models.CharField(unique=True, max_length=255)
    password = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    address = models.CharField(max_length=255, blank=True, null=True)
    birthday = models.DateTimeField(blank=True, null=True)
    is_enabled = Bit1BooleanField(default=False)
    create_time = models.DateTimeField()
    update_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'user'


class SystemConfig(models.Model):
    name = models.CharField(primary_key=True, max_length=200)
    key1 = models.CharField(max_length=200, blank=True, null=True)
    value1 = models.CharField(max_length=200, blank=True, null=True)
    key2 = models.CharField(max_length=200, blank=True, null=True)
    value2 = models.CharField(max_length=200, blank=True, null=True)
    key3 = models.CharField(max_length=200, blank=True, null=True)
    value3 = models.CharField(max_length=200, blank=True, null=True)
    key4 = models.CharField(max_length=200, blank=True, null=True)
    value4 = models.CharField(max_length=200, blank=True, null=True)
    key5 = models.CharField(max_length=200, blank=True, null=True)
    value5 = models.CharField(max_length=200, blank=True, null=True)
    key6 = models.CharField(max_length=200, blank=True, null=True)
    value6 = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'system_config'


class Tag(models.Model):
    name = models.CharField(max_length=45)

    class Meta:
        managed = False
        db_table = 'tag'

class Product(models.Model):
    name = models.CharField(max_length=100)
    img_path = models.CharField(max_length=255)
    price = models.IntegerField()
    stock = models.IntegerField()
    sold_number = models.IntegerField(default=0)
    description = models.TextField(blank=True, null=True)
    is_enabled = Bit1BooleanField(default=True)

    class Meta:
        managed = False
        db_table = 'product'


class ProductTag(models.Model):
    product = models.ForeignKey('Product', models.DO_NOTHING)
    tag = models.ForeignKey('Tag', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'product_tag'
