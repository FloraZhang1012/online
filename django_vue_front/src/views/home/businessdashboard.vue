<template>
    <div class="business-dashboard-wrapper">
      <div class="business-dashboard">
        <!-- 左边菜单栏 Sidebar -->
        <el-card class="dashboard-left">
          <div class="avatar-section">
            <el-avatar
              :size="50"
              :src="businessInfo.avatar || defaultAvatar"
              @error="handleAvatarError"
            />
            <div class="business-name">{{ businessName || 'Business 未登录' }}</div>
          </div>
  
          <!-- 商家功能区 -->
          <div class="menu-section">
            <div class="section-title">管理中心 / Management Center</div>
            <div class="menu-item" @click="$router.push('/home/businessdashboard/myplaces')">
              <el-icon><List /></el-icon><span>我发布的景区 / My Places</span>
            </div>
            <div class="menu-item" @click="$router.push('/home/businessdashboard/allorders')">
              <el-icon><Link /></el-icon><span>订单管理 / Order Management</span>
            </div>
            <div class="menu-item" @click="$router.push('/home/businessdashboard/OwnerComments')">
              <el-icon><Link /></el-icon><span>评论查看 / View Comments</span>
            </div>
            <div class="menu-item" @click="$router.push('/home/businessdashboard/ownerchat')">
              <el-icon><ChatDotRound /></el-icon>
              <span>商家聊天 / Business Owner Chat</span>
            </div>
            <div class="menu-item" @click="$router.push('/home/businessdashboard/ownerinbox')">
              <el-icon><ChatLineSquare /></el-icon>
              <span>聊天收件箱 / Inbox</span>
            </div>
          </div>
  
          <!-- 账户设置区 -->
          <div class="menu-section">
            <div class="section-title">账户设置 / Account Settings</div>
            <div class="menu-item" @click="$router.push('/home/UserCenter')">
              <el-icon><Odometer /></el-icon><span>编辑资料 / Edit Profile</span>
            </div>
          </div>
        </el-card>
  
        <!-- 右边内容区 Right Content -->
        <el-card class="dashboard-right">
          <div class="welcome-text fade-in">
            欢迎你，{{ businessName || 'Business Owner' }}！/ Welcome, {{ businessName || 'Business Owner' }}!
          </div>
  
          <RouterView />
        </el-card>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: "BusinessDashboard",
    data() {
      return {
        businessName: '',
        businessInfo: {
          avatar: ''
        },
        defaultAvatar: 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png'
      };
    },
    created() {
    this.businessName = localStorage.getItem('userInfo') || '';
    this.businessInfo.avatar = localStorage.getItem('img_url_touxiang') || '';
    },

    methods: {
      handleAvatarError() {
        this.businessInfo.avatar = this.defaultAvatar;
      }
    }
  }
  </script>
  
  <style scoped>
  .business-dashboard-wrapper {
    display: flex;
    justify-content: center;
    padding: 40px 0;
  }
  
  .business-dashboard {
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
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  
  .avatar-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 30px;
  }
  
  .business-name {
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
  