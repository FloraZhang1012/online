<template>
  <div v-if="isLoggedIn">
    <h2>订单列表</h2>
    <ul>
      <li v-for="dingdan in dingdanList" :key="dingdan.id">
        {{ dingdan.maijia }} - {{ dingdan.title }} - {{ dingdan.price }} NZD
      </li>
    </ul>
  </div>

  <div v-else>
    <p>⚠️ 请先 <router-link to="/login">登录</router-link> 后查看订单。</p>
  </div>
</template>

<script>
import api from "@/utils/api.js";

export default {
  data() {
    return {
      dingdanList: [],
      isLoggedIn: !!localStorage.getItem("token"), // 检查是否已登录
    };
  },
  async created() {
    if (this.isLoggedIn) {
      try {
        let response = await api.get("dingdan/");
        this.dingdanList = response.data;
      } catch (error) {
        console.error("获取订单失败：", error);
      }
    }
  },
};
</script>
