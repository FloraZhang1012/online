<template>
    <div class="login-container">
        <el-card class="box-card">
            <div class="login-body">
                <div class="login-title">Django+Vue Tourism Recommendation System</div>
                <div class="login-title">Login</div>
                <el-form ref="form" :model="userForm">
                    <el-input placeholder="Enter Username..." v-model="userForm.accountNumber" class="login-input" />

                    <el-input placeholder="Enter Password..." v-model="userForm.userPassword" class="login-input"
                        @keyup.enter.native="login" show-password />

                    <el-select v-model="userForm.value" clearable placeholder="Select Role" class="login-input">
                        <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
                    </el-select>

                    <div class="login-submit">
                        <el-button type="primary" @click="login">Login</el-button>
                    </div>
                    <div>
                        <span class="register-link">
                            Don't have an account?
                            <router-link to="/register">Register</router-link>
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
    name: "login",
    data() {
        return {
            userForm: {
                accountNumber: '',
                userPassword: '',
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
        login() {
            axios.post("https://online-z16b.onrender.com/hello/login/", {
                username: this.userForm.accountNumber.trim(),
                password: this.userForm.userPassword.trim(),
                value: this.userForm.value
            }).then(res => {
                console.log(res);
                if (res.data.meta.status === 200) {
                    localStorage.setItem("userInfo", res.data.data.username);
                    localStorage.setItem("userInfoid", res.data.data.user_id);
                    localStorage.setItem("user_id", res.data.data.user_id); // ✅ 评论功能用这个字段
                    localStorage.setItem("img_url_touxiang", res.data.data.img_url);
                    localStorage.setItem("jianjie", res.data.data.jianjie);
                    localStorage.setItem("isAdmin", res.data.data.isAdmin);
                    localStorage.setItem("token", res.data.data.token);
                    

                    this.$message.success("Login successful");

                    const role = res.data.data.isAdmin;
                    if (role == 1) {
                        this.$router.push('/home/index');
                    } else if (role == 2) {
                        this.$router.push('home/index');
                    } else if (role == 3) {
                        this.$router.push('/home/index');
                    }
                } else {
                this.$message.error(res.data.meta.message);
                
                    
                }
            });
        },
        toIndex() {
            this.$router.replace({ path: '/home/index' });
        }
    }
}
</script>

<style scoped>
.login-container {
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

.login-body {
    padding: 30px;
    width: 300px;
    height: 100%;
}

.login-title {
    padding-bottom: 30px;
    text-align: center;
    font-weight: 600;
    font-size: 20px;
    color: #409EFF;
    cursor: pointer;
}

.login-input {
    width: 280px;
    margin-bottom: 20px;
}

.login-submit {
    margin-top: 20px;
    display: flex;
    justify-content: center;
}

.register-link a {
    color: #409EFF;  /* Same as warning button color */
    text-decoration: none; /* Remove default underline */
    font-weight: bold;
    margin-left: 10px;
}

.register-link a:hover {
    color: #1c63ab;
    text-decoration: underline; /* Underline on hover */
}

</style>
