<template>
  <div class="owner-comments-wrapper">
    <h2 style="margin-bottom: 20px;">📝 评论总览 / Comments on My Scenic Spots</h2>

    <el-card>
      <el-table :data="comments" stripe border style="width: 100%">
        <el-table-column prop="jingqu_name" label="景区 Scenic Spot" align="center" />
        <el-table-column prop="username" label="评论人 Username" align="center" />
        <el-table-column prop="neirong" label="评论内容 Content" align="center" />
        <el-table-column prop="riqi" label="评论时间 Date" align="center" />
        <el-table-column prop="reply" label="商家回复 / Reply" align="center" />
        <el-table-column label="操作 / Action" width="120">
          <template #default="scope">
            <el-button size="mini" @click="openReplyDialog(scope.row)">回复</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog title="回复评论" v-model="replyDialogVisible">
      <el-input
        type="textarea"
        v-model="replyContent"
        placeholder="写下你的回复内容..."
        rows="4"
      />
      <template #footer>
        <el-button @click="replyDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitReply">提交</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "OwnerComments",
  data() {
    return {
      comments: [],
      replyDialogVisible: false,
      replyContent: '',
      selectedCommentId: null,
    };
  },
  created() {
    this.fetchOwnerComments();
  },
  methods: {
    fetchOwnerComments() {
      const ownerId = localStorage.getItem("userInfoid");
      if (!ownerId) {
        this.$message.warning("请先登录 / Please log in first");
        return;
      }

      axios.get("https://online-z16b.onrender.com/hello/owner/comments/", {
        params: { maijia_id: ownerId }
      })
        .then((res) => {
          if (res.data.code === 200) {
            this.comments = res.data.data;
          } else {
            this.$message.error(res.data.message || "加载评论失败 / Failed to load comments");
          }
        })
        .catch(() => {
          this.$message.error("请求失败，请检查网络 / Request failed");
        });
    },
    openReplyDialog(comment) {
      this.selectedCommentId = comment.id;
      this.replyContent = comment.reply || '';
      this.replyDialogVisible = true;
    },
    async submitReply() {
      if (!this.replyContent.trim()) {
        this.$message.warning('请输入回复内容');
        return;
      }
      try {
        const res = await axios.post('https://online-z16b.onrender.com/hello/pl/reply/', {
          pl_id: this.selectedCommentId,
          reply: this.replyContent
        });
        if (res.data.code === 200) {
          this.$message.success('回复成功');
          this.replyDialogVisible = false;
          this.fetchOwnerComments();
        } else {
          this.$message.error(res.data.message);
        }
      } catch (e) {
        this.$message.error('请求失败');
      }
    }
  }
};
</script>

<style scoped>
.owner-comments-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
}
</style>
