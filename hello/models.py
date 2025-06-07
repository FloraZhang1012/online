from django.db import models
from django.contrib.auth.hashers import make_password
from django.utils import timezone


class Guanli(models.Model):
    username = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=255)  # 存储加密密码

    def save(self, *args, **kwargs):
        if not self.password.startswith('pbkdf2_sha256$'):
            self.password = make_password(self.password)
        super().save(*args, **kwargs)

    class Meta:
        db_table = "ts_guanli"

class Chushou(models.Model):
    username = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=255)  # 存储加密密码
    img_url = models.CharField(max_length=255, blank=True, null=True)
    jianjie = models.CharField(max_length=255, null=True, blank=True)

    def save(self, *args, **kwargs):
        if not self.password.startswith('pbkdf2_sha256$'):
            self.password = make_password(self.password)
        super().save(*args, **kwargs)

    
    class Meta:
        db_table = "ts_chushou"

class Goumai(models.Model):
    username = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=255)
    img_url = models.CharField(max_length=255, blank=True, null=True)
    jianjie = models.CharField(max_length=255, null=True, blank=True)

    def save(self, *args, **kwargs):
        if not self.password.startswith('pbkdf2_sha256$'):  # 只加密明文密码
            self.password = make_password(self.password)
        super().save(*args, **kwargs)

    class Meta:
        db_table = "ts_goumai"

from django.db import models

class Lb(models.Model):
    img_url = models.CharField(max_length=255)
    title = models.CharField(max_length=100, blank=True, null=True)  # ✅ 新增字段
    created_at = models.DateTimeField(auto_now_add=True)

  # ✅ 推荐：添加上传时间

    class Meta:
        db_table = 'ts_lb'


# 景区分类
class Fenlei(models.Model):
    mingcheng = models.CharField(max_length=255)
    class Meta:
        db_table = "ts_fenlei"

# 景区地区
class Diqu(models.Model):
    mingcheng = models.CharField(max_length=255)
    class Meta:
        db_table = "ts_diqu"


class Jingqu(models.Model):
    name = models.CharField(max_length=255) # 景点名称
    price = models.IntegerField() # 景点价格
    dizhi = models.CharField(max_length=255, null=True, blank=True) # 景点地址
    dengji = models.CharField(max_length=255, null=True, blank=True) # 景点等级
    img_url = models.CharField(max_length=255,null=True,blank=True) # 景点照片
    jianjie = models.TextField() # 景点简介
    zhuangtai = models.CharField(max_length=255, null=True, blank=True, default='待上架') # 上架状态
    is_kaifang = models.CharField(max_length=255, null=True, blank=True, default='开放中') # 开放状态
    is_shenhe = models.CharField(max_length=255, null=True, blank=True, default='待审核') # 审核状态
    maijia = models.ForeignKey(Chushou, on_delete=models.CASCADE) # 景点发布人
    fenlei = models.ForeignKey(Fenlei,on_delete=models.CASCADE) # 景点分类
    diqu = models.ForeignKey(Diqu,on_delete=models.CASCADE) # 景点地区
    collect_num = models.CharField(max_length=255, null=True, blank=True, default='30') # 浏览量
    class Meta:
        db_table = "ts_jingqu"

class Dingdan(models.Model):
    shui = models.ForeignKey(Goumai, on_delete=models.CASCADE) 
    gmsj = models.DateField(null=True, blank=True)            
    maijia = models.ForeignKey(Chushou, on_delete=models.CASCADE)  
    title = models.CharField(max_length=255, null=True, blank=True)  
    img_url = models.CharField(max_length=255, null=True, blank=True)  
    price = models.FloatField()
    zfzt = models.CharField(max_length=255, null=True, blank=True, default='待支付')  
    phone = models.CharField(max_length=255, null=True, blank=True, default='')     
    addr = models.CharField(max_length=255, null=True, blank=True, default='')      
    class Meta:
        db_table = "ts_dingdan"


class Addr(models.Model):
    shui = models.ForeignKey(Goumai, on_delete=models.CASCADE)
    username = models.CharField(max_length=255, null=True, blank=True)
    shouji = models.CharField(max_length=255, null=True, blank=True)
    addr = models.CharField(max_length=255, null=True, blank=True)
    class Meta:
        db_table = "ts_addr"

class Sc(models.Model):
    shui = models.ForeignKey(Goumai,on_delete=models.CASCADE)
    sc_date = models.DateField(null=True, blank=True)
    jingqu = models.ForeignKey(Jingqu,on_delete=models.CASCADE)
    class Meta:
        db_table = "ts_sc"

# 评论表
class Pl(models.Model):
    shui = models.ForeignKey(Goumai,on_delete=models.CASCADE)
    pl_date = models.DateField(null=True, blank=True)
    jingqu = models.ForeignKey(Jingqu,on_delete=models.CASCADE)
    content = models.TextField(null=True,blank=True)
    is_shenhe = models.CharField(max_length=255,null=True,blank=True,default='待审核')
    reply = models.TextField(null=True, blank=True)


    class Meta:
        db_table = "ts_pl"
    
class Notify(models.Model):
    user = models.ForeignKey(Goumai, on_delete=models.CASCADE)
    type = models.CharField(max_length=50)  # 'comment' or 'order'
    content = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "ts_notify"

from django.db import models

class Message(models.Model):
    sender_id = models.IntegerField()
    sender_role = models.CharField(max_length=10)  # user/admin/owner
    receiver_id = models.IntegerField()
    receiver_role = models.CharField(max_length=10)
    content = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = 'ts_message'
