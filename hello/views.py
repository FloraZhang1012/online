from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.hashers import check_password
from django.contrib.auth.hashers import make_password
import datetime
import jwt, re
from web_project import settings
from .models import Guanli, Chushou, Goumai, Pl, Jingqu, Dingdan, Addr, Notify

from .models import Lb
from .Serializer import LbModelSerializers
from django.core.paginator import Paginator

from django.views import View

from django.http import HttpResponse,JsonResponse

from .models import Fenlei
from .Serializer import EsflModelSerializers

from .models import Diqu
from .Serializer import EsdqModelSerializers
from .Serializer import *


from .recommend import recommend_by_user_id
from .models import Jingqu,Sc 
from .Serializer import JqModelSerializers
import os
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt

from django.db.models import F, Q 


@method_decorator(csrf_exempt, name='dispatch')

class img_uploadApiview(View):
    def post(self, request):
        response = {}
        dataduixiang = request.POST.get('data', '')
        file = request.FILES.get('file')

        file_path = os.path.join(settings.MEDIA_ROOT, file.name)

        with open(file_path, 'wb+') as f:
            f.write(file.read())

        # ✅ 如果你想把头像路径保存到数据库，需要找到当前用户，然后更新字段
        # 例如根据传过来的 user id 找到 user，然后设置头像字段
        # 举个例子（你可以改成对应角色）：

        user_id = request.POST.get('user_id')
        isAdmin = request.POST.get('isAdmin')  # 你也可以从前端传这个

        if isAdmin == '3':
            from .models import Goumai
            Goumai.objects.filter(pk=user_id).update(img_url=file.name)
        elif isAdmin == '2':
            from .models import Chushou
            Chushou.objects.filter(pk=user_id).update(img_url=file.name)
        elif isAdmin == '1':
            from .models import Guanli
            Guanli.objects.filter(pk=user_id).update(img_url=file.name)

        # 返回文件名
        response['file'] = file.name
        response['code'] = 0
        response['msg'] = "图片上传成功！"
        return JsonResponse(data={'code': 200, 'message': '上传成功', 'data': response})



class LoginView(APIView):
    def post(self, request):
        ret = {
            "data": {},
            "meta": {
                "status": 200,
                "message": ""
            }
        }
        try:
            username = request.data.get("username")
            password = request.data.get("password")
            value = int(request.data.get("value"))

            print(f"🚀 登录请求 -> username: [{username}], password: [{password}], value: {value}")

            user = None
            if value == 1:
                user = Guanli.objects.filter(username=username).first()
            elif value == 2:
                user = Chushou.objects.filter(username=username).first()
            elif value == 3:
                user = Goumai.objects.filter(username=username).first()

            if user:
                print(f"✅ 找到用户：{user.username}")
                print(f"🧠 数据库存储的密码哈希：{user.password}")
                
                # 新加！直接明文比一下（仅测试用！上线删掉）
                if password == user.password:
                    print("⚠️ 明文密码和数据库字段直接相等！")
                else:
                    print("✅ 明文密码和数据库字段不相等（符合预期）")

                print(f"🔐 check_password结果：{check_password(password, user.password)}")
            else:
                print("❌ 没有找到该用户名！")

            if not user or not check_password(password, user.password):
                ret["meta"]["status"] = 500
                ret["meta"]["message"] = "Invalid username or password."
                return Response(ret)

            # 生成 token
            import datetime
            import jwt
            from web_project import settings

            token_payload = {
                "exp": datetime.datetime.now() + datetime.timedelta(days=1),
                "iat": datetime.datetime.now(),
                "id": user.id,
                "username": user.username,
            }
            token = jwt.encode(token_payload, settings.SECRET_KEY, algorithm="HS256")

            ret["data"] = {
                "token": token,
                "username": user.username,
                "user_id": user.id,
                "isAdmin": value,
                "img_url": user.img_url if hasattr(user, "img_url") else "",
                "jianjie": user.jianjie if hasattr(user, "jianjie") else ""
            }
            ret["meta"]["message"] = "Welcome back! Login successful."
            print("✅ 登录成功，token生成完毕！")
            return Response(ret)

        except Exception as error:
            print("🔥 登录异常：", error)
            ret["meta"]["status"] = 500
            ret["meta"]["message"] = "Server Error"
            return Response(ret)


        
