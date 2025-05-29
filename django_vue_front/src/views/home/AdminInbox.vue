<template>
  <div style="padding: 30px;">
    <h2>📥 管理员聊天收件箱 / Admin Inbox</h2>
    <el-table :data="inbox" border stripe>
      <el-table-column label="对方角色 User Role" prop="role" />
      <el-table-column label="对方ID User ID" prop="id" />
      <el-table-column label="最后一条消息 Last Message" prop="last_message" />
      <el-table-column label="时间 Time" prop="last_time" />
      <el-table-column label="操作 Action">
        <template #default="scope">
          <el-button size="small" type="primary" @click="$router.push('/home/admindashboard/adminchat')">进入聊天 chat</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      inbox: [],
      adminId: localStorage.getItem("user_id") || "0"
    };
  },
  mounted() {
    this.loadInbox();
  },
  methods: {
    loadInbox() {
      axios.get("http://localhost:8000/hello/admin/inbox/", {
        params: { user_id: this.adminId }
      }).then(res => {
        this.inbox = res.data.data || [];
      }).catch(err => {
        console.error("加载收件箱失败", err);
      });
    },
    goToChat(row) {
      this.$router.push({
        path: "/home/adminchat",
        query: {
          id: row.id,
          role: row.role
        }
      });
    }
  }
}
</script>
