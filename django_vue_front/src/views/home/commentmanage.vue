<template>
    <el-button
        type="primary"
        icon="el-icon-check"
        style="margin-bottom: 20px;"
        @click="$router.push('/home/commentreview')"
        >
        去审核页面 / Go to audit comment
    </el-button>
  <div class="comment-manage">
    <h2>🗂️ 评论管理 / Comment Management</h2>

    <!-- 🔍 搜索 -->
    <div class="search-bar">
      <el-input v-model="searchKeyword" placeholder="搜索用户名或景区名 / Search by username or scenic spot" clearable style="width: 300px;" />
      <el-button type="primary" icon="el-icon-search" @click="loadData(1)">搜索 / Search</el-button>
    </div>

    <!-- 🧾 评论列表 -->
    <el-card>
    <el-table :data="tableData" stripe border style="width: 100%; margin-top: 20px;" empty-text="暂无数据 / No Data">
      <el-table-column prop="username" label="用户名 / Username" align="center" width="100" />
      <el-table-column prop="scenic" label="景区 / Scenic Spot" align="center" />
      <el-table-column prop="comment" label="评论内容 / Comment" align="center"  />
      <el-table-column prop="date" label="日期 / Date" align="center" />
      <el-table-column prop="status" label="状态 / Status" align="center" width="150"/>
      <el-table-column label="操作 / Action" align="center" width="150">
        <template #default="scope">
          <el-button type="danger" size="mini" @click="remove(scope.row.id)">🗑️ 删除 / Delete</el-button>
        </template>
      </el-table-column>

    </el-table>
    </el-card>

    <!-- 🔄 分页 -->
    <div class="pagination-wrapper">
      <el-pagination
        background
        layout="prev, pager, next"
        :page-size="pageSize"
        :total="total"
        @current-change="loadData"
      />
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      tableData: [],
      total: 0,
      pageSize: 10,
      pageNum: 1,
      searchKeyword: ''
    }
  },
  mounted() {
    this.loadData(1)
  },
  methods: {
    loadData(page) {
      this.pageNum = page
      axios.get(`http://localhost:8000/hello/comments/all/`, {
        params: {
          pageNum: page,
          pageSize: this.pageSize,
          keyword: this.searchKeyword
        }
      }).then(res => {
        this.tableData = res.data.data
        this.total = res.data.zs
      }).catch(() => {
        this.$message.error("加载评论失败 / Failed to load comments")
      })
    },
    remove(id) {
      this.$confirm('确定要删除这条评论吗？ / Are you sure to delete this comment?', '提示 / Confirm', {
        confirmButtonText: '确定 / Yes',
        cancelButtonText: '取消 / No',
        type: 'warning'
      }).then(() => {
        axios.delete(`http://localhost:8000/hello/comment/delete/${id}/`).then(res => {
          this.$message.success(res.data.message || "删除成功 / Deleted successfully")
          this.loadData(this.pageNum)
        })
      }).catch(() => {
        // 用户取消
      })
    }
  }
}
</script>

<style scoped>
.comment-manage {
  padding: 30px 40px; /* 增加整体留白 */
  background-color: #f9f9f9;
  min-height: 100vh;  /* 高度撑满页面 */
}

.search-bar {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 20px;
  
}

.el-card {

  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  background-color: #fff;
  width:100%;
}

.el-table {
  min-height: 400px;
}

.pagination-wrapper {
  margin-top: 30px;
  text-align: center;
}
</style>
