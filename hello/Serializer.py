from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from . import models

class GuanliModelSerializers(ModelSerializer):
    """管理员信息模型序列化器"""
    username = serializers.CharField(read_only=True)
    img_url = serializers.SerializerMethodField()

    def get_img_url(self, obj):
        if obj.img_url:
            return f"/upimg/{obj.img_url}"
        return None

    class Meta:
        model = models.Guanli
        fields = '__all__'

class CsModelSerializers(ModelSerializer):
    """老板模型序列化器"""
    class Meta:
        model = models.Chushou
        # fields = ['id','username', 'password', 'jianjie']
        fields = '__all__'

class GmModelSerializers(ModelSerializer):
    """游客模型序列化器"""
    class Meta:
        model = models.Goumai
        # fields = ['id','username', 'password', 'jianjie']
        fields = '__all__'

class EsflModelSerializers(ModelSerializer):
    """分类模型序列化器"""
    class Meta:
        model = models.Fenlei
        # fields = ['id','mingcheng']
        fields = '__all__'

class EsdqModelSerializers(ModelSerializer):
    """地区模型序列化器"""
    class Meta:
        model = models.Diqu
        # fields = ['id','mingcheng']
        fields = '__all__'

class JqModelSerializers(ModelSerializer):
    """景区模型序列化器"""
    # 使用PublishSerializer作为publish字段的嵌套序列化器
    maijia = CsModelSerializers(read_only=True)
    # 使用主键字段类型 并且将publish_id设置为"只写"，也就是读取的时候不会返回！
    maijia_id = serializers.PrimaryKeyRelatedField(queryset=models.Chushou.objects.all(), source='maijia',write_only=True)
    # 使用PublishSerializer作为publish字段的嵌套序列化器
    fenlei = EsflModelSerializers(read_only=True)
    # 使用主键字段类型 并且将publish_id设置为"只写"，也就是读取的时候不会返回！
    fenlei_id = serializers.PrimaryKeyRelatedField(queryset=models.Fenlei.objects.all(), source='fenlei',write_only=True)
    # 使用PublishSerializer作为publish字段的嵌套序列化器
    diqu = EsdqModelSerializers(read_only=True)
    # 使用主键字段类型 并且将publish_id设置为"只写"，也就是读取的时候不会返回！
    diqu_id = serializers.PrimaryKeyRelatedField(queryset=models.Diqu.objects.all(), source='diqu',write_only=True)
    class Meta:
        model = models.Jingqu
        # fields = ['id','title','img_url','miaoshu','price','fbsj','zhuangtai','is_shenhe','maijia','maijia_id','fenlei','fenlei_id']
        fields = '__all__'

class DdModelSerializers(ModelSerializer):
    """订单模型序列化器"""
    # 使用PublishSerializer作为publish字段的嵌套序列化器
    shui = GmModelSerializers(read_only=True)
    # 使用主键字段类型 并且将publish_id设置为"只写"，也就是读取的时候不会返回！
    shui_id = serializers.PrimaryKeyRelatedField(queryset=models.Goumai.objects.all(), source='shui',write_only=True)
    class Meta:
        model = models.Dingdan
        # fields = ['id','gmsj','title','img_url','price','phone','addr','maijia','fhzt','shui','shui_id']
        fields = '__all__'

class DzModelSerializers(ModelSerializer):
    """地址模型序列化器"""
    shui = GmModelSerializers(read_only=True)
    shui_id = serializers.PrimaryKeyRelatedField(queryset=models.Goumai.objects.all(), source='shui',write_only=True)
    class Meta:
        model = models.Addr
        # fields = ['id','username','shouji','addr','shui','shui_id']
        fields = '__all__'

class ScModelSerializers(ModelSerializer):
    """收藏模型序列化器"""
    shui = GmModelSerializers(read_only=True)
    shui_id = serializers.PrimaryKeyRelatedField(queryset=models.Goumai.objects.all(), source='shui',write_only=True)
    jingqu = JqModelSerializers(read_only=True)
    jingqu_id = serializers.PrimaryKeyRelatedField(queryset=models.Jingqu.objects.all(), source='jingqu',write_only=True)
    class Meta:
        model = models.Sc
        # fields = ['id','sc_date','shui','shui_id','jingqu','jingqu_id']
        fields = '__all__'

class PlModelSerializers(ModelSerializer):
    """评论模型序列化器"""
    shui = GmModelSerializers(read_only=True)
    shui_id = serializers.PrimaryKeyRelatedField(queryset=models.Goumai.objects.all(), source='shui',write_only=True)
    jingqu = JqModelSerializers(read_only=True)
    jingqu_id = serializers.PrimaryKeyRelatedField(queryset=models.Jingqu.objects.all(), source='jingqu',write_only=True)
    class Meta:
        model = models.Pl
        fields = '__all__'

class LbModelSerializers(ModelSerializer):
    """轮播模型序列化器"""
    class Meta:
        model = models.Lb
        fields = '__all__'