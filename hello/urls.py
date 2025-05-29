from django.urls import path, re_path 
from .views import (
    RegistryView, LoginView,
    Lbview, Flview, Dqview, Xtglview, Jqyshview, TestRecommendView,GuanliApiview,GuanlidetailApiview,img_uploadApiview,JingquListAllView,JingquDetailView,JingquManageListView, JingquCreateView,
    JingquUpdateView, JingquDeleteView,JingquMyListView,PlView,AllUsersView,UserDeleteView,PendingCommentListView,PlAuditView,AllCommentListView,DeleteCommentView,MyCommentListView, EditCommentView,AddFavoriteView,
    RemoveFavoriteView, CheckFavoriteView, FavoriteListView, MyOrderListView, AddOrderView, MyAddrListView, AddAddrView,AddrDetailView,UpdateAddrView,DeleteAddrView,
    OrderDetailView,PayOrderView, CancelOrderView,AllOrderListView, OwnerCommentsView, ReplyCommentView, NotifyMarkReadView,
    NotifyListView, LbUploadView, LbDeleteView,LbUpdateView ,SendMessageView,GetMessagesView,InboxView,MarkReadView,OwnerListView,
    AdminListView, UserListView, AdminInboxView, OwnerInboxView
)

urlpatterns = [
    path('register/', RegistryView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),

    # 新增下面这几个接口👇
    path('lb/', Lbview.as_view(), name='lb'),              # 轮播图
    path('lb/upload/', LbUploadView.as_view()),  # 上传轮播图
    path('lb/delete/<int:pk>/', LbDeleteView.as_view()),  # 删除轮播图
    path('lb/update/<int:pk>/', LbUpdateView.as_view()), 

    path("message/send/", SendMessageView.as_view()),
    path('message/list/', GetMessagesView.as_view()),
    path("message/inbox/", InboxView.as_view()),
    path("message/read/<int:pk>/", MarkReadView.as_view()),
    path("admin/inbox/", AdminInboxView.as_view()),

    path("owner/list/", OwnerListView.as_view()),
    path("admin/list/", AdminListView.as_view()),
    path("user/list/", UserListView.as_view()),
    path("owner/inbox/", OwnerInboxView.as_view()), 




    path('fl/', Flview.as_view(), name='fl'),              # 景区分类
    path('dq/', Dqview.as_view(), name='dq'),              # 地区
    path('xtgl/', Xtglview.as_view(), name='xtgl'),        # 协同过滤推荐
    path('jqysh/', Jqyshview.as_view(), name='jqysh'),     # 已审核景区列表
    path('test_recommend/', TestRecommendView.as_view()),

    

    # 修改个人信息接口
    path('guanli/', GuanliApiview.as_view(),name='guanli'),
    re_path('guanli/(?P<pk>\d+)/', GuanlidetailApiview.as_view()),
    path('guanlidetail/<int:pk>/', GuanlidetailApiview.as_view(), name='guanlidetail'),
    path('upload_avatar/', img_uploadApiview.as_view(), name='upload_avatar'),
    path('hello/upload_avatar/', img_uploadApiview.as_view()),
    path('jingqulist/', JingquListAllView.as_view()),  
    path('jingqudetail/<int:pk>/', JingquDetailView.as_view(), name='jingqudetail'),
 
    path('jingqu/manage', JingquManageListView.as_view()),
   
    path('jingqu/update/<int:id>', JingquUpdateView.as_view()),
    path('jingqu/delete/<int:id>', JingquDeleteView.as_view()),


    path('fl/', Flview.as_view(), name='fl'),
    path('jingqu/create', JingquCreateView.as_view(), name='jingqu_create'),  # ✅ 新增景区
    path('jingqu/mylist', JingquMyListView.as_view(), name='jingqu_mylist'),  
    path('pl/', PlView.as_view(), name='pl'), 
    path("pl/reply/", ReplyCommentView.as_view()),
    path("notify/list/", NotifyListView.as_view()),
    path("notify/read/<int:pk>/", NotifyMarkReadView.as_view()),


    path('allusers/', AllUsersView.as_view()),
    
    
    path('userdelete/<int:id>/', UserDeleteView.as_view(), name='user_delete'), 
  
    path('comments/pending/', PendingCommentListView.as_view()),
    path('comment/audit/<int:pk>/', PlAuditView.as_view()),
    path('comments/all/', AllCommentListView.as_view()),
    path('comment/delete/<int:pk>/', DeleteCommentView.as_view()),
    path('comments/my/', MyCommentListView.as_view()),
    path('comment/edit/<int:pk>/', EditCommentView.as_view()),
    path('owner/comments/', OwnerCommentsView.as_view()),



    



    path("sc/add/", AddFavoriteView.as_view()),
    path("sc/delete/", RemoveFavoriteView.as_view()),
    path("sc/check/", CheckFavoriteView.as_view()),  
    path("sc/list/", FavoriteListView.as_view()),
    path('dingdan/my/', MyOrderListView.as_view(), name='my_order'),
    path('dingdan/', AddOrderView.as_view(), name='add_order'),
    path('dingdan/<int:pk>/', OrderDetailView.as_view(), name='order_detail'),
    path('dingdan/pay/<int:pk>/', PayOrderView.as_view(), name='pay_order'),
    path('dingdan/cancel/<int:pk>/', CancelOrderView.as_view(), name='cancel_order'),

    path('addr/my/', MyAddrListView.as_view(), name='my_address'),
    path('addr/', AddAddrView.as_view(), name='add_address'),
    path('addr/detail/', AddrDetailView.as_view(), name='addr_detail'),
    path('addr/update/', UpdateAddrView.as_view(), name='addr_update'),
    path('addr/delete/<int:pk>/', DeleteAddrView.as_view(), name='addr_delete'),
    path('dingdan/all/', AllOrderListView.as_view(), name='all_orders'),

    






]


    






