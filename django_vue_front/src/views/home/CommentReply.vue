<template>
  <div class="comment-reply-wrapper">
    <h2 style="margin-bottom: 20px;">💬 评论回复 / Reply to Comments</h2>

    <el-card>
      <el-table :data="comments" stripe border style="width: 100%">
        <el-table-column prop="jingqu_name" label="景区 Scenic Spot" align="center" />
        <el-table-column prop="username" label="评论人 Username" align="center" />
        <el-table-column prop="neirong" label="评论内容 Content" align="center" />
        <el-table-column prop="riqi" label="评论时间 Date" align="center" />
        <el-table-column label="回复操作 / Reply" align="center">
          <template #default="scope">
            <el-input
              v-model="scope.row.reply"
              placeholder="输入回复内容..."
              size="small"
              style="width: 200px; margin-bottom: 5px;"
            />
            <el-button type="primary" size="small" @click="submitReply(scope.row)">回复</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "CommentReply",
  data() {
    return {
      comments: []
    };
  },
  created() {
    this.fetchComments();
  },
  methods: {
    fetchComments() {
      const ownerId = localStorage.getItem("userInfoid");
      axios.get("http://localhost:8000/hello/owner/comments/", {
        params: { maijia_id: ownerId }
      }).then((res) => {
        if (res.data.code === 200) {
          this.comments = res.data.data.map(item => ({ ...item, reply: '' }));
        }
      });
    },
    submitReply(row) {
      if (!row.reply) {
        this.$message.warning("请输入回复内容");
        return;
      }
      axios.post("http://localhost:8000/hello/comment/reply/", {
        pl_id: row.id,
        reply: row.reply
      }).then(res => {
        if (res.data.code === 200) {
          this.$message.success("回复成功");
          row.reply = "";
        } else {
          this.$message.error(res.data.message || "回复失败");
        }
      }).catch(() => {
        this.$message.error("网络错误，回复失败");
      });
    }
  }
};
</script>

<style scoped>
.comment-reply-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
}
</style>
