<template>
  <div class="register-container">
      <el-card class="box-card">
          <div class="register-body">
              <div class="register-title">Django+Vue Tourism Recommendation System</div>
              <div class="register-title">Register</div>
              <el-form ref="form" :model="userForm">
                  <el-input placeholder="Enter Username..." v-model="userForm.username" class="register-input" />

                  <el-input placeholder="Enter Password..." v-model="userForm.password" class="register-input"
                      show-password />

                  <el-select v-model="userForm.role" clearable placeholder="Select Role" class="register-input">
                      <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
                  </el-select>

                  <div class="register-submit">
                      <el-button type="primary" @click="register">Register</el-button>
                  </div>
                  <div>
                        <span class="login-link">
                            Already have an account?
                            <router-link to="/login">Login</router-link>
                        </span>
                    </div>

              </el-form>
          </div>
      </el-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "register",
  data() {
    return {
      userForm: {
        username: '',
        password: '',
        role: ''
      },
      options: [
        {
          value: '1',
          label: 'Administrator'
        },
        {
          value: '2',
          label: 'Business Owner'
        },
        {
          value: '3',
          label: 'User'
        }
      ],
    };
  },

  methods: {
    async register() {
      const { username, password, role } = this.userForm;

      if (!username || !password || !role) {
        this.$message.error("Please fill in all fields! / 请填写所有字段！");
        return;
      }

      // ✅ 密码复杂性检查：至少8位，包含大小写字母和数字
      const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;
      if (!regex.test(password)) {
        this.$message.error("Password must be at least 8 characters and include uppercase, lowercase letters and a number. / 密码需至少8位，包含大写、小写字母和数字。");
        return;
      }

      try {
        const response = await axios.post("https://online-z16b.onrender.com/hello/register/", {
          username,
          password,
          value: role
        });

        if (response.data.meta.status === 200) {
          this.$message.success("Registration successful! Redirecting to login... / 注册成功，正在跳转登录页...");
          setTimeout(() => {
            this.$router.push("/login");
          }, 1000);
        } else {
          this.$message.error(response.data.meta.message);
        }
      } catch (error) {
        console.error("Registration failed:", error);
        this.$message.error("An error occurred during registration. / 注册过程中发生错误。");
      }
    }
  }
};
</script>


<style scoped>
.register-container {
  background-image: url('/src/assets/2.jpg'); 
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100%;
}

.register-body {
  padding: 30px;
  width: 300px;
  height: 100%;
}

.register-title {
  padding-bottom: 30px;
  text-align: center;
  font-weight: 600;
  font-size: 20px;
  color: #409EFF;
  cursor: pointer;
}

.register-input {
  width: 280px;
  margin-bottom: 20px;
}

.register-submit {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.login-link a {
    color: #409EFF;  /* Same as warning button color */
    text-decoration: none; /* Remove default underline */
    font-weight: bold;
    margin-left: 10px;
}

.login-link a:hover {
    color: #1c63ab;
    text-decoration: underline; /* Underline on hover */
}
</style>
