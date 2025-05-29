<template>
  <UserLayout>
    <template #default>
      <div class="address-wrapper" v-loading="loading">
        <div class="address-header">
          <h2>📬 我的地址 / My Addresses</h2>
          <el-button type="primary" size="small" @click="$router.push('/home/addaddress')">
            ➕ 添加地址 / Add
          </el-button>
        </div>

        <el-card>
          <el-table :data="addresses" stripe border style="width: 100%">
            <el-table-column prop="username" label="收件人 / Recipient" align="center" />
            <el-table-column prop="shouji" label="手机号码 / Phone" align="center" />
            <el-table-column prop="addr" label="地址 / Address" align="center" />
            <el-table-column label="操作 / Actions" align="center" width="180">
              <template #default="scope">
                <el-button
                  type="primary"
                  size="small"
                  @click="editAddress(scope.row)"
                >✏️ 编辑</el-button>
                <el-button
                  type="danger"
                  size="small"
                  @click="deleteAddress(scope.row.id)"
                >🗑️ 删除</el-button>
              </template>
            </el-table-column>
          </el-table>
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
      loading: false,
      addresses: []
    }
  },
  mounted() {
    this.loadAddresses()
  },
  methods: {
    loadAddresses() {
      this.loading = true
      axios.get('http://localhost:8000/hello/addr/my/', {
        params: { userId: localStorage.getItem('user_id') }
      }).then(res => {
        this.addresses = res.data.data
        this.loading = false
      }).catch(() => {
        this.$message.error("地址加载失败 / Failed to load address list")
        this.loading = false
      })
    },
    editAddress(row) {
      this.$router.push({ path: '/home/editaddress', query: { id: row.id, username: row.username, shouji: row.shouji, addr: row.addr } })
    },
    deleteAddress(id) {
      this.$confirm('确认删除该地址？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        axios.delete(`http://localhost:8000/hello/addr/`, {
          params: { id }
        }).then(() => {
          this.$message.success("删除成功")
          this.loadAddresses()
        }).catch(() => {
          this.$message.error("删除失败")
        })
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.address-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
}
.address-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}
</style>
