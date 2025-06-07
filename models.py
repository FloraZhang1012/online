# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = True
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type_id = models.IntegerField()
    codename = models.CharField(max_length=100)

    class Meta:
        managed = True
        db_table = 'auth_permission'
        unique_together = (('codename', 'content_type_id'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = True
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed =True
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = True
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = True
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = True
        db_table = 'django_session'


class TsAddr(models.Model):
    username = models.CharField(max_length=255, blank=True, null=True)
    shouji = models.CharField(max_length=255, blank=True, null=True)
    addr = models.CharField(max_length=255, blank=True, null=True)
    shui = models.ForeignKey('TsGoumai', models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'ts_addr'


class TsChushou(models.Model):
    username = models.CharField(unique=True, max_length=255, blank=True, null=True)
    password = models.CharField(max_length=255, blank=True, null=True)
    img_url = models.CharField(max_length=255, blank=True, null=True)
    jianjie = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'ts_chushou'


class TsDingdan(models.Model):
    gmsj = models.DateField(blank=True, null=True)
    maijia = models.CharField(max_length=255, blank=True, null=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    img_url = models.CharField(max_length=255, blank=True, null=True)
    price = models.FloatField()
    zfzt = models.CharField(max_length=255, blank=True, null=True)
    phone = models.CharField(max_length=255, blank=True, null=True)
    addr = models.CharField(max_length=255, blank=True, null=True)
    shui = models.ForeignKey('TsGoumai', models.DO_NOTHING)
    maijia_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'ts_dingdan'


class TsDiqu(models.Model):
    mingcheng = models.CharField(max_length=255)

    class Meta:
        managed = True
        db_table = 'ts_diqu'


class TsFenlei(models.Model):
    mingcheng = models.CharField(max_length=255)

    class Meta:
        managed = True
        db_table = 'ts_fenlei'


class TsGoumai(models.Model):
    id = models.BigAutoField(primary_key=True)
    username = models.CharField(unique=True, max_length=255, blank=True, null=True)
    password = models.CharField(max_length=255, blank=True, null=True)
    img_url = models.CharField(max_length=255, blank=True, null=True)
    jianjie = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'ts_goumai'


class TsGuanli(models.Model):
    id = models.BigAutoField(primary_key=True)
    username = models.CharField(max_length=255)
    password = models.TextField()

    class Meta:
        managed = True
        db_table = 'ts_guanli'


class TsJingqu(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=255)
    price = models.IntegerField()
    dizhi = models.CharField(max_length=255, blank=True, null=True)
    dengji = models.CharField(max_length=255, blank=True, null=True)
    img_url = models.CharField(max_length=255, blank=True, null=True)
    jianjie = models.TextField()
    zhuangtai = models.CharField(max_length=255, blank=True, null=True)
    is_kaifang = models.CharField(max_length=255, blank=True, null=True)
    is_shenhe = models.CharField(max_length=255, blank=True, null=True)
    diqu = models.ForeignKey(TsDiqu, models.DO_NOTHING)
    fenlei = models.ForeignKey(TsFenlei, models.DO_NOTHING)
    maijia = models.ForeignKey(TsChushou, models.DO_NOTHING)
    collect_num = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'ts_jingqu'


class TsLb(models.Model):
    id = models.BigAutoField(primary_key=True)
    img_url = models.CharField(max_length=255)
    created_at = models.DateTimeField()
    title = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'ts_lb'


class TsMessage(models.Model):
    id = models.BigAutoField(primary_key=True)
    sender_id = models.IntegerField()
    sender_role = models.CharField(max_length=10)
    receiver_id = models.IntegerField()
    receiver_role = models.CharField(max_length=10)
    content = models.TextField()
    is_read = models.IntegerField()
    created_at = models.DateTimeField()

    class Meta:
        managed = True
        db_table = 'ts_message'


class TsNotify(models.Model):
    id = models.BigAutoField(primary_key=True)
    type = models.CharField(max_length=50)
    content = models.TextField()
    is_read = models.IntegerField()
    created_at = models.DateTimeField()
    user = models.ForeignKey(TsGoumai, models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'ts_notify'


class TsPl(models.Model):
    id = models.BigAutoField(primary_key=True)
    pl_date = models.DateField(blank=True, null=True)
    content = models.TextField(blank=True, null=True)
    is_shenhe = models.CharField(max_length=255, blank=True, null=True)
    jingqu = models.ForeignKey(TsJingqu, models.DO_NOTHING)
    shui = models.ForeignKey(TsGoumai, models.DO_NOTHING)
    reply = models.TextField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'ts_pl'


class TsSc(models.Model):
    id = models.BigAutoField(primary_key=True)
    sc_date = models.DateField(blank=True, null=True)
    jingqu = models.ForeignKey(TsJingqu, models.DO_NOTHING)
    shui = models.ForeignKey(TsGoumai, models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'ts_sc'
