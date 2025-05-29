<template>
  <div class="notify-wrapper">
    <h2>🔔 我的通知 / My Notifications</h2>

    <el-card>
      <el-table
        v-if="notifications.length > 0"
        :data="notifications"
        style="width: 100%"
        stripe
      >
        <el-table-column prop="type" label="类型 Type" />
        <el-table-column prop="content" label="内容 Content" />
        <el-table-column prop="created_at" label="时间 Time" />
        <el-table-column prop="is_read" label="状态 Status">
          <template #default="scope">
            <el-tag :type="scope.row.is_read ? 'success' : 'danger'">
              {{ scope.row.is_read ? '已读 Read' : '未读 Unread' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作 Action" width="120">
          <template #default="scope">
            <el-button
              size="mini"
              type="primary"
              @click="markAsRead(scope.row.id)"
              v-if="!scope.row.is_read"
            >
              标记为已读 / Mark as Read
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 空数据提示 -->
      <el-empty v-else description="暂无通知 / No notifications yet" />
    </el-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MyNotificationList",
  data() {
    return {
      notifications: [],
    };
  },
  mounted() {
    this.fetchNotifications();
  },
  methods: {
    fetchNotifications() {
      const userId = localStorage.getItem("userInfoid");
      if (!userId) {
        this.$message.warning("请先登录 / Please log in first");
        return;
      }

      axios.get("http://localhost:8000/hello/notify/list/", {
        params: { userId }
        })

        .then((res) => {
          if (res.data.code === 200) {
            this.notifications = res.data.data;
          } else {
            this.$message.error(res.data.message || "加载失败 / Failed to load");
          }
        })
        .catch(() => {
          this.$message.error("请求错误 / Request error");
        });
    },
    markAsRead(id) {
      axios
        .post(`http://localhost:8000/hello/notify/read/${id}/`)
        .then(() => {
          this.$message.success("标记成功 / Marked as read");
          this.fetchNotifications();
        })
        .catch(() => {
          this.$message.error("标记失败 / Failed to mark as read");
        });
    },
  },
};
</script>

<style scoped>
.notify-wrapper {
  padding: 20px;
  min-height: 90vh;
  background: #f9f9f9;
}
</style>
