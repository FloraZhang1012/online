<template>
  <el-button
    :type="isCollected ? 'danger' : 'primary'"
    :icon="isCollected ? 'el-icon-star-on' : 'el-icon-star-off'"
    size="small"
    @click="toggleCollect"
    plain
  >
    {{ isCollected ? '取消收藏 / Unfavorite' : '收藏 / Favorite' }}
  </el-button>
</template>

<script>
import axios from 'axios'

export default {
  props: {
    jingquId: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      isCollected: false,
      userId: localStorage.getItem("user_id")
    }
  },
  mounted() {
    this.checkIfCollected()
  },
  methods: {
    checkIfCollected() {
      axios.get(`http://localhost:8000/hello/sc/check/`, {
        params: {
          userId: this.userId,
          jingquId: this.jingquId
        }
      }).then(res => {
        this.isCollected = res.data.favorited
      })
    },
    toggleCollect() {
      if (!this.userId) {
        this.$message.warning("请先登录 / Please log in");
        return;
      }

      if (this.isCollected) {
        // 使用 DELETE 方法
        axios.delete(`http://localhost:8000/hello/sc/delete/`, {
          params: {
            userId: this.userId,
            jingquId: this.jingquId
          }
        }).then(res => {
          this.isCollected = false
          this.$message.success(res.data.message)
        }).catch(() => {
          this.$message.error("取消收藏失败 / Failed to unfavorite")
        })
      } else {
        // 使用 POST 方法收藏
        axios.post(`http://localhost:8000/hello/sc/add/`, {
          userId: this.userId,
          jingquId: this.jingquId
        }).then(res => {
          this.isCollected = true
          this.$message.success(res.data.message)
        }).catch(() => {
          this.$message.error("收藏失败 / Failed to favorite")
        })
      }
    }
  }
}
</script>
