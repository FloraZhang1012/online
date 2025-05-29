<template>
  <UserLayout>
    <template #default>
      <div class="add-address-wrapper">
        <h2 style="margin-bottom: 20px;">➕ 添加地址 / Add New Address</h2>

        <el-card>
          <el-form :model="form" ref="formRef" label-width="120px">
            <el-form-item label="收件人 / Recipient" prop="username" :rules="[{ required: true, message: '请输入收件人姓名', trigger: 'blur' }]">
              <el-input v-model="form.username" />
            </el-form-item>

            <el-form-item label="手机号码 / Phone" prop="shouji" :rules="[{ required: true, message: '请输入手机号', trigger: 'blur' }]">
              <el-input v-model="form.shouji" />
            </el-form-item>

            <el-form-item label="地址 / Address" prop="addr" :rules="[{ required: true, message: '请输入地址', trigger: 'blur' }]">
              <el-input type="textarea" v-model="form.addr" rows="3" />
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="submitForm">💾 保存地址 / Save</el-button>
              <el-button @click="$router.back()">↩️ 返回 / Back</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </template>
  </UserLayout>
</template>

<script>
import axios from 'axios'
import UserLayout from './UserLayout.vue'

export default {
  components: { UserLayout },
  data() {
    return {
      form: {
        username: '',
        shouji: '',
        addr: ''
      }
    }
  },
  methods: {
    submitForm() {
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        axios.post('http://localhost:8000/hello/addr/', {
          username: this.form.username,
          shouji: this.form.shouji,
          addr: this.form.addr,
          shui_id: localStorage.getItem('user_id')
        }).then(res => {
          this.$message.success(res.data.message || '地址添加成功')
          this.$router.push('/home/myaddress')
        }).catch(() => {
          this.$message.error('添加失败，请稍后重试')
        })
      })
    }
  }
}
</script>

<style scoped>
.add-address-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
}
</style>
