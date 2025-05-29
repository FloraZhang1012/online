<template>
  <UserLayout>
    <template #default>
      <div class="placedetail-container">
        <!-- 🔵 返回按钮 -->
        <el-button type="primary" @click="goBack" class="back-button">
          ← 返回景区列表 / Back to Scenic List
        </el-button>

        <el-card class="placedetail-card">
          <div v-if="loading" class="loading-overlay">
            <el-loading></el-loading>
          </div>

          <div v-if="detail">
            <img :src="getImageUrl(detail.img_url)" alt="Scenic Image" class="detail-image" />
            <div style="display: flex; justify-content: space-between; align-items: center;">
              <h2>{{ detail.name }}</h2>
              <FavoriteButton :jingquId="detail.id" />
            </div>

            <p>🏷️ 等级 Level: {{ detail.dengji }}</p>
            <p>📍 地址 Address: {{ detail.dizhi }}</p>
            <p>💲 价格 Price: {{ detail.price }} NZD/人 person</p>
            <p class="detail-jianjie">📝 简介 Introduction:</p>
            <p>{{ detail.jianjie }}</p>

            <el-button type="success" style="margin-top: 20px;" @click="createOrder">
              🛒 立即下单 / Order Now
            </el-button>
          </div>

          <div v-if="plList.length > 0" style="margin-top: 40px; text-align: left;">
            <h3>📢 用户评论 / Comments</h3>
            <div v-for="item in plList" :key="item.id" style="border-bottom: 1px solid #ddd; padding: 10px 0;">
              <p><strong>👤 {{ item.username }}</strong> <span style="color: gray; font-size: 12px;">({{ item.riqi }})</span></p>
              <p style="margin-left: 10px;">{{ item.neirong }}</p>
            </div>
          </div>
          <div v-else style="margin-top: 40px; text-align: center; color: #888;">
            暂无评论 / No comments yet.
          </div>

          <!-- 评论输入框 -->
          <div style="margin-top: 40px;">
            <h3>📝 发表评论 / Leave a Comment</h3>
            <el-input type="textarea" :rows="4" placeholder="请输入您的评论..." v-model="textarea" />
            <el-button type="primary" style="margin-top: 10px;" @click="addComment(detail.id)">
              提交评论 / Submit
            </el-button>
          </div>
        </el-card>
      </div>
    </template>
  </UserLayout>
</template>

<script>
import axios from 'axios'
import FavoriteButton from "@/views/home/FavoriteButton.vue";
import UserLayout from "./UserLayout.vue";

const baseURL = 'http://localhost:8000';
axios.defaults.baseURL = baseURL;
axios.defaults.timeout = 15000;

export default {
  components: { FavoriteButton, UserLayout },
  name: "PlaceDetail",
  data() {
    return {
      baseURL,
      plList: [],
      textarea: "",
      userInfoid: localStorage.getItem("user_id"),
      detail: null,
      loading: false
    };
  },
  created() {
    this.getDetail();
    this.getComments();
  },
  methods: {
    getDetail() {
      const id = this.$route.query.id;
      if (!id) {
        this.$message.error("无效的景区ID");
        return;
      }
      this.loading = true;
      axios.get(`/hello/jingqudetail/${id}/`, { withCredentials: true })
        .then(response => {
          this.loading = false;
          if (response.data.code === 200) {
            this.detail = response.data.data;
          } else {
            this.$message.error(response.data.message || "加载失败");
          }
        })
        .catch(error => {
          console.error("❌ 加载景区详情失败:", error);
          this.loading = false;
          this.$message.error("加载失败，请检查网络连接");
        });
    },
    getImageUrl(fileName) {
      if (!fileName) return '';
      return fileName.startsWith('http') ? fileName : `${this.baseURL}/upimg/${fileName}`;
    },
    goBack() {
      this.$router.push('/home/place');
    },
    getComments() {
      const id = this.$route.query.id;
      axios.get(`/hello/pl/?jingqu_id=${id}`, { withCredentials: true })
        .then(response => {
          if (response.data.code === 200) {
            this.plList = response.data.data;
          } else {
            this.$message.error("评论加载失败");
          }
        })
        .catch(err => {
          console.error("❌ 加载评论失败", err);
          this.$message.error("网络异常，评论加载失败");
        });
    },
    addComment(jingquId) {
      if (!this.userInfoid) {
        this.$message.warning("请您先登录再留言~");
        return;
      }
      if (!this.textarea) {
        this.$message.error("留言内容不能为空！");
        return;
      }
      axios.post("/hello/pl/", {
        jingqu_id: jingquId,
        shui_id: this.userInfoid,
        neirong: this.textarea
      }).then(res => {
        if (res.data.code === 200) {
          this.$message.success("评论提交成功，等待审核");
          this.textarea = "";
          this.getComments();
        } else {
          this.$message.error("评论失败：" + res.data.message);
        }
      }).catch(err => {
        console.error("❌ 评论异常", err);
        this.$message.error("评论失败");
      });
    },
      createOrder() {
        if (!this.userInfoid) {
          this.$message.warning("请登录后再下单！");
          return;
        }

        // 先获取用户地址信息
        axios.get("/hello/addr/my/", {
          params: { userId: this.userInfoid }
        }).then(res => {
          const addressList = res.data.data;
          if (!addressList || addressList.length === 0) {
            this.$message.warning("请先添加地址后再下单！");
            return;
          }

          // 取第一个地址
          const addrInfo = addressList[0];

          axios.post("/hello/dingdan/", {
          maijia_id: this.detail.maijia?.id || this.detail.maijia_id,  // ✅ 自动适配
          title: this.detail.name,
          img_url: this.detail.img_url,
          price: this.detail.price,
          phone: addrInfo.shouji,
          addr: addrInfo.addr,
          shui_id: this.userInfoid


          }).then(res => {
            if (res.data.code === 200) {
              this.$message.success("下单成功！");
              this.$router.push("/home/myorder");
            } else {
              this.$message.error("下单失败：" + res.data.message);
            }
          }).catch(err => {
            console.error("❌ 下单异常", err);
            this.$message.error("下单失败");
          });

        }).catch(() => {
          this.$message.error("加载地址信息失败");
        });
      }

  }
};
</script>

<style scoped>
.placedetail-container {
  max-width: 800px;
  margin: 20px auto;
  position: relative;
}
.back-button {
  margin-bottom: 20px;
}
.placedetail-card {
  padding: 20px;
  border-radius: 10px;
  text-align: center;
}
.detail-image {
  width: 100%;
  height: 300px;
  object-fit: cover;
  margin-bottom: 20px;
  border-radius: 8px;
}
.detail-jianjie {
  font-weight: bold;
  margin-top: 20px;
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
</style>
