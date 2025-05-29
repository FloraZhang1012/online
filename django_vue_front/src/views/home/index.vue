<template>
  <div class="homepage-wrapper">
    <div class="header-banner">
      <img src="/banner.jpg" alt="Banner" class="banner-img" />
      <h2 class="welcome-title">🏖 Welcome to the Tourism System!</h2>
    </div>

    <div class="section carousel" v-if="items.length > 0">
      <h3>🌄 Preview of the Rotation Pictures</h3>
      <el-carousel height="300px">
        <el-carousel-item v-for="(v, k) in items" :key="k">
          <img :src="Host + '/upimg/' + v.img_url" class="carousel-img" />
        </el-carousel-item>
      </el-carousel>
    </div>
    <div v-else class="section">
      <p class="error">❌ 没有轮播图数据，请检查接口或图片路径</p>
    </div>

    <div class="section">
      <h3>🤝 Collaborative Filtering Recommendation</h3>
      <div class="card-grid">
        <div v-for="item in xtgldata" :key="item.id" class="card" @click="goDetailPage(item.id)">
          <img :src="Host + '/upimg/' + item.img_url" class="card-img" />
          <div class="card-title">{{ item.name }}</div>
          <div class="card-subtitle">{{ item.dengji }} - ¥{{ item.price }}</div>
        </div>
      </div>
    </div>

    <div class="section">
      <h3>📍 Scenic Spot Recommendation</h3>
      <div class="grid-3">
        <div v-for="item in tableData" :key="item.id" class="card" @click="goDetailPage(item.id)">
          <img :src="Host + '/upimg/' + item.img_url" class="card-img" />
          <div class="card-title">{{ item.name }}</div>
          <div class="card-subtitle">{{ item.dengji }}</div>
        </div>
      </div>
    </div>

    <div class="center-button">
      <el-button type="primary" @click="goAllScenicSpots">🔎 查看全部景区 Check All Scenic Spots</el-button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      Host: "http://127.0.0.1:8000",
      items: [],
      xtgldata: [],
      tableData: []
    };
  },
  created() {
    this.getLb();
    this.xtgl();
    this.getList();
  },
  methods: {
    getLb() {
      this.$api.lb({ pageNum: 1, pageSize: 5 }).then(res => {
        if (res.data.code === 200) {
          this.items = res.data.data;
        }
      });
    },
    xtgl() {
      this.$api.xtgl({ pageNum: 1, pageSize: 4, userInfoid: localStorage.getItem("userInfoid") }).then(res => {
        if (res.data.code === 200) {
          this.xtgldata = res.data.data;
        }
      });
    },
    getList() {
      this.$api.getList({ pageNum: 1, pageSize: 6 }).then(res => {
        if (res.data.code === 200) {
          this.tableData = res.data.data;
        }
      });
    },
    goDetailPage(id) {
      this.$router.push({ path: "/home/placedetail", query: { id } });
    },
    goAllScenicSpots() {
      this.$router.push({ path: "/home/place" });
    }
  }
};
</script>

<style scoped>
.homepage-wrapper {
  padding: 20px;
  font-family: Arial, sans-serif;
  background: linear-gradient(to bottom, #e0f7fa, #ffffff);
  min-height: 100vh;
  max-width: 3200px;
  margin: 0 auto;
}

.header-banner {
  position: relative;
  margin-bottom: 40px;
  text-align: center;
}
.banner-img {
  width: 100%;
  height: 240px;
  object-fit: cover;
  border-radius: 12px;
}
.welcome-title {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(0, 0, 0, 0.5);
  color: #fff;
  padding: 10px 20px;
  border-radius: 8px;
  font-size: 24px;
}
.section {
  margin-bottom: 40px;
}
.carousel-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 10px;
}
.card-grid {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
  justify-content: start;
}
.grid-3 {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}
.card {
  background-color: #fff;
  padding: 10px;
  border: 1px solid #eee;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  transition: transform 0.2s;
}
.card:hover {
  transform: translateY(-4px);
}
.card-img {
  width: 100%;
  height: 150px;
  object-fit: cover;
  border-radius: 6px;
}
.card-title {
  margin-top: 8px;
  font-weight: bold;
}
.card-subtitle {
  font-size: 12px;
  color: gray;
}
.center-button {
  text-align: center;
}
.error {
  color: red;
  font-weight: bold;
  margin-top: 10px;
}
</style>
