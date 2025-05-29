<template>
  <div class="admin-dashboard-wrapper">
    <div class="admin-dashboard">
      <!-- 左边菜单栏 Sidebar -->
      <el-card class="dashboard-left">
        <div class="avatar-section">
          <el-avatar
            :size="50"
            :src="adminInfo.avatar || defaultAvatar"
            @error="handleAvatarError"
          />
          <div class="admin-name">{{ adminName || 'Admin 未登录' }}</div>
        </div>

        <!-- 管理员功能区 -->
        <div class="menu-section">
          <div class="section-title">系统管理 / System Management</div>
          <div class="menu-item" @click="$router.push('/home/admindashboard/users')">
            <el-icon><Odometer /></el-icon><span>用户管理 / User Management</span>
          </div>
          
          <div class="menu-item" @click="$router.push('/home/admindashboard/commentreview')"> 
            <el-icon><ChatDotRound /></el-icon><span>评论审核管理 / Audit Comment </span>
          </div>
          <div class="menu-item" @click="$router.push('/home/admindashboard/commentmanage')"> 
            <el-icon><ChatDotRound /></el-icon><span>评论总览管理 / Comment Management</span>
          </div>
          
          <div class="menu-item" @click="$router.push('/home/admindashboard/carouselmanage')">
            <el-icon><Picture /></el-icon><span>轮播管理 / Carousel Management</span>
          </div>
          <div class="menu-item" @click="$router.push('/home/admindashboard/inbox')">
            <el-icon><ChatLineSquare /></el-icon>
            <span>聊天收件箱 / Inbox</span>
          </div>
          <div class="menu-item" @click="$router.push('/home/admindashboard/adminchat')">
            <el-icon><ChatDotRound /></el-icon>
            <span>管理员聊天 / Admin Chat</span>
          </div>
        </div>

        <!-- 系统设置 -->
        <div class="menu-section">
          <div class="section-title">账户设置 / Account Settings</div>
          <div class="menu-item" @click="$router.push('/home/UserCenter')">
            <el-icon><Setting /></el-icon><span>编辑资料 / Edit Profile</span>
          </div>
        </div>
      </el-card>

      <!-- 右边内容区 Right Content -->
      <el-card class="dashboard-right">
        <!-- 仅在首页显示欢迎语 -->
        <div v-if="$route.path === '/home/admindashboard'" class="welcome-text fade-in">
          欢迎你，{{ adminName || 'Administrator' }}！/ Welcome, {{ adminName || 'Administrator' }}!
        </div>

        <!-- 嵌套路由显示具体内容 -->
        <RouterView />
      </el-card>

    </div>
  </div>
</template>

<script>
export default {
  name: "AdminDashboard",
  data() {
    return {
      adminName: '',
      adminInfo: {
        avatar: ''
      },
      defaultAvatar: 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png'
    };
  },
  created() {
    this.adminName = localStorage.getItem('userInfo') || '';
    this.adminInfo.avatar = localStorage.getItem('img_url_touxiang') || '';
  },
  methods: {
    handleAvatarError() {
      this.adminInfo.avatar = this.defaultAvatar;
    }
  }
};
</script>

<style scoped>
.admin-dashboard-wrapper {
  display: flex;
  justify-content: center;
  padding: 40px 0;
}

.admin-dashboard {
  display: flex;
  width: 100%;
  max-width: 1100px;
  gap: 20px;
}

.dashboard-left {
  width: 260px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  padding: 20px;
}

.dashboard-right {
  flex: 1;
  min-height: 500px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  padding: 20px;
  overflow: auto; /* ✅ 加这个确保超出时可滚动 */
}


.avatar-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 30px;
}

.admin-name {
  margin-top: 10px;
  font-weight: bold;
  font-size: 18px;
  color: #152844;
}

.section-title {
  font-weight: bold;
  margin: 20px 0 10px;
  color: #303133;
  font-size: 16px;
}

.menu-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 0;
  cursor: pointer;
  transition: all 0.3s;
}

.menu-item:hover {
  color: #409EFF;
}
.menu-item span {
  font-size: 14px;
  color: #303133;
}

.welcome-text {
  font-size: 26px;
  font-weight: bold;
  color: #333;
}

.fade-in {
  animation: fadeIn 1.2s ease forwards;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
