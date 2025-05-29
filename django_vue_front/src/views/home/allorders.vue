<template>
  <div class="order-wrapper" v-loading="loading">
    <h2 style="margin-bottom: 30px;">📦 我的订单列表 / Orders Received</h2>

    <el-card class="order-card">
      <el-table :data="orders" stripe border style="width: 100%">
        <el-table-column prop="id" label="订单号 / Order ID" align="center" />
        <el-table-column prop="title" label="景区 / Scenic Spot" align="center" />
        <el-table-column prop="price" label="价格 / Price (NZD)" align="center" />
        <el-table-column prop="gmsj" label="下单时间 / Date" align="center" />
        <el-table-column prop="zfzt" label="支付状态 / Status" align="center">
          <template #default="scope">
            <span style="color: green;" v-if="scope.row.zfzt === 'Paid'">✅ 已支付 Paid</span>
            <span style="color: orange;" v-else>⏳ 待支付 Waiting to pay</span>
          </template>
        </el-table-column>
        <el-table-column prop="phone" label="顾客电话 / Phone" align="center" />
        <el-table-column prop="addr" label="送货地址 / Address" align="center" />
      </el-table>
    </el-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "OwnerOrders",
  data() {
    return {
      loading: false,
      orders: []
    };
  },
  created() {
    this.fetchOrders();
  },
  methods: {
    fetchOrders() {
      this.loading = true;
      axios
        .get("http://localhost:8000/hello/dingdan/all/", {
          params: {
            maijia_id: localStorage.getItem("userInfoid")
          }
        })
        .then((res) => {
          if (res.data.code === 200) {
            this.orders = res.data.data;
          } else {
            this.$message.error(res.data.message || "加载订单失败");
          }
          this.loading = false;
        })
        .catch(() => {
          this.$message.error("请求失败，请检查网络");
          this.loading = false;
        });
    }
  }
};
</script>

<style scoped>
.order-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
}

.order-card {
  padding: 20px;
  border-radius: 12px;
  background: white;
}
</style>
