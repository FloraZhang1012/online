<template>
  <el-card>
    <h2>用户管理 User Management</h2>

    <!-- 搜索栏 -->
    <!-- 搜索栏 -->
    <div style="margin-bottom: 20px; display: flex; gap: 10px; align-items: center;">
    <el-input
        v-model="searchKeyword"
        placeholder="🔍 输入用户名 Username"
        clearable
        style="width: 250px"
    />
    <el-select
        v-model="selectedRole"
        placeholder="👤 选择身份 Role"
        clearable
        style="width: 200px"
    >
        <el-option label="全部 All" value="" />
        <el-option label="游客 Tourist" value="游客 Tourist" />
        <el-option label="商家 Business Owner" value="商家 Business Owner" />
        <el-option label="管理员 Administrator" value="管理员 Administrator" />
    </el-select>
    </div>


    <!-- 用户表格 -->
    <el-table :data="filteredUsers" style="width: 100%" v-loading="loading" stripe border>
        <el-table-column prop="id" label="🆔 ID" width="60" />
        <el-table-column label="🖼️ 头像 Avatar">
            <template #default="scope">
            <el-avatar
                :src="getImg(scope.row.avatar)"
                :size="40"
                shape="circle"
                style="border: 1px solid #ccc;"
            />
            </template>
        </el-table-column>
        <el-table-column prop="username" label="👤 用户名 Username" />
        <el-table-column prop="role" label="🔖 身份 Role" />
        <el-table-column prop="intro" label="📄 简介 Bio" />
        <el-table-column label="⚙️ 操作 Actions" width="220">
        
            <template #default="scope">
                <div style="display: flex; gap: 10px; justify-content: center;">
                <el-button
                    size="small"
                    type="info"
                    style="width: 100px"
                    @click="viewUser(scope.row)"
                >
                    查看详情 Details
                </el-button>
                <el-button
                    size="small"
                    type="danger"
                    style="width: 100px"
                    @click="deleteUser(scope.row)"
                >
                    删除 Delete
                </el-button>
                </div>
            </template>
            

        </el-table-column>
        </el-table>


    <!-- 分页器 -->
    <div style="margin-top: 20px; text-align: right;">
      <el-pagination
        background
        layout="prev, pager, next"
        :page-size="pageSize"
        :total="total"
        v-model:current-page="currentPage"
        @current-change="loadUsers"
    
        />

    </div>

    <!-- 用户详情弹窗 -->
    <el-dialog v-model="detailVisible" title="用户详情 User Details">
      <p><strong>ID:</strong> {{ selectedUser.id }}</p>
      <p><strong>用户名 Username:</strong> {{ selectedUser.username }}</p>
      <p><strong>身份 Role:</strong> {{ selectedUser.role }}</p>
      <p><strong>简介 Bio:</strong> {{ selectedUser.intro }}</p>
      <el-avatar :size="100" :src="getImg(selectedUser.avatar)" style="margin: 10px 0;" />

      <el-upload
        :action="`http://localhost:8000/hello/upload_avatar/`"
        :data="{ user_id: selectedUser.id, isAdmin: getIsAdmin(selectedUser.role) }"
        name="file"
        :show-file-list="false"
        :on-success="handleAvatarSuccess"
      >
        <el-button size="small" type="primary">更换头像 Upload Photo</el-button>
      </el-upload>

      <template #footer>
        <el-button @click="detailVisible = false">关闭 Close</el-button>
      </template>
    </el-dialog>
  </el-card>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'
import { ElMessage } from 'element-plus'
import { ElMessageBox } from 'element-plus'


axios.defaults.baseURL = 'http://localhost:8000'

const users = ref([])
const total = ref(0)
const pageSize = 10
const currentPage = ref(1)
const loading = ref(false)

const searchKeyword = ref('')
const selectedRole = ref('')

const detailVisible = ref(false)
const selectedUser = ref({})

const filteredUsers = computed(() => {
  return users.value.filter(user => {
    return (
      user.username.includes(searchKeyword.value.trim()) &&
      (selectedRole.value === '' || user.role === selectedRole.value)
    )
  })
})

const loadUsers = async (page = 1) => {
  loading.value = true
  try {
    const res = await axios.get(`/api/allusers/?page=${page}&page_size=${pageSize}`)
    if (res.data.code === 200) {
      users.value = res.data.data
      total.value = res.data.total
      currentPage.value = page
    }
  } catch (err) {
    ElMessage.error('加载失败')
  } finally {
    loading.value = false
  }
}

onMounted(() => loadUsers())

const getImg = (img) => {
  return img ? `http://localhost:8000/upimg/${img}` : 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png'
}

const viewUser = (user) => {
  selectedUser.value = { ...user }
  detailVisible.value = true
}

const handleAvatarSuccess = (res) => {
  if (res.code === 200) {
    ElMessage.success('头像上传成功')
    selectedUser.value.avatar = res.data.file
    const u = users.value.find(u => u.id === selectedUser.value.id)
    if (u) u.avatar = res.data.file
  } else {
    ElMessage.error('上传失败')
  }
}

const getIsAdmin = (role) => {
  if (role.includes('管理员')) return 1
  if (role.includes('商家')) return 2
  if (role.includes('游客')) return 3
  return 0
}
const getRoleKey = (label) => {
  if (label.includes('游客')) return 'tourist'
  if (label.includes('商家')) return 'business'
  if (label.includes('管理员')) return 'admin'
  return ''
}


const deleteUser = (user) => {
  ElMessageBox.confirm(
    `确定要删除用户 ${user.username} 吗？`,
    '警告',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  ).then(() => {
    axios
      .delete(`/api/userdelete/${user.id}/?role=${getRoleKey(user.role)}`)

      .then((res) => {
        if (res.data.code === 200) {
          ElMessage.success('删除成功')
          loadUsers(currentPage.value)
        } else {
          ElMessage.error(res.data.message || '删除失败')
        }
      })
      .catch(() => {
        ElMessage.error('网络错误，删除失败')
      })
  })
}

</script>

<style scoped>
.el-avatar {
  border: 1px solid #ddd;
}
.el-button {
  font-weight: 600;
  letter-spacing: 0.5px;
  border-radius: 3px;
}

</style>