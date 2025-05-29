<template>
  <div class="user-center-container">
    <el-card class="user-info-card">
      <div v-if="loading" class="loading-overlay">
        <el-loading></el-loading>
      </div>

      <div class="user-header">
        <div class="user-avatar">
          <el-avatar :src="userInfo.avatar || defaultAvatar" @error="handleAvatarError" />
        </div>
        <div class="user-title">
          <h2>{{ userInfo.username || 'User Name 用户名' }}</h2>
          <p>{{ userTypeText }}</p>
        </div>
      </div>

      <div v-if="!isEditMode">
        <div class="user-profile">
          <p><strong>Bio/个人简介：</strong>{{ userInfo.jianjie !== '' ? userInfo.jianjie : 'No Info... (暂无个人简介)' }}</p>
          <el-button type="primary" @click="startEditMode">Edit Info / 修改资料</el-button>
        </div>
      </div>

      <div v-else>
        <el-form :model="userForm" label-width="100px" class="user-form">
          <el-form-item label="Username/用户名">
            <el-input v-model="userForm.username" disabled></el-input>
          </el-form-item>
          <el-form-item label="Change Password/更改密码">
            <el-input v-model="userForm.password" type="password" placeholder="Type new password/输入新密码"></el-input>
          </el-form-item>
          <el-form-item label="Confirm Password/确认密码">
            <el-input v-model="userForm.confirmPassword" type="password" placeholder="Confrim new password/再次输入新密码"></el-input>
          </el-form-item>
          <el-form-item label="Bio/个人简介">
            <el-input v-model="userForm.jianjie" type="textarea" :rows="4" placeholder="Please type Bio/请输入个人简介"></el-input>
          </el-form-item>
          <el-form-item label="Upload Selfie/上传头像">
            <el-upload
              class="avatar-uploader"
              :action="`${baseURL}/hello/upload_avatar/`"
              name="file"
              :data="uploadData"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload"
            >
              <img v-if="userForm.avatar" :src="userForm.avatar" class="avatar" @error="handleFormAvatarError" />
              <div v-else class="avatar-uploader-icon">上传</div>
            </el-upload>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="saveUserInfo">Save/保存信息</el-button>
            <el-button @click="cancelEdit">Cancel/取消</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
  </div>
</template>

<script>
import axios from 'axios';

const baseURL = 'http://localhost:8000';
axios.defaults.baseURL = baseURL;
axios.defaults.timeout = 15000;

