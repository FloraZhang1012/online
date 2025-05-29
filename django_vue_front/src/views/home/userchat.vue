<template>
  <UserLayout>
    <template #default>
      <div class="chat-container">
        <h2>💬 用户聊天 / Chat with Owner or Admin</h2>

        <!-- 选择角色和接收人 -->
        <div class="select-row">
          <el-select v-model="receiverRole" placeholder="选择接收人角色 / Select Role" @change="loadReceivers">
            <el-option label="全部 / All" value="all" />
            <el-option label="商家 / Owner" value="owner" />
            <el-option label="管理员 / Admin" value="admin" />
          </el-select>

          <el-select
            v-if="receiverRole !== 'all'"
            v-model="receiverId"
            placeholder="选择接收人 / Select Receiver"
            style="margin-left: 20px;"
            @change="loadMessages"
          >
            <el-option
              v-for="r in receiverList"
              :key="r.id"
              :label="r.username"
              :value="r.id"
            />
          </el-select>
        </div>

        <!-- 聊天记录 -->
        <div class="message-box" v-if="Array.isArray(messages) && messages.length">
          <div v-for="msg in messages" :key="msg.id" class="message-item">
            <div :class="msg.sender_id == userId ? 'sent' : 'received'">
              <span class="sender">[{{ msg.sender_role }}]</span>
              {{ msg.content }}
              <span class="time">{{ msg.created_at }}</span>
            </div>
          </div>
        </div>

        <!-- 无消息提示 -->
        <div v-else class="no-msg">暂无聊天记录 / No messages yet</div>

        <!-- 输入发送 -->
        <div class="input-row">
          <el-input
            v-model="newMsg"
            type="textarea"
            placeholder="输入消息 / Enter message"
            rows="2"
            style="width: 100%;"
          />
          <el-button
            type="primary"
            @click="sendMessage"
            style="margin-left: 10px;"
            :disabled="!newMsg || receiverRole === 'all' || !receiverId"
          >
            发送 / Send
          </el-button>
        </div>
      </div>
    </template>
  </UserLayout>
</template>

<script>
import axios from "axios";
import UserLayout from "./UserLayout.vue";

export default {
  components: { UserLayout },
  data() {
    return {
      userId: localStorage.getItem("user_id") || "0", // 防止空 userId
      newMsg: "",
      messages: [],
      receiverRole: "all",
      receiverId: null,
      receiverList: []
    };
  },
  mounted() {
    this.loadReceivers(); // 默认就加载聊天记录
  },
  methods: {
    loadReceivers() {
      this.receiverId = null;

      if (this.receiverRole === "all") {
        this.receiverList = [];
        this.loadMessages();
        return;
      }

      const url = this.receiverRole === "owner"
        ? "http://localhost:8000/hello/owner/list/"
        : "http://localhost:8000/hello/admin/list/";

      axios.get(url).then(res => {
        const result = res.data.data;
        this.receiverList = Array.isArray(result) ? result : [];

        if (this.receiverList.length > 0 && this.receiverList[0].id) {
          this.receiverId = this.receiverList[0].id;
          this.loadMessages();
        }
      }).catch((err) => {
        console.error("加载接收人失败", err);
        this.receiverList = [];
      });
    },

    loadMessages() {
      if (!this.userId) return;

      const params = {
        sender_id: this.userId,
        sender_role: "user"
      };

      if (this.receiverRole !== "all" && this.receiverId) {
        params.receiver_id = this.receiverId;
        params.receiver_role = this.receiverRole;
      }

      axios
        .get("http://localhost:8000/hello/message/list/", { params })
        .then((res) => {
          const result = res.data.data;
          this.messages = Array.isArray(result) ? result : [];
        })
        .catch((err) => {
          console.error("加载消息失败", err);
          this.messages = [];
        });
    },

    sendMessage() {
      if (!this.newMsg || !this.receiverId || !this.receiverRole || this.receiverRole === 'all') return;

      axios.post("http://localhost:8000/hello/message/send/", {
        sender_id: this.userId,
        sender_role: "user",
        receiver_id: this.receiverId,
        receiver_role: this.receiverRole,
        content: this.newMsg
      }).then(() => {
        this.newMsg = "";
        this.loadMessages();
      }).catch(err => {
        console.error("发送消息失败", err);
      });
    }
  }
};
</script>

<style scoped>
.chat-container {
  padding: 30px;
  background-color: #fff;
  min-height: 100vh;
}
.select-row {
  display: flex;
  margin-bottom: 20px;
  gap: 10px;
}
.message-box {
  max-height: 400px;
  overflow-y: auto;
  border: 1px solid #eee;
  padding: 10px;
  margin-bottom: 20px;
}
.message-item {
  margin-bottom: 10px;
}
.sent {
  text-align: right;
  color: #409EFF;
}
.received {
  text-align: left;
  color: #303133;
}
.sender {
  font-size: 12px;
  margin-right: 6px;
  opacity: 0.6;
}
.time {
  display: block;
  font-size: 12px;
  opacity: 0.5;
}
.input-row {
  display: flex;
  align-items: flex-start;
  margin-top: 20px;
}
.no-msg {
  color: gray;
  text-align: center;
  margin: 20px 0;
}
</style>
