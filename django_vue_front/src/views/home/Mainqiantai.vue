<template>
  <div>
    <el-container>
      <el-header class="el-header">
        <div @click="$router.push('/home/index')" style="cursor: pointer; font-size: 16px; font-weight: bold;">
          首页 / Home
        </div>

        <!-- 根据登录状态显示不同内容 -->
        <div style="margin-left: 900px; margin-right: 20px;">
          <!-- 未登录状态显示登录按钮 -->
          <div v-if="!userInfo || userInfo === 'null'">
            <el-button type="primary" @click="$router.push('/login')">Log In (登录)</el-button>
          </div>

          <!-- 已登录状态显示用户信息和下拉菜单 -->
          <div v-else>
            <el-dropdown>
              <div style="display: flex; align-items: center; justify-content: center;">
                <el-avatar
                  :size="32"
                  :src="userAvatar || defaultAvatar"
                />

                <span style="margin-left:10px; color:#909399;">{{ userInfo }}</span>

                <!-- 🔔 通知红点 -->
                <el-badge :value="unreadCount" :hidden="unreadCount === 0" class="item" style="margin-left: 20px;">
                  <el-button size="small" type="warning" icon="el-icon-bell" @click="$router.push('/home/notify')">通知 (Notifications)</el-button>
                </el-badge>
              </div>

              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item @click="$router.push('/home/usercenter')">User Information(个人中心)</el-dropdown-item>
                  <el-dropdown-item @click="goDashboard">Dashboard(后台首页)</el-dropdown-item>
                  <el-dropdown-item @click="quitLogin()">Log Off(退出后台)</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </div>
        </div>
      </el-header>

      <el-main class="el-main">
        <RouterView />
      </el-main>

      <el-footer>
        <div class="footer-text"> · COMP 693 · Hong Zhang · Student ID: 1157281</div>
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "mainqiantai",
  data() {
    return {
      userInfo: '',
      userInfoid: '',
      isAdmin: '',
      defaultAvatar: 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png',
      userAvatar: '',
      unreadCount: 0
    };
  },
  created() {
    this.userInfo = localStorage.getItem("userInfo");
    this.userInfoid = localStorage.getItem("userInfoid");
    this.isAdmin = localStorage.getItem("isAdmin");

    if (!this.userInfo || this.userInfo === 'null') {
      this.userInfo = null;
    }

    // 获取头像
    if (this.userInfoid && this.isAdmin) {
      axios.get("/api/guanli", {
        params: { id: this.userInfoid, isAdmin: this.isAdmin }
      }).then(res => {
        if (res.data.code === 200 && res.data.data.length > 0) {
          const info = res.data.data[0];
          if (info.img_url) {
            this.userAvatar = info.img_url.startsWith("http")
              ? info.img_url
              : `http://localhost:8000/upimg/${info.img_url}`;
          }
        }
      });
    }

    this.fetchUnreadCount();
  },

  methods: {
    quitLogin() {
      localStorage.clear();
      this.$router.push('/login');
      this.$message.success('退出成功');
    },
    goDashboard() {
      if (this.isAdmin == 1) {
        this.$router.push('/home/admindashboard');
      } else if (this.isAdmin == 2) {
        this.$router.push('/home/businessdashboard');
      } else {
        this.$router.push('/home/userdashboard');
      }
    },
    fetchUnreadCount() {
      const uid = this.userInfoid;
      if (!uid) return;

      axios.get("http://localhost:8000/hello/notify/", {
        params: { user_id: uid }
      }).then(res => {
        if (res.data.code === 200) {
          this.unreadCount = res.data.data.filter(n => !n.is_read).length;
        }
      });
    },
    goNotifyPage() {
      this.$router.push('/notify');
    }
  }
};
</script>

<style>
.el-header {
  height: 56px;
  background-color: #FFF;
  border-bottom: 1px solid #cedce4;
  padding: 0 260px;
  display: flex;
  align-items: center;
  box-sizing: border-box;
  justify-content: space-between;
}

.el-main {
  width: 1130px;
  padding: 10px 0;
  box-sizing: border-box;
  margin: 0 auto;
}

.wh-32 {
  width: 35px;
  height: 35px;
  cursor: pointer;
}

.footer-text {
  text-align: center;
  line-height: 16px;
  font-size: 12px;
  color: #aeaeae;
  padding: 10px 0;
}
</style>