export default {
  name: "UserCenter",
  data() {
    return {
      baseURL,
      isEditMode: false,
      defaultAvatar: 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png',
      uploadData: {},
      userInfo: { username: '', avatar: '', isAdmin: 0, jianjie: '', id: '' },
      userForm: { username: '', password: '', confirmPassword: '', jianjie: '', avatar: '' },
      loading: false
    };
  },
  computed: {
    userTypeText() {
      const adminMap = { 
        "1": "系统管理员", 
        "2": "商家用户 business owner",   // ✨新加的
        "3": "旅游用户 tourist user" 
      };
      return adminMap[this.userInfo.isAdmin] || "普通用户";
    }

  },
  created() {
    this.initUserData();
  },
  methods: {
    initUserData() {
      const userId = localStorage.getItem("userInfoid");
      const isAdmin = localStorage.getItem("isAdmin");
      const username = localStorage.getItem("userInfo");
      if (!userId) return this.$router.push("/login");

      this.uploadData = { user_id: userId, isAdmin };
      this.userInfo = { ...this.userInfo, username, isAdmin, id: userId };
      this.fetchUserData(userId);
    },

    fetchUserData(userId) {
      const isAdmin = localStorage.getItem("isAdmin");

      axios.get(`/api/guanli`, { 
        params: { id: userId, isAdmin }, 
        withCredentials: true 
      })
      .then(response => {
        this.loading = false;
        if (response.data.code === 200 && response.data.data.length > 0) {
          const userData = response.data.data[0];

          let avatarPath = this.defaultAvatar;
          if (userData.img_url) {
            avatarPath = userData.img_url.startsWith('http') 
              ? userData.img_url 
              : `${this.baseURL}/upimg/${userData.img_url}`;
          }

          this.userInfo = {
            ...this.userInfo,
            jianjie: userData.jianjie != null ? userData.jianjie : '',
            avatar: avatarPath
          };

          this.resetFormData(); 
        }
      })
      .catch(err => {
        console.error("❌ 请求用户信息失败", err);
        this.loading = false;
      });
    },

    resetFormData() {
      this.userForm = {
        username: this.userInfo.username,
        password: '',
        confirmPassword: '',
        jianjie: this.userInfo.jianjie,
        avatar: this.userInfo.avatar
      };
    },

    startEditMode() {
      this.resetFormData();
      this.isEditMode = true;
    },

    cancelEdit() {
      this.resetFormData();
      this.isEditMode = false;
    },

    handleAvatarError() {
      this.userInfo.avatar = this.defaultAvatar;
    },

    handleFormAvatarError() {
      this.userForm.avatar = this.defaultAvatar;
    },

    beforeAvatarUpload(file) {
      const isImage = file.type.startsWith('image/');
      const isLt2M = file.size / 1024 / 1024 < 2;
      if (!isImage) this.$message.error('只能上传图片格式! / Only image formats are allowed!');
      if (!isLt2M) this.$message.error('图片大小不能超过 2MB! / Image size must be less than 2MB!');
      return isImage && isLt2M;
    },

    handleAvatarSuccess(response) {
      if (response.code === 200) {
        const fileName = response.data.file;
        const url = `${this.baseURL}/upimg/${fileName}`;
        this.userForm.avatar = url;
        this.userInfo.avatar = url;
        this.updateAvatar(fileName);
        this.$message.success("头像上传成功");
      } else {
        this.$message.error("上传失败: " + (response.message || "未知错误"));
      }
    },

    updateAvatar(fileName) {
      const userId = this.userInfo.id;
      const isAdmin = this.userInfo.isAdmin;  // ✨补上 isAdmin
      axios.put(`/api/guanlidetail/${userId}/`, { id: userId, img_url: fileName, isAdmin })
        .then(res => { 
          if (res.data.code === 200) {
            console.log("✅ 头像更新成功");
          }
        })
        .catch(() => {
          console.error("❌ 更新头像失败");
        });
    },

    saveUserInfo() {
      if (this.userForm.password && this.userForm.password !== this.userForm.confirmPassword) {
        this.$message.error("两次输入的密码不一致 / Passwords do not match");
        return;
      }
      const userId = this.userInfo.id;
      const updateData = {
        id: userId,
        userInfoid: userId,
        isAdmin: this.userInfo.isAdmin,
        jianjie: this.userForm.jianjie
      };
      if (this.userForm.avatar && this.userForm.avatar !== this.defaultAvatar) {
        updateData.img_url = this.userForm.avatar.split('/upimg/').pop();
      }
      if (this.userForm.password) {
        updateData.password = this.userForm.password;
      }

      axios.put(`/api/guanlidetail/${userId}/`, updateData)
        .then(res => {
          if (res.data.code === 200) {
            this.$message.success("保存成功 / Saved successfully");
            this.userInfo.jianjie = this.userForm.jianjie;
            this.userInfo.avatar = this.userForm.avatar;
            this.cancelEdit();
          } else {
            this.$message.error(res.data.message || "保存失败 / Save failed");
          }
        })
        .catch(() => {
          this.$message.error("保存失败，请检查网络连接 / Save failed, please check your network");
        });
    }
  }
};
</script>


<style scoped>
.user-center-container {
  max-width: 800px;
  margin: 20px auto;
}
.user-info-card {
  border-radius: 8px;
  position: relative;
}
.loading-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(255, 255, 255, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 10;
}
.user-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #f0f0f0;
}
.user-avatar {
  margin-right: 20px;
}
.user-title h2 {
  margin: 0 0 5px 0;
  font-size: 22px;
}
.user-title p {
  margin: 0;
  color: #909399;
}
.user-form {
  max-width: 500px;
}
.user-profile {
  padding: 10px 0;
}
.avatar-uploader {
  display: inline-block;
  width: 80px;
  height: 80px;
  border: 1px dashed #d9d9d9;
  border-radius: 50%;
  cursor: pointer;
  overflow: hidden;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  line-height: 80px;
  text-align: center;
}
.avatar {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}
</style>
