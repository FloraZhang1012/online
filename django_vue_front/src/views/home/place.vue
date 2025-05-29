<template>
  <div class="place-container">
    <el-card class="place-card">
      <h2>🏞️ 全部景区列表 List of All Scenic Spots</h2>

      <div class="place-list">
        <div
          v-for="item in scenicList"
          :key="item.id"
          class="place-item"
          @mouseenter="hoverItem = item.id"
          @mouseleave="hoverItem = null"
          @click="goDetailPage(item.id)"
        >
          <img :src="getImageUrl(item.img_url)" alt="Scenic Image" class="place-image" />
          <div class="place-info">
            <h3>{{ item.name }}</h3>
            <p>🏷️ 等级 Level: {{ item.dengji }} </p>
            <p>📍 位置 Address: {{ item.dizhi }} </p>
            <p>💲 价格 Price: {{ item.price }} NZD/人 person</p>
            <p
              class="place-jianjie"
              :class="{ expanded: hoverItem === item.id }"
            >
              {{ hoverItem === item.id ? item.jianjie : truncateText(item.jianjie, 60) }}
            </p>
          </div>

          <!-- ✅ 评论展示区 -->
          <div class="comment-box" @click.stop>
            <p v-if="item.latest_comment">
              <strong>{{ item.latest_comment.username }}:</strong>
              {{ item.latest_comment.neirong }}
            </p>
            <el-input
              v-model="item.newComment"
              type="textarea"
              placeholder="写下你的评论...leave your comments..."
              rows="2"
              class="comment-input"
            />
            <el-button type="primary" size="small" @click="submitComment(item)">
              提交评论 submit comments
            </el-button>
          </div>
        </div>
      </div>

      <div class="pagination">
        <el-button @click="prevPage" :disabled="pageNum <= 1">上一页 Previous Page</el-button>
        <span style="margin: 0 10px;">第 No {{ pageNum }} 页 Page</span>
        <el-button @click="nextPage" :disabled="!hasMore">下一页 Next Page</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";

const baseURL = "http://localhost:8000";
axios.defaults.baseURL = baseURL;
axios.defaults.timeout = 15000;

export default {
  name: "Place",
  data() {
    return {
      baseURL,
      scenicList: [],
      loading: false,
      pageNum: 1,
      pageSize: 6,
      totalCount: 0,
      hoverItem: null,
      defaultAvatar: 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png'
    };
  },
  created() {
    this.getAllScenicSpots();
  },
  computed: {
    hasMore() {
      return this.pageNum * this.pageSize < this.totalCount;
    }
  },
  methods: {
    async getAllScenicSpots() {
      this.loading = true;
      try {
        const response = await axios.get('/api/jingqulist/', {
          params: { pageNum: this.pageNum, pageSize: this.pageSize },
          withCredentials: true
        });
        this.loading = false;
        if (response.data.code === 200) {
          this.scenicList = response.data.data.map(item => ({
            ...item,
            latest_comment: null,
            newComment: ''
          }));
          this.totalCount = response.data.zs || 0;
          this.loadCommentsForAll();
        } else {
          this.$message.error(response.data.message || "加载景区失败");
        }
      } catch (error) {
        console.error("❌ 加载景区失败:", error);
        this.loading = false;
        this.$message.error("加载失败，请检查网络连接");
      }
    },

    async loadCommentsForAll() {
      for (let item of this.scenicList) {
        try {
          const res = await axios.get(`/api/pl/?jingqu_id=${item.id}`);
          item.latest_comment = res.data.data[0] || null;
        } catch (e) {
          console.warn('获取评论失败：', e);
        }
      }
    },

    submitComment(item) {
      const commentText = item.newComment;
      const userId = localStorage.getItem("user_id");
      if (!commentText || !userId) {
        this.$message.warning('请填写评论内容并确保已登录');
        return;
      }
      axios.post('/api/pl/', {
        jingqu_id: item.id,
        shui_id: userId,
        neirong: commentText
      }).then(() => {
        this.$message.success('评论已提交，等待审核');
        item.newComment = '';
      }).catch(() => {
        this.$message.error('提交失败');
      });
    },

    goDetailPage(id) {
      this.$router.push({ path: "/home/placedetail", query: { id } });
    },

    getImageUrl(fileName) {
      if (!fileName) {
        return this.defaultAvatar;
      }
      return fileName.startsWith('http') ? fileName : `${this.baseURL}/upimg/${fileName}`;
    },

    truncateText(text, length) {
      if (!text) return "";
      return text.length > length ? text.slice(0, length) + "..." : text;
    },

    nextPage() {
      if (this.hasMore) {
        this.pageNum++;
        this.getAllScenicSpots();
      }
    },

    prevPage() {
      if (this.pageNum > 1) {
        this.pageNum--;
        this.getAllScenicSpots();
      }
    }
  }
};
</script>

<style scoped>
.place-container {
  max-width: 1000px;
  margin: 20px auto;
}

.place-card {
  padding: 20px;
  border-radius: 10px;
}

.loading-overlay {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(255, 255, 255, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 10;
}

.place-list {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  margin-top: 20px;
}

.place-item {
  border: 1px solid #eee;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  transition: 0.3s;
}

.place-item:hover {
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.place-image {
  width: 100%;
  height: 180px;
  object-fit: cover;
}

.place-info {
  padding: 10px;
}

.place-info h3 {
  margin: 0 0 5px 0;
}

.place-jianjie {
  color: #666;
  font-size: 13px;
  margin-top: 5px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  max-height: 20px;
  transition: all 0.3s;
}

.place-jianjie.expanded {
  white-space: normal;
  max-height: 300px;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 30px;
}

.comment-box {
  border-top: 1px solid #eee;
  margin-top: 10px;
  padding: 8px 10px;
  font-size: 13px;
  color: #333;
}
.comment-input {
  margin-top: 5px;
  margin-bottom: 5px;
}
</style>