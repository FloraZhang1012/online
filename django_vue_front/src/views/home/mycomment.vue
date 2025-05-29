<template>
  <UserLayout>
    <template #default>
      <div class="comments-wrapper" v-loading="loading">
        <h2 style="margin-bottom: 30px;">💬 我的评论 / My Comments</h2>

        <el-card class="comment-card">
          <div class="table-container">
            <el-table :data="tableData" stripe border style="width: 100%; font-size: 14px;">
              <el-table-column label="景区 / Scenic Spot" align="center">
                <template #default="scope">
                  <span
                    class="scenic-link"
                    @click="$router.push(`/home/placedetail?id=${scope.row.jingqu_id}`)"
                  >
                    🔗 {{ scope.row.scenic }}
                  </span>
                </template>
              </el-table-column>


              <el-table-column prop="comment" label="评论内容 / Comment" align="center" />
              <el-table-column prop="date" label="日期 / Date" align="center" />
              <el-table-column prop="status" label="审核状态 / Status" align="center">
                <template #default="scope">
                  <span v-if="scope.row.status === 'Approved'" style="color: green;">✅ 通过 / Approved</span>
                  <span v-else-if="scope.row.status === 'Rejected'" style="color: red;">❌ 拒绝 / Rejected</span>
                  <span v-else style="color: orange;">⏳ 待审核 / Pending</span>
                </template>
              </el-table-column>

              <el-table-column label="操作 / Action" align="center" width="160">
                <template #default="scope">
                  <el-button
                    v-if="scope.row.status === 'Rejected'"
                    type="warning"
                    size="mini"
                    @click="startEdit(scope.row)"
                  >✏️ 编辑 / Edit</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>

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

        <!-- 编辑弹窗 -->
        <el-dialog title="编辑评论 / Edit Comment" v-model="dialogVisible" width="500px">
          <el-input
            type="textarea"
            v-model="editContent"
            placeholder="请输入新内容 / Enter new content"
            rows="4"
          />
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="dialogVisible = false">取消 / Cancel</el-button>
              <el-button type="primary" @click="submitEdit">确定 / Submit</el-button>
            </span>
          </template>
        </el-dialog>
      </div>
    </template>
  </UserLayout>
</template>

<script>
import axios from 'axios'
import UserLayout from './UserLayout.vue'

export default {
  components: {
    UserLayout
  },
  data() {
    return {
      tableData: [],
      pageSize: 10,
      pageNum: 1,
      total: 0,
      dialogVisible: false,
      editContent: '',
      editingId: null
    }
  },
  mounted() {
    this.loadData(1)
  },
  methods: {
    loadData(page) {
      this.pageNum = page
      const userId = localStorage.getItem("user_id")
      axios.get(`http://localhost:8000/hello/comments/my/`, {
        params: {
          userId,
          pageNum: page,
          pageSize: this.pageSize
        }
      }).then(res => {
        this.tableData = res.data.data
        this.total = res.data.zs
      }).catch(() => {
        this.$message.error("加载评论失败 / Failed to load comments")
      })
    },
    startEdit(row) {
      this.editingId = row.id
      this.editContent = row.comment
      this.dialogVisible = true
    },
    submitEdit() {
      axios.put(`http://localhost:8000/hello/comment/edit/${this.editingId}/`, {
        content: this.editContent
      }).then(res => {
        this.$message.success(res.data.message || '修改成功 / Edit success')
        this.dialogVisible = false
        this.loadData(this.pageNum)
      }).catch(() => {
        this.$message.error('修改失败 / Edit failed')
      })
    }
  }
}
</script>

<style scoped>
.comments-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
  max-width: 100%;
}

.comment-card {
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  background-color: white;
  max-width: 100%;
  overflow-x: auto;
}

.table-container {
  overflow-x: auto;
  width: 100%;
}

.pagination-wrapper {
  margin-top: 20px;
  text-align: center;
}
</style>
