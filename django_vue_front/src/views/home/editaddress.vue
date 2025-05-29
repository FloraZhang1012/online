<template>
  <UserLayout>
    <template #default>
      <div class="edit-address-wrapper" v-loading="loading">
        <h2 style="margin-bottom: 20px;">✏️ 编辑地址 / Edit Address</h2>

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
              <el-button type="primary" @click="submitForm">💾 保存更改 / Save</el-button>
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
      },
      loading: false
    }
  },
  mounted() {
    this.loadAddress()
  },
  methods: {
    loadAddress() {
      this.loading = true
      const id = this.$route.query.id
      axios.get(`http://localhost:8000/hello/addr/detail/`, {
        params: { id }
      }).then(res => {
        this.form = res.data.data
        this.loading = false
      }).catch(() => {
        this.$message.error("加载地址失败 / Failed to load address")
        this.loading = false
      })
    },
    submitForm() {
      const id = this.$route.query.id
      this.$refs.formRef.validate(valid => {
        if (!valid) return
        axios.put(`http://localhost:8000/hello/addr/update/`, {
          id,
          ...this.form
        }).then(res => {
          this.$message.success(res.data.message || '更新成功 / Updated')
          this.$router.push('/home/myaddress')
        }).catch(() => {
          this.$message.error('更新失败 / Failed to update')
        })
      })
    }
  }
}
</script>

<style scoped>
.edit-address-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
}
</style>
