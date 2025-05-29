<template>
  <div class="user-center-wrapper">
    <div class="user-center">
      <!-- 左边菜单 -->
      <el-card class="user-left">
        <div class="avatar-section">
          <el-avatar
            :size="50"
            :src="userInfo.avatar || defaultAvatar"
            @error="handleAvatarError"
          />
          <div class="user-name">{{ username || '用户未登录' }}</div>
        </div>

        <div class="menu-section">
          <div class="section-title">订单中心 / Order Center</div>
          <div class="menu-item" @click="$router.push('/home/myorder')">
            <el-icon><List /></el-icon><span>我的订单 / My Orders</span>
          </div>
          <div class="menu-item" @click="$router.push('/home/myfavorite')">
            <el-icon><Link /></el-icon><span>我的收藏 / My Favorites</span>
          </div>
          <div class="menu-item" @click="$router.push('/home/chat')">
              <el-icon><ChatDotRound /></el-icon><span>消息中心 / Message</span>
            </div>
          <div class="menu-item" @click="$router.push('/home/mycomment')">
            <el-icon><Link /></el-icon><span>我的评论 / My Comments</span>
          </div>
          <div class="menu-item" @click="$router.push('/home/myaddress')">
            <el-icon><Link /></el-icon><span>我的地址 / My Addresses</span>
          </div>
        </div>

        <div class="menu-section">
          <div class="section-title">个人设置 / Personal Settings</div>
          <div class="menu-item" @click="$router.push('/home/UserCenter')">
            <el-icon><Odometer /></el-icon><span>编辑资料 / Edit Profile</span>
          </div>
        </div>
      </el-card>

      <!-- 右边动态内容 -->
      <el-card class="user-right">
        <slot />
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  name: "UserLayout",
  data() {
    return {
      username: localStorage.getItem("userInfo") || '',
      userInfo: {
        avatar: localStorage.getItem("avatar") || ''
      },
      defaultAvatar: 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png'
    }
  },
  methods: {
    handleAvatarError() {
      this.userInfo.avatar = this.defaultAvatar
    }
  }
}
</script>

<style scoped>
/* 原有样式不变 */
.user-center-wrapper {
  display: flex;
  justify-content: center;
  padding: 40px 0;
}
.user-center {
  display: flex;
  width: 100%;
  max-width: 1100px;
  gap: 20px;
}
.user-left {
  width: 260px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  padding: 20px;
}
.user-right {
  flex: 1;
  min-height: 500px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  padding: 20px;
}
.avatar-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 30px;
}
.user-name {
  margin-top: 10px;
  font-weight: bold;
  font-size: 18px;
}
.menu-section {
  margin-top: 20px;
}
.section-title {
  font-weight: bold;
  margin: 20px 0 10px;
  color: #303133;
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
</style>