import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress"; // 进度条
import "nprogress/nprogress.css";

NProgress.configure({ showSpinner: false });

const routes = [
  {
    path: "/",
    redirect: "/home/index",
    hidden: true,
  },
  {
    path: "/login",
    name: "login",
    meta: { title: "login" },
    component: () => import("@/views/admin/login.vue"),
    hidden: true,
  },
  {
    path: "/register",
    name: "register",
    meta: { title: "register" },
    component: () => import("@/views/admin/register.vue"),
    hidden: true,
  },
  {
    path: "/home",
    name: "mainqiantai",
    component: () => import("@/views/home/Mainqiantai.vue"),
    children: [
      {
        path: "index",
        name: "index",
        meta: { title: "首页" },
        component: () => import("@/views/home/index.vue"),
      },
      {
        path: "usercenter",
        name: "usercenter",
        meta: { title: "user个人中心" },
        component: () => import("@/views/home/UserCenter.vue"),
      },
      {
        path: "userdashboard",
        name: "UserDashboard",
        meta: { title: "用户Dashboard", requiresAuth: true },
        component: () => import("@/views/home/userdashboard.vue"),
      },
      {
        path: "notify",
        name: "MyNotificationList",
        component: () => import("@/views/home/Notification.vue")  
      },

      {
        path: "businessdashboard",
        name: "BusinessDashboard",
        meta: { title: "商家Dashboard", requiresAuth: true },
        component: () => import("@/views/home/businessdashboard.vue"),
        children: [
          {
            path: "myplaces",
            name: "MyPlaces",
            component: () => import("@/views/home/myplaces.vue"),
          },
          {
            path: "allorders",
            name: "AllOrders",
            meta: { title: "所有订单 / All Orders" },
            component: () => import("@/views/home/allorders.vue"),
          },
          
          {
            path: "ownerchat",
            name: "OwnerChat",
            meta: { title: "商家聊天 / Owner Chat", requiresAuth: true },
            component: () => import("@/views/home/ownerchat.vue")
          },
          
          {
            path: "ownercomments",
            name: "OwnerComments",
            component: () => import("@/views/home/OwnerComments.vue")
          },
          {
            path: "ownerinbox",
            name: "OwnerInbox",
            meta: { title: "商家聊天收件箱 / Inbox" },
            component: () => import("@/views/home/OwnerInbox.vue")
          }


        ]
      },
      {
        path: "admindashboard",
        name: "AdminDashboard",
        meta: { title: "管理员Dashboard", requiresAuth: true },
        component: () => import("@/views/home/admindashboard.vue"),
        children: [
                {
            path: "users",
            name: "UsersManagement",
            component: () => import("@/views/home/users.vue"),
          },
          {
            path: "carouselmanage",
            name: "CarouselManage",
            meta: { title: "轮播管理 / Carousel Management" },
            component: () => import("@/views/home/CarouselManage.vue"),
          },
          {
            path: "commentreview",
            name: "CommentReview",
            meta: { title: "评论审核 Comment Review", requiresAuth: true },
            component: () => import("@/views/home/commentreview.vue"),
          },
          
          {
            path: "commentmanage",
            name: "CommentManage",
            meta: { title: "评论总览 / Comment Overview", requiresAuth: true },
            component: () => import("@/views/home/commentmanage.vue"),
          },
          {
            path: "news",
            name: "AdminNews",
            component: () => import("@/views/home/news.vue"), // 如有该页面
          },
          {
            path: "places",
            name: "AdminPlaceReview",
            component: () => import("@/views/home/adminplaces.vue"), // 如有该页面
          },
          {
            path: "profile",
            name: "AdminProfile",
            component: () => import("@/views/home/UserCenter.vue"),
          },
          {
            path: "adminchat",
            name: "AdminChat",
            meta: { title: "管理员聊天 / Admin Chat", requiresAuth: true },
            component: () => import("@/views/home/adminchat.vue")
          },
          {
            path: "inbox",
            name: "AdminInbox",
            meta: { title: "聊天收件箱 / Inbox" },
            component: () => import("@/views/home/AdminInbox.vue")
          }

        ]
      },

      {
        path: "place",
        name: "ScenicSpots",
        component: () => import("@/views/home/place.vue"),
      },
      {
        path: "placedetail",
        name: "placedetail",
        component: () => import("@/views/home/placedetail.vue"),
      },

      {
        path: "mycomment",
        name: "MyComment",
        meta: { title: "我的评论 / My Comments", requiresAuth: true },
        component: () => import("@/views/home/mycomment.vue"),
      },
      {
        path: "myfavorite",
        name: "myfavorite",
        meta: { title: "我的收藏" },
        component: () => import("@/views/home/myfavorite.vue"),
      },
      {
        path: "myorder",
        name: "MyOrder",
        meta: { title: "我的订单 / My Orders", requiresAuth: true },
        component: () => import("@/views/home/myorder.vue"),
      },
      {
        path: "chat",
        name: "UserChat",
        meta: { title: "用户聊天 / Chat", requiresAuth: true },
        component: () => import("@/views/home/userchat.vue")  
      },


      {
        path: "orderdetail",
        name: "OrderDetail",
        component: () => import("@/views/home/orderdetail.vue"),
      },
      {
        path: "myaddress",
        name: "MyAddress",
        meta: { title: "地址管理 / Address Management", requiresAuth: true },
        component: () => import("@/views/home/myaddress.vue"),
      },
      {
        path: "addaddress",
        name: "AddAddress",
        meta: { title: "添加地址 / Add Address" },
        component: () => import("@/views/home/addaddress.vue"),
      },
      {
        path: "editaddress",
        name: "EditAddress",
        meta: { title: "编辑地址 / Edit Address", requiresAuth: true },
        component: () => import("@/views/home/editaddress.vue"),
      }
    ]
  }
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  NProgress.start();
  document.title = to.meta.title || "tourism system";
  next();
});

router.afterEach(() => {
  NProgress.done();
});

export default router;
