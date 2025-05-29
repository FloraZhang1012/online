<template>
    <el-button
        type="primary"
        icon="el-icon-check"
        style="margin-bottom: 20px;"
        @click="$router.push('/home/commentmanage')"
        >
        去评论管理页面 / Go to Comment Management
    </el-button>
  <div class="review-container">
    <h2 class="review-title">📝 评论审核 / <b> Audit Comment</b></h2>

    <el-card shadow="never" class="table-card">
      <el-table :data="tableData" border stripe style="width: 100%;">
        <el-table-column prop="username" label="用户名 / Username" align="center" />
        <el-table-column prop="scenic" label="景区 / Scenic Spot" align="center" />
        <el-table-column prop="comment" label="评论内容 / Comment" align="center" />
        <el-table-column prop="date" label="日期 / Date" align="center" />
        <el-table-column label="审核操作 / Audit" align="center" width="280">
          <template #default="scope">
            <div style="display: flex; gap: 10px; justify-content: center;">
            <el-button type="success" size="small" @click="audit(scope.row.id, 'Approved')" plain>
              ✅ 通过 / Approve
            </el-button>
            <el-button type="danger" size="small" @click="audit(scope.row.id, 'Rejected')" plain>
              ❌ 拒绝 / Reject
            </el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-wrapper">
        <el-pagination
          background
          layout="prev, pager, next"
          :page-size="pageSize"
          :total="total"
          @current-change="loadData"
        />
      </div>
    </el-card>
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
    }
  },
  mounted() {
    this.loadData(this.pageNum)
  },
  methods: {
    loadData(page) {
      this.pageNum = page
      axios.get(`http://localhost:8000/hello/comments/pending/?pageNum=${page}&pageSize=${this.pageSize}`)
        .then(res => {
          this.tableData = res.data.data
          this.total = res.data.zs
        })
        .catch(() => {
          this.$message.error("获取评论失败 / Failed to load comments")
        })
    },
    audit(id, status) {
      axios.put(`http://localhost:8000/hello/comment/audit/${id}/`, {
        status,
        isAdmin: localStorage.getItem("isAdmin")
      }).then(res => {
        this.$message.success(res.data.message || '审核成功 / Audit successful')
        this.loadData(this.pageNum)
      }).catch(() => {
        this.$message.error("审核失败 / Audit failed")
      })
    }
  }
}
</script>

<style scoped>
.review-container {
  padding: 10px;
}

.review-title {
  font-size: 22px;
  font-weight: bold;
  margin-bottom: 20px;
}

.table-card {
  border-radius: 12px;
  padding: 20px;
}

.pagination-wrapper {
  text-align: center;
  margin-top: 20px;
}
</style>
