from rest_framework.authentication import BaseAuthentication
from rest_framework import exceptions
import time
from web_project import settings
import jwt
from .models import Guanli,Goumai,Chushou

class TokenAuthtication(BaseAuthentication):
    def authenticate(self, request):
        """
        先获取 header 中的token进行解析在进行校验
            - 获取token检查过期时间是否大于当前时间
        :param request:
        :return:
        """
        try:
            
            token = request.headers.get("Ac-Token")
            
            data = jwt.decode(token, settings.SECRET_KEY, 'HS256')

            if data["exp"] < int(time.time()):
                raise exceptions.AuthenticationFailed("登录超时,请重新登录 please log in agian")
            elif (Guanli.objects.filter(username=data["username"]).count() == 0 and
                  Goumai.objects.filter(username=data["username"]).count() == 0 and
                  Chushou.objects.filter(username=data["username"]).count() == 0):
                raise exceptions.AuthenticationFailed("认证用户不存在 user is not exist")

        except Exception as error:
            print(error)
            raise exceptions.AuthenticationFailed("用户未登录,请登录 Please log in")