class RegistryView(APIView):
    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
        role = int(request.data.get("value"))  # 判断是管理员、商家还是普通用户

        if not re.match(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$', password):
            return Response({
                "meta": {
                    "status": 400,
                    "message": "密码需至少8位，包含大小写字母和数字 / Password must be at least 8 characters long and include uppercase, lowercase letters and numbers."
                }
            })

        if role == 1:  # 管理员
            if Guanli.objects.filter(username=username).exists():
                return Response({"meta": {"status": 500, "message": "This username is already taken."}})
            user = Guanli.objects.create(username=username, password=make_password(password))

        elif role == 2:  # 商家
            if Chushou.objects.filter(username=username).exists():
                return Response({"meta": {"status": 500, "message": "This username is already taken."}})
            user = Chushou.objects.create(username=username, password=make_password(password))


        else:  # 普通用户
            if Goumai.objects.filter(username=username).exists():
                return Response({"meta": {"status": 500, "message": "This username is already taken."}})
            user = Goumai.objects.create(username=username, password=make_password(password))


        return Response({"meta": {"status": 200, "message": "Registration Successful"}})
    
class GuanliApiview(APIView):
    authentication_classes = []

    def get(self, request):
        user_id = request.GET.get('id')
        isAdmin = request.GET.get('isAdmin')
        nickName = request.GET.get('nickName')

        if user_id and isAdmin:
            if isAdmin == '1':
                user = Guanli.objects.filter(pk=user_id).first()
                if not user:
                    return Response({'code': 404, 'message': '用户不存在'})
                ser = GuanliModelSerializers(user)
                return Response({'code': 200, 'data': [ser.data]})

            elif isAdmin == '2':
                user = Chushou.objects.filter(pk=user_id).first()
                if not user:
                    return Response({'code': 404, 'message': '用户不存在'})
                ser = CsModelSerializers(user)
                return Response({'code': 200, 'data': [ser.data]})

            elif isAdmin == '3':
                user = Goumai.objects.filter(pk=user_id).first()
                if not user:
                    return Response({'code': 404, 'message': '用户不存在'})
                ser = GmModelSerializers(user)
                return Response({'code': 200, 'data': [ser.data]})
        return Response({'code': 400, 'message': '无效身份'})

            


class GuanlidetailApiview(APIView):
    authentication_classes = []

    def put(self, request, pk):
        id_obj = request.data.get('id', '')
        isAdmin = request.data.get('isAdmin', '')
        img_url = request.data.get('img_url', '')
        jianjie = request.data.get('jianjie', '')
        password = request.data.get('password', '')

        try:
            if isAdmin == '2':
                user = Chushou.objects.get(pk=pk)
                print(f"🔵 正在更新，接收到 isAdmin: {isAdmin}, id: {id_obj}")
            elif isAdmin == '3':
                user = Goumai.objects.get(pk=pk)
            else:
                user = Guanli.objects.get(pk=pk)

            # ✅ 如果密码不为空，先校验强度再加密
            if password:
                if not re.match(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$', password):
                    return Response({
                        'code': 400,
                        'message': '密码需至少8位，包含大小写字母和数字 / Password must be at least 8 characters long and include uppercase, lowercase letters and numbers.'
                    })
                user.password = make_password(password)

            if img_url:
                user.img_url = img_url
            if jianjie:
                user.jianjie = jianjie

            user.save()

            return Response(data={
                'code': 200,
                'message': '信息修改成功',
                'data': {
                    'img_url': user.img_url,
                    'jianjie': user.jianjie
                }
            })

        except Exception as e:
            return Response(data={'code': 500, 'message': str(e)})

        
class Lbview(APIView):
    def get(self, request):
        data = Lb.objects.all()
        pageNum = request.GET.get('pageNum', 1)
        pageSize = request.GET.get('pageSize', 10)

        paginator = Paginator(data, pageSize)
        page = paginator.get_page(pageNum)
        ser = LbModelSerializers(instance=page.object_list, many=True)

        return Response({'code': 200, 'zs': paginator.count, 'data': ser.data})
    
@method_decorator(csrf_exempt, name='dispatch')
class LbUploadView(View):
    def post(self, request):
        file = request.FILES.get("file")
        title = request.POST.get("title", "") or file.name  # ✅ 如果没写标题就用文件名

        if not file:
            return JsonResponse({"code": 400, "message": "缺少图片文件 Missing photo"})

        file_path = os.path.join(settings.MEDIA_ROOT, file.name)
        with open(file_path, "wb+") as f:
            f.write(file.read())

        # ✅ 写入数据库
        from .models import Lb
        Lb.objects.create(title=title, img_url=file.name)

        return JsonResponse({
            "code": 200,
            "message": "上传成功 / Upload successful",
            "url": file.name
        })

class LbDeleteView(APIView):
    def delete(self, request, pk):
        try:
            lb = Lb.objects.get(id=pk)
            lb.delete()
            return Response({"code": 200, "message": "删除成功 Sucessfuly Delete"})
        except Lb.DoesNotExist:
            return Response({"code": 404, "message": "图片不存在 Pictures are not exist"})

class LbUpdateView(APIView):
    def put(self, request, pk):
        title = request.data.get("title", "")
        try:
            lb = Lb.objects.get(id=pk)
            lb.title = title
            lb.save()
            return Response({"code": 200, "message": "更新成功 Updating sucessfully"})
        except Lb.DoesNotExist:
            return Response({"code": 404, "message": "图片不存在 Pictures are not exist"})


    
class Flview(APIView):
    def get(self, request):
        data = Fenlei.objects.all()
        ser = EsflModelSerializers(instance=data, many=True)
        return Response({'code': 200, 'data': ser.data})


class Dqview(APIView):
    def get(self, request):
        data = Diqu.objects.all()
        ser = EsdqModelSerializers(instance=data, many=True)
        return Response({'code': 200, 'data': ser.data})
    
class Xtglview(APIView):
    def get(self, request):
        pageNum = request.GET.get('pageNum', 1)
        pageSize = request.GET.get('pageSize', 3)
        userInfoid = request.GET.get('userInfoid', '')

        if userInfoid:
            data = recommend_by_user_id(userInfoid)
        else:
            data = Jingqu.objects.all()[:3]

        paginator = Paginator(data, pageSize)
        page = paginator.get_page(pageNum)
        ser = JqModelSerializers(instance=page.object_list, many=True)

        return Response({'code': 200, 'data': ser.data})




class Jqyshview(APIView):
    def get(self, request):
        data = Jingqu.objects.filter(is_shenhe='已审核')
        pageNum = request.GET.get('pageNum', 1)
        pageSize = request.GET.get('pageSize', 10)
        paginator = Paginator(data, pageSize)
        page = paginator.get_page(pageNum)
        ser = JqModelSerializers(instance=page.object_list, many=True)
        return Response({'code': 200, 'zs': paginator.count, 'data': ser.data})
    



class TestRecommendView(APIView):
    def get(self, request):
        try:
            user_id = request.GET.get('user_id')
            if not user_id:
                return Response({'code': 400, 'message': '请提供 user_id 参数'})

            recommended = recommend_by_user_id(user_id)
            ser = JqModelSerializers(instance=recommended, many=True)
            return Response({'code': 200, 'data': ser.data})
        except Exception as e:
            return Response({'code': 500, 'message': str(e)})


# 景区全部列表接口（前台使用）
class JingquListAllView(APIView):
    authentication_classes = []  # 不需要登录验证

    def get(self, request):
        # 获取所有景区（is_shenhe='已审核'，状态正常）
        students_data = Jingqu.objects.filter(is_shenhe='Approved').order_by('id')


        # 分页参数
        pageNum = request.GET.get('pageNum', '1')
        pageSize = request.GET.get('pageSize', '10')

        # 可以加上前台搜索
        search_name = request.GET.get('name', '')
        if search_name:
            search_name = search_name.strip()
            students_data = students_data.filter(name__icontains=search_name)

        # 分页
        paginator = Paginator(students_data, pageSize)
        page_obj = paginator.get_page(pageNum)
        page_obj_list = page_obj.object_list
        total_count = paginator.count

        # 序列化
        ser = JqModelSerializers(instance=page_obj_list, many=True)
        data = ser.data

        # 返回数据
        return Response({
            'code': 200,
            'zs': total_count,
            'data': data
        })

class JingquDetailView(APIView):
    authentication_classes = []

    def get(self, request, pk):
        try:
            jingqu = Jingqu.objects.get(pk=pk)
            ser = JqModelSerializers(jingqu)
            return Response({'code': 200, 'data': ser.data})
        except Jingqu.DoesNotExist:
            return Response({'code': 404, 'message': '景区不存在'})
        except Exception as e:
            return Response({'code': 500, 'message': str(e)})
        

# 景区后台管理接口（不限制审核状态）
class JingquManageListView(APIView):
    def get(self, request):
        all_data = Jingqu.objects.all().order_by('-id')
        ser = JqModelSerializers(instance=all_data, many=True)
        return Response({'code': 200, 'data': ser.data})


# 管理员添加景区
class JingquCreateView(APIView):
    def post(self, request):
        data = request.data.copy()
        try:
            # 设置默认值（🛡️ 后端兜底）
            data['maijia_id'] = int(data.get('maijia_id'))
            data.setdefault('zhuangtai', 'Available')
            data.setdefault('is_kaifang', 'Open')
            data.setdefault('is_shenhe', 'Pending')

            serializer = JqModelSerializers(data=data)
            if serializer.is_valid():
                serializer.save()
                return Response({'code': 200, 'message': '创建成功', 'data': serializer.data})
            else:
                return Response({'code': 400, 'message': serializer.errors})
        except Exception as e:
            return Response({'code': 500, 'message': str(e)})



# 管理员更新景区信息
class JingquUpdateView(APIView):
    def put(self, request, id):
        try:
            obj = Jingqu.objects.get(id=id)
        except Jingqu.DoesNotExist:
            return Response({'code': 404, 'message': '景区不存在'})

        serializer = JqModelSerializers(instance=obj, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({'code': 200, 'message': '更新成功', 'data': serializer.data})
        return Response({'code': 400, 'message': serializer.errors})


class MyJingquListView(APIView): # 商家只看自己的景区
    def get(self, request):
        user_id = request.GET.get("user_id")
        if not user_id:
            return Response({'code': 400, 'message': '请提供 user_id 参数'})

        data = Jingqu.objects.filter(maijia_id=user_id).order_by('-id')
        ser = JqModelSerializers(instance=data, many=True)
        return Response({'code': 200, 'data': ser.data})
    



class JingquMyListView(APIView):
    def get(self, request):
        user_id = request.GET.get('user_id')
        fenlei_id = request.GET.get('fenlei_id')
        diqu_id = request.GET.get('diqu_id')

        if not user_id:
            return Response({'code': 400, 'message': '请提供 user_id'})

        queryset = Jingqu.objects.filter(maijia_id=user_id)

        if fenlei_id:
            queryset = queryset.filter(fenlei_id=fenlei_id)

        if diqu_id:
            queryset = queryset.filter(diqu_id=diqu_id)

        serializer = JqModelSerializers(queryset, many=True)
        return Response({'code': 200, 'data': serializer.data})
    
class JingquDeleteView(APIView):
    def delete(self, request, id):
        try:
            obj = Jingqu.objects.get(id=id)
            obj.delete()
            return Response({'code': 200, 'message': '删除成功'})
        except Jingqu.DoesNotExist:
            return Response({'code': 404, 'message': '景区不存在'})
        except Exception as e:
            return Response({'code': 500, 'message': str(e)})



from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Pl
import datetime

class PlView(APIView):
    def get(self, request):
        jingqu_id = request.GET.get("jingqu_id")
        limit = request.GET.get("limit")


        if not jingqu_id:
            return Response({'code': 400, 'message': '缺少景区ID Missing ID'})
        
        qs = Pl.objects.filter(jingqu_id=jingqu_id, is_shenhe='Approved').order_by('-pl_date')
        if limit:
            qs = qs[:int(limit)]


        data = []
        for p in qs:
            username = getattr(p.shui, 'username', '匿名游客')
            data.append({
                "id": p.id,
                "username": username,
                "neirong": p.content,
                "riqi": p.pl_date
            })

        return Response({'code': 200, 'data': data})

    def post(self, request):
        jingqu_id = request.data.get("jingqu_id")
        shui_id = request.data.get("shui_id")
        neirong = request.data.get("neirong")

        if not all([jingqu_id, shui_id, neirong]):
            return Response({'code': 400, 'message': '缺少必要字段'})

        try:
            Pl.objects.create(
                jingqu_id=jingqu_id,
                shui_id=shui_id,
                content=neirong,
                pl_date=datetime.date.today(),
                is_shenhe='Pending'
            )
            return Response({'code': 200, 'message': '评论提交成功，等待审核 comment submitted sucessfully, awaiting review'})
        except Exception as e:
            return Response({'code': 500, 'message': f'提交失败: {str(e)}'})




class AllUsersView(APIView):
    def get(self, request):
        try:
            result = []

            for u in Goumai.objects.all():
                result.append({
                    'id': u.id,
                    'username': u.username,
                    'avatar': u.img_url,
                    'role': '游客 Tourist',
                    'intro': u.jianjie or ''
                })

            for u in Chushou.objects.all():
                result.append({
                    'id': u.id,
                    'username': u.username,
                    'avatar': u.img_url,
                    'role': '商家 Business Owner',
                    'intro': u.jianjie or ''
                })

            for u in Guanli.objects.all():
                result.append({
                    'id': u.id,
                    'username': u.username,
                    'avatar': '',
                    'role': '管理员 Administrator',
                    'intro': ''
                })
            page = int(request.GET.get("page", 1))
            page_size = int(request.GET.get("page_size", 10))
            start = (page - 1) * page_size
            end = start + page_size

            return Response({
                'code': 200,
                'data': result,
                'message': '成功获取所有用户 Sucessfully get all users'
            })
        except Exception as e:
            return Response({
                'code': 500,
                'message': f'服务器错误: {str(e)}',
                'data': []
            })
        
class UserDeleteView(APIView):
    def delete(self, request, id):
        role = request.GET.get("role", "")
        try:
            if role == "tourist":
                Goumai.objects.filter(id=id).delete()
            elif role == "business":
                Chushou.objects.filter(id=id).delete()
            elif role == "admin":
                Guanli.objects.filter(id=id).delete()
            else:
                return Response({'code': 400, 'message': f'未知身份: {role}'})

            return Response({'code': 200, 'message': '删除成功'})
        except Exception as e:
            return Response({'code': 500, 'message': str(e)})



from rest_framework.views import APIView
from rest_framework.response import Response
from django.core.paginator import Paginator
from .models import Pl, Jingqu, Goumai

class PendingCommentListView(APIView):
    def get(self, request):
        page_num = int(request.GET.get("pageNum", 1))
        page_size = int(request.GET.get("pageSize", 10))
        
        pending_comments = Pl.objects.filter(is_shenhe="Pending").order_by("-pl_date")
        paginator = Paginator(pending_comments, page_size)
        page = paginator.get_page(page_num)

        data = []
        for item in page:
            try:
                username = Goumai.objects.get(id=item.shui_id).username
                scenic = Jingqu.objects.get(id=item.jingqu_id).name
            except:
                username = "未知用户 / Unknown"
                scenic = "未知景区 / Unknown Spot"

            data.append({
                "id": item.id,
                "username": username,
                "scenic": scenic,
                "comment": item.content,
                "date": item.pl_date.strftime('%Y-%m-%d')
            })

        return Response({
            "data": data,
            "zs": paginator.count
        })


from .models import Notify

class PlAuditView(APIView):
    def put(self, request, pk):
        status = request.data.get("status")  # "Approved" or "Rejected"
        try:
            comment = Pl.objects.get(pk=pk)
            comment.is_shenhe = status
            comment.save()

            # 创建通知
            Notify.objects.create(
                user_id=comment.shui_id,
                type="comment",
                content=f"你的评论已被 You comment has been{'通过 Approved' if status == 'Approved' else '拒绝 Rejected'}",
                is_read=False
            )

            return Response({"message": "操作成功 / Operation successful"})
        except Pl.DoesNotExist:
            return Response({"message": "评论不存在 / Comment not found"}, status=404)




class AllCommentListView(APIView):
    def get(self, request):
        page_num = int(request.GET.get("pageNum", 1))
        page_size = int(request.GET.get("pageSize", 10))
        search = request.GET.get("keyword", "").strip()

        comments = Pl.objects.all().order_by("-pl_date")

        if search:
            user_ids = Goumai.objects.filter(username__icontains=search).values_list("id", flat=True)
            scenic_ids = Jingqu.objects.filter(name__icontains=search).values_list("id", flat=True)
            comments = comments.filter(shui_id__in=user_ids) | comments.filter(jingqu_id__in=scenic_ids)

        paginator = Paginator(comments, page_size)
        page = paginator.get_page(page_num)

        data = []
        for item in page:
            username = Goumai.objects.filter(id=item.shui_id).first()
            scenic = Jingqu.objects.filter(id=item.jingqu_id).first()
            data.append({
                "id": item.id,
                "username": username.username if username else "未知用户 / Unknown",
                "scenic": scenic.name if scenic else "未知景区 / Unknown",
                "comment": item.content,
                "date": item.pl_date,
                "status": item.is_shenhe
            })

        return Response({
            "data": data,
            "total": paginator.count
        })

class DeleteCommentView(APIView):
    def delete(self, request, pk):
        try:
            Pl.objects.get(pk=pk).delete()
            return Response({"message": "删除成功 / Deleted successfully"})
        except Pl.DoesNotExist:
            return Response({"message": "评论不存在 / Comment not found"}, status=404)

class MyCommentListView(APIView):
    def get(self, request):
        user_id = request.GET.get("userId")
        print("🔍 收到 userId:", user_id)
        page_num = int(request.GET.get("pageNum", 1))
        page_size = int(request.GET.get("pageSize", 10))

        comments = Pl.objects.filter(shui_id=user_id)
        print("📦 查询结果:", comments)

        paginator = Paginator(comments, page_size)
        page = paginator.get_page(page_num)

        data = []
        for item in page:
            scenic = Jingqu.objects.filter(id=item.jingqu_id).first()
            data.append({
                "id": item.id,
                "scenic": scenic.name if scenic else "未知景区 / Unknown",
                "jingqu_id": item.jingqu_id, 
                "comment": item.content,
                "date": item.pl_date,
                "status": item.is_shenhe
            })

        return Response({
            "data": data,
            "total": paginator.count
        })
    
class EditRejectedCommentView(APIView):
    def put(self, request, pk):
        try:
            comment = Pl.objects.get(pk=pk)
            if comment.is_shenhe != 'Rejected':
                return Response({"message": "只能修改被拒绝的评论 / Only rejected comments can be edited"}, status=400)
            
            new_content = request.data.get("content")
            if not new_content:
                return Response({"message": "内容不能为空 / Content cannot be empty"}, status=400)

            comment.content = new_content
            comment.is_shenhe = 'Pending'
            comment.save()
            return Response({"message": "修改成功，等待重新审核 / Edited successfully. Awaiting re-review"})
        except Pl.DoesNotExist:
            return Response({"message": "评论不存在 / Comment not found"}, status=404)
        
class EditCommentView(APIView):
    def put(self, request, pk):
        try:
            comment = Pl.objects.get(pk=pk)
            new_content = request.data.get("content")
            if new_content:
                comment.content = new_content
                comment.is_shenhe = "Pending"  # 重新提交后状态重置
                comment.save()
                return Response({"message": "评论已更新并提交审核 / Comment updated and resubmitted"})
            else:
                return Response({"message": "内容不能为空 / Content cannot be empty"}, status=400)
        except Pl.DoesNotExist:
            return Response({"message": "评论不存在 / Comment not found"}, status=404)

# views.py
class OwnerCommentsView(APIView):
    def get(self, request):
        maijia_id = request.GET.get("maijia_id")
        if not maijia_id:
            return Response({"code": 400, "message": "缺少商家ID Missing business owner ID"})

        # 获取该商家名下的所有景区ID
        jingqu_ids = Jingqu.objects.filter(maijia_id=maijia_id).values_list("id", flat=True)

        # 获取这些景区的已审核评论
        comments = Pl.objects.filter(jingqu_id__in=jingqu_ids, is_shenhe="Approved").order_by("-pl_date")

        result = []
        for c in comments:
            result.append({
                "id": c.id,
                "jingqu_id": c.jingqu_id,
                "jingqu_name": getattr(c.jingqu, "name", ""),
                "username": getattr(c.shui, "username", "匿名用户"),
                "neirong": c.content,
                "riqi": c.pl_date,
                "reply": c.reply or "",    
            })

        return Response({"code": 200, "data": result})

class ReplyCommentView(APIView):
    def post(self, request):
        pl_id = request.data.get("pl_id")
        reply = request.data.get("reply")

        if not pl_id or not reply:
            return Response({"code": 400, "message": "缺少评论ID或回复内容 Missing ID or content"})

        try:
            pl = Pl.objects.get(id=pl_id)
            pl.reply = reply
            pl.save()
            return Response({"code": 200, "message": "回复成功 reply sucessfully"})
        except Pl.DoesNotExist:
            return Response({"code": 404, "message": "评论不存在 comment is not exist"})

class AddFavoriteView(APIView):
    def post(self, request):
        print("📥 POST 请求数据：", request.data)
        try:
            user_id = int(request.data.get("userId"))
            jingqu_id = int(request.data.get("jingquId"))
        except (ValueError, TypeError):
            return Response({"message": "参数错误 / Invalid parameters"}, status=400)

        # ✅ 检查用户是否存在
        if not Goumai.objects.filter(id=user_id).exists():
            return Response({"message": "用户不存在 / User does not exist"}, status=400)

        # 防止重复收藏
        if Sc.objects.filter(shui_id=user_id, jingqu_id=jingqu_id).exists():
            return Response({"message": "已收藏 / Already Favorited"}, status=400)

        # 插入收藏记录
        Sc.objects.create(
            shui_id=user_id,
            jingqu_id=jingqu_id,
            sc_date=datetime.date.today()
        )

        # 更新收藏数
        Jingqu.objects.filter(id=jingqu_id).update(collect_num=F("collect_num") + 1)

        return Response({"message": "收藏成功 / Favorited successfully"})




class RemoveFavoriteView(APIView):
    def delete(self, request):
        user_id = request.GET.get("userId")
        jingqu_id = request.GET.get("jingquId")

        # 删除记录
        deleted, _ = Sc.objects.filter(shui_id=user_id, jingqu_id=jingqu_id).delete()

        # 更新收藏数 -1（可选，防止为负）
        if deleted:
            Jingqu.objects.filter(id=jingqu_id).update(collect_num=F("collect_num") - 1)

        return Response({"message": "取消收藏成功 / Unfavorited successfully"})

class FavoriteListView(APIView):
    def get(self, request):
        user_id = request.GET.get("userId")
        if not user_id:
            return Response({"data": [], "message": "缺少用户ID"}, status=400)

        favs = Sc.objects.filter(shui_id=user_id).select_related("jingqu")

        data = []
        for f in favs:
            j = f.jingqu  
            if j:
                data.append({
                    "id": j.id,
                    "name": j.name,
                    "img_url": j.img_url,
                    "price": j.price,
                    "dengji": j.dengji
                })

        return Response({"data": data})


class CheckFavoriteView(APIView):
    def get(self, request):
        user_id = request.GET.get("userId")
        jingqu_id = request.GET.get("jingquId")
        is_favorited = Sc.objects.filter(shui_id=user_id, jingqu_id=jingqu_id).exists()
        return Response({"favorited": is_favorited})





class MyOrderListView(APIView):
    def get(self, request):
        user_id = request.GET.get("userId")
        if not user_id:
            return Response({"code": 400, "message": "请提供用户ID"})

        orders = Dingdan.objects.filter(shui_id=user_id).order_by("-gmsj")
        data = []
        for d in orders:
            data.append({
                "id": d.id,
                "gmsj": d.gmsj,
                "maijia": d.maijia.username if d.maijia_id else '未知用户',
                "title": d.title,
                "img_url": d.img_url,
                "price": d.price,
                "zfzt": d.zfzt,
                "phone": d.phone,
                "addr": d.addr
            })

        return Response({"code": 200, "data": data})




class AddOrderView(APIView):
    def post(self, request):
        try:
            data = request.data
            Dingdan.objects.create(
                gmsj=datetime.date.today(),
                maijia_id=data.get("maijia_id"),  # ✅ 只传 ID，不是整个对象
                title=data.get("title"),
                img_url=data.get("img_url"),
                price=data.get("price"),
                zfzt="Pending Payment",
                phone=data.get("phone"),
                addr=data.get("addr"),
                shui_id=data.get("shui_id")
            )
            return Response({"code": 200, "message": "订单创建成功 / Order created"})
        except Exception as e:
            return Response({"code": 500, "message": f"下单失败：{str(e)}"})



class OrderDetailView(APIView):
    def get(self, request, pk):
        try:
            d = Dingdan.objects.get(pk=pk)
            return Response({
                "code": 200,
                "data": {
                    "id": d.id,
                    "gmsj": d.gmsj,
                    "maijia": d.maijia,
                    "title": d.title,
                    "img_url": d.img_url,
                    "price": d.price,
                    "zfzt": d.zfzt,
                    "phone": d.phone,
                    "addr": d.addr
                }
            })
        except Dingdan.DoesNotExist:
            return Response({"code": 404, "message": "订单不存在"})

class PayOrderView(APIView):
    def post(self, request, pk):
        try:
            order = Dingdan.objects.get(pk=pk)
            order.zfzt = "Paid"
            order.save()
            Notify.objects.create(
                user=order.shui,
                type="order",
                content="你的订单已支付成功"
            )

            return Response({"code": 200, "message": "支付成功 / Payment successful"})
        except Dingdan.DoesNotExist:
            return Response({"code": 404, "message": "订单不存在"})

class CancelOrderView(APIView):
    def delete(self, request, pk):
        try:
            Dingdan.objects.get(pk=pk).delete()
            return Response({"code": 200, "message": "订单取消成功 / Order cancelled"})
        except Dingdan.DoesNotExist:
            return Response({"code": 404, "message": "订单不存在"})
        
# views.py
class AllOrderListView(APIView):
    def get(self, request):
        try:
            maijia_id = request.GET.get("maijia_id")
            if not maijia_id:
                return Response({"code": 400, "message": "请提供商家ID maijia_id"})

            orders = Dingdan.objects.filter(maijia_id=maijia_id).order_by("-gmsj")
            data = []
            for d in orders:
                data.append({
                    "id": d.id,
                    "gmsj": d.gmsj,
                    "maijia": d.maijia.username if d.maijia_id else "未知商家",
                    "title": d.title,
                    "img_url": d.img_url,
                    "price": d.price,
                    "zfzt": d.zfzt,
                    "phone": d.phone,
                    "addr": d.addr
                })
            return Response({"code": 200, "data": data})
        except Exception as e:
            return Response({"code": 500, "message": str(e)})





class MyAddrListView(APIView):
    def get(self, request):
        user_id = request.GET.get("userId")
        if not user_id:
            return Response({"code": 400, "message": "请提供用户ID"})

        addrs = Addr.objects.filter(shui_id=user_id)
        data = []
        for a in addrs:
            data.append({
                "id": a.id,
                "username": a.username,
                "shouji": a.shouji,
                "addr": a.addr
            })
        return Response({"code": 200, "data": data})


class AddAddrView(APIView):
    def post(self, request):
        try:
            data = request.data
            Addr.objects.create(
                username=data.get("username"),
                shouji=data.get("shouji"),
                addr=data.get("addr"),
                shui_id=data.get("shui_id")
            )
            return Response({"code": 200, "message": "地址添加成功 / Address saved"})
        except Exception as e:
            return Response({"code": 500, "message": str(e)})

# 获取单个地址详情
class AddrDetailView(APIView):
    def get(self, request):
        addr_id = request.GET.get("id")
        try:
            addr = Addr.objects.get(id=addr_id)
            return Response({
                "code": 200,
                "data": {
                    "id": addr.id,
                    "username": addr.username,
                    "shouji": addr.shouji,
                    "addr": addr.addr
                }
            })
        except Addr.DoesNotExist:
            return Response({"code": 404, "message": "地址不存在"})

# 更新地址信息
class UpdateAddrView(APIView):
    def put(self, request):
        data = request.data
        try:
            addr = Addr.objects.get(id=data.get("id"))
            addr.username = data.get("username")
            addr.shouji = data.get("shouji")
            addr.addr = data.get("addr")
            addr.save()
            return Response({"code": 200, "message": "地址更新成功 / Address updated"})
        except Addr.DoesNotExist:
            return Response({"code": 404, "message": "地址不存在"})

class DeleteAddrView(APIView):

    def delete(self, request, pk):
        try:
            addr = Addr.objects.get(id=pk)
            addr.delete()
            return Response({"code": 200, "message": "地址删除成功 / Address deleted"})
        except Addr.DoesNotExist:
            return Response({"code": 404, "message": "地址不存在 / Address not found"})
        
# 获取通知列表 / Get Notification List
class NotifyListView(APIView):
    def get(self, request):
        user_id = request.GET.get("userId")  # 从URL参数中获取用户ID / Get user ID from URL
        if not user_id:
            return Response({"code": 400, "message": "缺少用户ID / Missing user ID"})

        notifications = Notify.objects.filter(user_id=user_id).order_by("-created_at")
        data = [
            {
                "id": n.id,
                "type": n.type,
                "content": n.content,
                "is_read": n.is_read,
                "created_at": n.created_at.strftime("%Y-%m-%d %H:%M")
            }
            for n in notifications
        ]
        return Response({"code": 200, "data": data})
        

# 标记通知为已读 / Mark Notification as Read
class NotifyMarkReadView(APIView):
    def post(self, request, pk):
        try:
            notify = Notify.objects.get(pk=pk)
            notify.is_read = True  # 设置为已读 / Set as read
            notify.save()
            return Response({"code": 200, "message": "设置为已读 / Marked as read"})
        except Notify.DoesNotExist:
            return Response({"code": 404, "message": "通知不存在 / Notification not found"})



from .models import Message
from rest_framework.views import APIView
from rest_framework.response import Response
from django.db.models import Q
import datetime
# 发送消息

@method_decorator(csrf_exempt, name='dispatch')
class SendMessageView(APIView):
    def post(self, request):
        data = request.data
        try:
            Message.objects.create(
                sender_id=data.get("sender_id"),
                sender_role=data.get("sender_role"),
                receiver_id=data.get("receiver_id"),
                receiver_role=data.get("receiver_role"),
                content=data.get("content"),
                created_at=datetime.datetime.now()
            )
            return Response({"code": 200, "message": "发送成功 / Message sent"})
        except Exception as e:
            return Response({"code": 500, "message": str(e)})

class GetMessagesView(APIView):
    def get(self, request):
        sender_id = request.GET.get("sender_id")
        sender_role = request.GET.get("sender_role")
        receiver_id = request.GET.get("receiver_id")
        receiver_role = request.GET.get("receiver_role")

        if not sender_id or not sender_role:
            return Response({"code": 400, "message": "缺少发送者信息"})

        if receiver_id and receiver_role:
            
            messages = Message.objects.filter(
                Q(sender_id=sender_id, sender_role=sender_role, receiver_id=receiver_id, receiver_role=receiver_role) |
                Q(sender_id=receiver_id, sender_role=receiver_role, receiver_id=sender_id, receiver_role=sender_role)
            ).order_by("created_at")
        else:
            
            messages = Message.objects.filter(
                Q(sender_id=sender_id, sender_role=sender_role) |
                Q(receiver_id=sender_id, receiver_role=sender_role)
            ).order_by("created_at")

        data = [{
            "id": msg.id,
            "sender_id": msg.sender_id,
            "sender_role": msg.sender_role,
            "receiver_id": msg.receiver_id,
            "receiver_role": msg.receiver_role,
            "content": msg.content,
            "created_at": msg.created_at.strftime('%Y-%m-%d %H:%M')
        } for msg in messages]

        return Response({"code": 200, "data": data})



# 获取收件箱
class InboxView(APIView):
    def get(self, request):
        user_id = request.GET.get("user_id")
        messages = Message.objects.filter(receiver_id=user_id).order_by("-timestamp")
        data = [{
            "id": m.id,
            "from": m.sender_id,
            "role_from": m.sender_role,
            "content": m.content,
            "timestamp": m.created_at.strftime("%Y-%m-%d %H:%M"),

            "is_read": m.is_read
        } for m in messages]
        return Response({"code": 200, "data": data})

# 设置已读
class MarkReadView(APIView):
    def post(self, request, pk):
        try:
            msg = Message.objects.get(id=pk)
            msg.is_read = True
            msg.save()
            return Response({"code": 200, "message": "标记为已读 / Marked as read"})
        except Message.DoesNotExist:
            return Response({"code": 404, "message": "消息不存在 / Message not found"})

class OwnerListView(APIView):
    def get(self, request):
        owners = Chushou.objects.all()
        data = [
            {
                "id": o.id,
                "username": o.username,
                "img_url": o.img_url or ""
            }
            for o in owners
        ]
        return Response({"code": 200, "data": data})

class AdminListView(APIView):
    def get(self, request):
        admins = Guanli.objects.all()
        data = [
            {
                "id": a.id,
                "username": a.username
            }
            for a in admins
        ]
        return Response({"code": 200, "data": data})
    

class UserListView(APIView):
    def get(self, request):
        users = Goumai.objects.all()
        data = [
            {
                "id": u.id,
                "username": u.username
            } for u in users
        ]
        return Response({"code": 200, "data": data})
    
class AdminInboxView(APIView):
    def get(self, request):
        admin_id = request.GET.get("user_id")
        messages = Message.objects.filter(
            Q(receiver_id=admin_id, receiver_role="admin") |
            Q(sender_id=admin_id, sender_role="admin")
        ).order_by('-created_at')

        contact_map = {}  # 每个聊天对方一个 key
        for m in messages:
            # 判断聊天对方是 sender 还是 receiver
            if m.sender_role == "admin":
                key = (m.receiver_id, m.receiver_role)
                name = f"{m.receiver_role}_{m.receiver_id}"
            else:
                key = (m.sender_id, m.sender_role)
                name = f"{m.sender_role}_{m.sender_id}"

            if key not in contact_map:
                contact_map[key] = {
                    "id": key[0],
                    "role": key[1],
                    "last_message": m.content,
                    "last_time": m.created_at.strftime("%Y-%m-%d %H:%M")
                }

        return Response({"code": 200, "data": list(contact_map.values())})

class OwnerInboxView(APIView):
    def get(self, request):
        owner_id = request.GET.get("user_id")
        if not owner_id:
            return Response({"code": 400, "message": "缺少商家ID"})

        messages = Message.objects.filter(
            Q(sender_id=owner_id, sender_role="owner") |
            Q(receiver_id=owner_id, receiver_role="owner")
        ).order_by("-created_at")

        conversation_map = {}
        for msg in messages:
            if msg.sender_role == "owner":
                contact_id = msg.receiver_id
                contact_role = msg.receiver_role
            else:
                contact_id = msg.sender_id
                contact_role = msg.sender_role

            key = f"{contact_role}_{contact_id}"
            if key not in conversation_map:
                conversation_map[key] = {
                    "id": contact_id,
                    "role": contact_role,
                    "last_message": msg.content,
                    "last_time": msg.created_at.strftime("%Y-%m-%d %H:%M")
                }

        return Response({"code": 200, "data": list(conversation_map.values())})

