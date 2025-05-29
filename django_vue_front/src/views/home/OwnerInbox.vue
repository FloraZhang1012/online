<template>
  <div style="padding: 30px;">
    <h2>📥 商家聊天收件箱 / Owner Chat Inbox</h2>

    <el-table :data="inbox" border stripe>
      <el-table-column label="对方角色 / Role" prop="role" />
      <el-table-column label="对方ID / ID" prop="id" />
      <el-table-column label="最后一条消息 / Last Message" prop="last_message" />
      <el-table-column label="时间 / Time" prop="last_time" />
      <el-table-column label="操作 / Action" width="120">
        <template #default="scope">
          <el-button size="small" type="primary" @click="goToChat(scope.row)">
            进入聊天 / Chat
          </el-button>
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
      ownerId: localStorage.getItem("user_id") || "0"
    };
  },
  mounted() {
    this.loadInbox();
  },
  methods: {
    loadInbox() {
      axios.get("http://localhost:8000/hello/owner/inbox/", {
        params: { user_id: this.ownerId }
      }).then(res => {
        this.inbox = res.data.data || [];
      }).catch(err => {
        console.error("加载收件箱失败 / Failed to load inbox", err);
      });
    },
    goToChat(row) {
      this.$router.push({
        path: "/home/businessdashboard/ownerchat",
        query: {
          id: row.id,
          role: row.role
        }
      });
    }
  }
}
</script>

<style scoped>
h2 {
  margin-bottom: 20px;
}
</style>
