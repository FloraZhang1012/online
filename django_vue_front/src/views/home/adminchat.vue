<template>
  <div style="padding: 30px;">
    <h2>📨 管理员聊天 / Admin ↔ Owner / User Chat</h2>

    <!-- 选择角色 -->
    <el-select v-model="receiverRole" placeholder="选择聊天对象类型" style="width: 200px; margin-right: 20px" @change="fetchReceivers">
      <el-option label="商家 / Owner" value="owner" />
      <el-option label="用户 / User" value="user" />
    </el-select>

    <!-- 选择接收人 -->
    <el-select v-model="receiverId" placeholder="选择聊天对象 Role username / ID" style="width: 300px" @change="loadMessages">
      <el-option
        v-for="r in receiverList"
        :key="r.id"
        :label="r.username"
        :value="r.id"
      />
    </el-select>

    <!-- 输入框 -->
    <el-input
      v-model="newMessage"
      placeholder="输入消息 / Enter your message"
      style="width: 80%; margin: 20px 0 10px"
      @keyup.enter="sendMessage"
    />
    <el-button type="primary" @click="sendMessage">发送 / Send</el-button>

    <!-- 消息列表 -->
    <div class="message-list" ref="messageList">
      <div
        v-for="msg in messages"
        :key="msg.id"
        :class="msg.sender_id == adminId ? 'sent' : 'received'"
      >
        <b>[{{ msg.sender_role }}]</b> {{ msg.content }}
        <div class="time">{{ msg.created_at }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      adminId: localStorage.getItem('user_id') || '0',
      receiverRole: 'owner', // 默认选中商家
      receiverId: '',
      newMessage: '',
      receiverList: [],
      messages: []
    };
  },
  mounted() {
    this.fetchReceivers(); // 默认加载 owner 列表
  },
  methods: {
    fetchReceivers() {
      this.receiverId = '';
      this.receiverList = [];
      this.messages = [];

      const url = this.receiverRole === 'owner'
        ? 'http://localhost:8000/hello/owner/list/'
        : 'http://localhost:8000/hello/user/list/';  // 确保你后端有这个接口

      axios.get(url)
        .then(res => {
          this.receiverList = Array.isArray(res.data.data) ? res.data.data : [];
        })
        .catch(err => {
          console.error("加载接收人失败", err);
        });
    },
    loadMessages() {
      if (!this.receiverId || !this.adminId || !this.receiverRole) return;

      axios.get('http://localhost:8000/hello/message/list/', {
        params: {
          sender_id: this.adminId,
          sender_role: 'admin',
          receiver_id: this.receiverId,
          receiver_role: this.receiverRole
        }
      }).then(res => {
        this.messages = Array.isArray(res.data.data) ? res.data.data : [];
        this.$nextTick(() => {
          const box = this.$refs.messageList;
          if (box) box.scrollTop = box.scrollHeight;
        });
      }).catch(err => {
        console.error("加载消息失败", err);
      });
    },
    sendMessage() {
      if (!this.newMessage.trim() || !this.receiverId) return;

      axios.post('http://localhost:8000/hello/message/send/', {
        sender_id: this.adminId,
        sender_role: 'admin',
        receiver_id: this.receiverId,
        receiver_role: this.receiverRole,
        content: this.newMessage
      }).then(() => {
        this.newMessage = '';
        this.loadMessages();
      }).catch(err => {
        console.error("发送消息失败", err);
      });
    }
  }
};
</script>

<style scoped>
.message-list {
  margin-top: 20px;
  background: #f9f9f9;
  padding: 15px;
  border-radius: 10px;
  max-height: 500px;
  overflow-y: auto;
  border: 1px solid #ddd;
}
.sent {
  text-align: right;
  margin-bottom: 10px;
  color: #409EFF;
}
.received {
  text-align: left;
  margin-bottom: 10px;
  color: #303133;
}
.time {
  font-size: 12px;
  color: #888;
}
</style>
