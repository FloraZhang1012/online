<template>
  <UserLayout>
    <template #default>
      <div style="padding: 20px;" v-loading="loading">
        <h2 style="margin-bottom: 30px;">❤️ 我的收藏 My Favorites</h2>

        <el-skeleton :loading="loading" animated>
          <template #template>
            <el-row :gutter="30">
              <el-col :span="6" v-for="n in 4" :key="n">
                <el-skeleton-item variant="image" style="width: 100%; height: 180px;" />
                <el-skeleton-item variant="text" style="margin-top: 10px;" />
                <el-skeleton-item variant="text" style="width: 60%;" />
              </el-col>
            </el-row>
          </template>

          <template #default>
            <el-row :gutter="30">
              <el-col :span="6" v-for="item in favorites" :key="item.id">
                <el-card :body-style="{ padding: '10px' }" class="favorite-card">
                  <router-link :to="`/home/placedetail?id=${item.id}`">
                    <img :src="getImageUrl(item.img_url)" alt="scenic" class="favorite-image" />
                  </router-link>

                  <div class="favorite-info">
                    <strong>{{ item.name }}</strong>
                    <p>等级: {{ item.dengji }}</p>
                    <p>价格: ${{ item.price }}</p>
                    <el-button type="danger" size="mini" @click="removeFavorite(item.id)">
                      取消收藏
                    </el-button>
                  </div>
                </el-card>
              </el-col>
            </el-row>

            <el-pagination
              v-if="total > pageSize"
              background
              layout="prev, pager, next"
              :total="total"
              :page-size="pageSize"
              @current-change="handlePageChange"
              :current-page="currentPage"
              style="margin-top: 30px; text-align: center;"
            />
          </template>
        </el-skeleton>

        <div v-if="!loading && favorites.length === 0" style="text-align: center; padding: 50px; color: gray;">
          暂无收藏记录 / No favorites found.
        </div>
      </div>
    </template>
  </UserLayout>
</template>

<script>
import axios from 'axios'
import UserLayout from './UserLayout.vue'

export default {
  components: {
    UserLayout
  },
  data() {
    return {
      favorites: [],
      userId: localStorage.getItem("user_id"),
      loading: false,
      currentPage: 1,
      pageSize: 4,
      total: 0
    };
  },
  mounted() {
    this.loadFavorites();
  },
  methods: {
    loadFavorites() {
      this.loading = true;
      axios.get("http://localhost:8000/hello/sc/list/", {
        params: {
          userId: this.userId,
          limit: this.pageSize,
          offset: (this.currentPage - 1) * this.pageSize
        }
      }).then(res => {
        this.favorites = res.data.data;
        this.total = res.data.total;
      }).finally(() => {
        this.loading = false;
      });
    },
    removeFavorite(jingquId) {
      axios.delete("http://localhost:8000/hello/sc/delete/", {
        params: {
          userId: this.userId,
          jingquId: jingquId
        }
      }).then(() => {
        this.$message.success("已取消收藏 / Unfavorited");
        this.loadFavorites();
      }).catch(() => {
        this.$message.error("取消收藏失败 / Failed to unfavorite");
      });
    },
    getImageUrl(imgUrl) {
      return `http://localhost:8000/upimg/${imgUrl}`;
    },
    handlePageChange(page) {
      this.currentPage = page;
      this.loadFavorites();
    }
  }
}
</script>

<style scoped>
.favorite-card {
  width: 100%;
  height: 340px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin-bottom: 30px;
}

.favorite-image {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 4px;
  cursor: pointer;
  transition: transform 0.3s ease;
}

.favorite-image:hover {
  transform: scale(1.05);
}

.favorite-info {
  padding-top: 10px;
  font-size: 14px;
}
</style>
