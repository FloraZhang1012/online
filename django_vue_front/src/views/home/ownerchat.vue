<template>
  <div style="padding: 30px;">
    <h2>📨 商家聊天 / Owner ↔ Admin/User Chat</h2>

    <!-- 选择对方角色 -->
    <el-select v-model="receiverRole" placeholder="选择聊天对象类型 / Role" style="width: 200px; margin-right: 20px" @change="fetchReceivers">
      <el-option label="管理员 / Admin" value="admin" />
      <el-option label="用户 / User" value="user" />
    </el-select>

    <!-- 选择聊天对象 -->
    <el-select v-model="receiverId" placeholder="选择聊天对象 / Select Receiver" style="width: 300px" @change="loadMessages">
      <el-option
        v-for="r in receiverList"
        :key="r.id"
        :label="r.username"
        :value="r.id"
      />
    </el-select>

    <!-- 消息输入框 -->
    <el-input
      v-model="newMessage"
      placeholder="输入消息 / Enter your message"
      style="width: 80%; margin: 20px 0 10px"
      @keyup.enter="sendMessage"
    />
    <el-button type="primary" @click="sendMessage">发送 / Send</el-button>

    <!-- 聊天记录 -->
    <div class="message-list" ref="messageList">
      <div
        v-for="msg in messages"
        :key="msg.id"
        :class="msg.sender_id == ownerId ? 'sent' : 'received'"
      >
        <b>[{{ msg.sender_role }}]</b> {{ msg.content }}
        <div class="time">{{ msg.created_at }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { ElMessageBox } from 'element-plus'; // ✅ 引入弹窗

export default {
  data() {
    return {
      ownerId: localStorage.getItem('user_id') || '0',
      receiverRole: 'admin',
      receiverId: '',
      newMessage: '',
      receiverList: [],
      messages: []
    };
  },
  mounted() {
    const { id, role } = this.$route.query;

    if (role && id) {
      this.receiverRole = role;
      this.$nextTick(() => {
        this.fetchReceivers(() => {
          this.receiverId = parseInt(id);
          this.loadMessages();
        });
      });
    } else {
      this.fetchReceivers();

      // ✅ 弹窗提示用户选择聊天对象
      ElMessageBox.alert(
        '请从下拉菜单中选择聊天对象后开始对话。\nPlease select a contact from the dropdown to start chatting.',
        '未选择聊天对象 / No Contact Selected',
        {
          confirmButtonText: '我知道了 / OK',
          type: 'info',
          showClose: false
        }
      );
    }
  },
  methods: {
    fetchReceivers(callback) {
      this.receiverId = '';
      this.receiverList = [];
      this.messages = [];

      const url = this.receiverRole === 'admin'
        ? 'http://localhost:8000/hello/admin/list/'
        : 'http://localhost:8000/hello/user/list/';

      axios.get(url)
        .then(res => {
          this.receiverList = Array.isArray(res.data.data) ? res.data.data : [];
          if (callback) callback();
        }).catch(err => {
          console.error("加载接收人失败", err);
        });
    },
    loadMessages() {
      if (!this.receiverId || !this.receiverRole) return;

      axios.get('http://localhost:8000/hello/message/list/', {
        params: {
          sender_id: this.ownerId,
          sender_role: 'owner',
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
        sender_id: this.ownerId,
        sender_role: 'owner',
        receiver_id: this.receiverId,
        receiver_role: this.receiverRole,
        content: this.newMessage
      }).then(() => {
        this.newMessage = '';
        this.loadMessages();
      }).catch(err => {
        console.error("发送失败", err);
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
