# -*-coding:utf-8-*-
import math
import os
import django
import operator
import numpy as np
from .models import *





class UserCf:
    # 基于用户协同算法来获取推荐列表
    """
    利用用户的群体行为来计算用户的相关性。
    计算用户相关性的时候我们就是通过对比他们选修过多少相同的课程相关度来计算的
    举例：
    --------+--------+--------+--------+--------+
            |   X    |    Y   |    Z   |    R   |
    --------+--------+--------+--------+--------+
        a   |   1    |    1   |    1   |    0   |
    --------+--------+--------+--------+--------+
        b   |   1    |    0   |    1   |    0   |
    --------+--------+--------+--------+--------+
        c   |   1    |    1   |    0   |    1   |
    --------+--------+--------+--------+--------+

    a用户选修了：X、Y、Z
    b用户选修了：X、Z
    c用户选修了：X、Y、R

    那么很容易看到a用户和b、c用户非常相似，给a用户推荐课程R，
    给b用户推荐课程Y
    给c用户推荐课程Z
    这就是基于用户的协同过滤。
    a用户向量为(1,1,1,0)
    b用户向量为(1,0,1,0)
    c用户向量为(1,1,0,1)
    找a用户的相似用户，则计算a向量与其他向量的夹角即可，夹角越小则说明越相近
    利用求高维空间向量的夹角,可以估计两组数据的吻合程度
    """

    # 获得初始化数据
    def __init__(self, data):
        self.data = data

    # 计算N维向量的夹角
    def calc_vector_cos(self, a, b):
        '''
        cos=(ab的内积)/(|a||b|)
        :param a: 向量a
        :param b: 向量b
        :return: 夹角值
        '''
        a_n = np.array(a)
        b_n = np.array(b)
        if any(b_n) == 0:
            return 0
        cos_ab = a_n.dot(b_n) / (np.linalg.norm(a_n) * np.linalg.norm(b_n))
        return round(cos_ab, 2)


    # 计算与当前用户的距离，获得最临近的用户
    def nearest_user(self, username, n=1):
        distances = {}
        # 用户，相似度
        # 遍历整个数据集
        for user, rate_set in self.data.items():
            # 非当前的用户
            if user != username:
                vector_a = tuple(self.data[username].values())
                vector_b = tuple(self.data[user].values())
                distance = self.calc_vector_cos(vector_a, vector_b)
                # 计算两个用户的相似度
                distances[user] = distance
        # 排序，按向量夹角由小到到排序
        closest_distance = sorted(distances.items(), key=operator.itemgetter(1), reverse=True)
        # 最相似的N个用户
        # print("closest user:", closest_distance[:n])
        return closest_distance[:n]

    # 给用户推荐
    def recommend(self, username, n=1):
        recommend = set()
        # 调用算法 {3: {1: 1, 2: 1, 3: 1}, 1: {1: 0, 2: 0, 3: 1}, 2: {1: 1, 2: 1, 3: 1}, 4: {1: 1, 2: 1, 3: 1}}
        # 最相近的用户是 2 相似度 1.0
        nearest_user = self.nearest_user(username, n) # 获取最相近的n个用户
        print(nearest_user)
        for user_id, _ in nearest_user:
            # 循环相似用户 id
            # 拿到对应当前用户收藏对象
            # 通过相似用户收藏对象.jingqu就可以找到相似用户收藏过的景区
            # 但是还是需要排除当前登录用户已收藏景区 id
            for usercourse in Sc.objects.filter(shui_id=user_id):
                # 登录用户收藏过的景区id排除出去 剩下的景区推荐 username登录用户
                # 3: {1: 1, 2: 1, 3: 1} 所以把当前最相似用户3收藏过的 景区 1 2 3 去掉即可
                if usercourse.jingqu.id not in self.data[username].keys():
                    # print(self.data[username].keys())
                    recommend.add(usercourse.jingqu.id)
        return recommend

def recommend_by_user_id(user_id):
    try: 
        current_user = Goumai.objects.get(id=user_id)

        if current_user.sc_set.count() == 0:
            return Jingqu.objects.all().order_by('-collect_num')[:3]

        data = {}
        course_ids = []
        other_user_ids = set()

        for u_course in current_user.sc_set.all():
            if not data:
                data[current_user.id] = {u_course.jingqu.id: 1}
            else:
                data[current_user.id][u_course.jingqu.id] = 1
            course_ids.append(u_course.jingqu)

            for usercourse in Sc.objects.filter(jingqu=u_course.jingqu):
                if usercourse.shui.id != current_user.id:
                    other_user_ids.add(usercourse.shui.id)

        for other_user in Goumai.objects.filter(pk__in=other_user_ids):
            other_user_id = other_user.id
            for jingqu in course_ids:
                is_select = 1 if Sc.objects.filter(shui_id=other_user_id, jingqu=jingqu).exists() else 0
                if other_user_id not in data:
                    data[other_user_id] = {jingqu.id: is_select}
                else:
                    data[other_user_id][jingqu.id] = is_select

        user_cf = UserCf(data=data)
        recommend_ids = user_cf.recommend(current_user.id, 1)

        if not recommend_ids:
            return Jingqu.objects.all().order_by('-collect_num')[:3]

        return Jingqu.objects.filter(id__in=recommend_ids).order_by('-collect_num')[:3]
    
    except Exception as e:
        print(f"[推荐系统错误] 用户ID: {user_id}，错误信息：{e}")
        return Jingqu.objects.all().order_by('-collect_num')[:3]
    print(current_user.sc_set.all())
    print(data)
    print(other_user_ids)

