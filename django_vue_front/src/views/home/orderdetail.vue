<template>
  <UserLayout>
    <template #default>
      <div class="order-detail-wrapper" v-loading="loading">
        <h2 style="margin-bottom: 30px;">📖 订单详情 / Order Detail</h2>

        <el-card v-if="order">
          <el-descriptions border :column="1">
            <el-descriptions-item label="订单编号 / Order ID">{{ order.id }}</el-descriptions-item>
            <el-descriptions-item label="景区 / Scenic Spot">{{ order.title }}</el-descriptions-item>
            <el-descriptions-item label="商家 / Seller">{{ order.maijia }}</el-descriptions-item>
            <el-descriptions-item label="价格 / Price">NZD {{ order.price }}</el-descriptions-item>
            <el-descriptions-item label="下单时间 / Order Date">{{ order.gmsj }}</el-descriptions-item>
            <el-descriptions-item label="手机号 / Phone">{{ order.phone }}</el-descriptions-item>
            <el-descriptions-item label="地址 / Address">{{ order.addr }}</el-descriptions-item>
            <el-descriptions-item label="支付状态 / Status">
              <span v-if="order.zfzt === 'Paid'" style="color: green;">✅ 已支付 Paid</span>
              <span v-else style="color: orange;">⏳ 待支付 Waiting to pay</span>
            </el-descriptions-item>
          </el-descriptions>

          <div style="margin-top: 20px; text-align: center">
            <el-button v-if="order.zfzt !== 'Paid'" type="success" @click="payOrder">💰 支付 / Pay Now</el-button>
            <el-button type="danger" @click="cancelOrder">❌ 取消订单 / Cancel</el-button>
          </div>
        </el-card>

        <div v-else>
          <el-empty description="无订单数据 / No Order Found" />
        </div>
      </div>
    </template>
  </UserLayout>
</template>

<script>
import axios from 'axios'
import UserLayout from './UserLayout.vue'

export default {
  components: { UserLayout },
  data() {
    return {
      loading: false,
      order: null
    }
  },
  mounted() {
    this.loadOrder()
  },
  methods: {
    loadOrder() {
      const orderId = this.$route.query.id
      if (!orderId) return
      this.loading = true
      axios.get(`http://localhost:8000/hello/dingdan/${orderId}/`).then(res => {
        this.order = res.data.data
        this.loading = false
      }).catch(() => {
        this.$message.error("订单加载失败 / Failed to load order")
        this.loading = false
      })
    },
    payOrder() {
      axios.post(`http://localhost:8000/hello/dingdan/pay/${this.order.id}/`).then(res => {
        this.$message.success(res.data.message || '支付成功 / Payment Success')
        this.loadOrder()
      }).catch(() => {
        this.$message.error('支付失败 / Payment Failed')
      })
    },
    cancelOrder() {
      this.$confirm("确认取消该订单？", "提示", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        axios.delete(`http://localhost:8000/hello/dingdan/cancel/${this.order.id}/`).then(res => {
          this.$message.success(res.data.message || '订单已取消 / Order Cancelled')
          this.$router.back()
        }).catch(() => {
          this.$message.error('取消失败 / Cancel Failed')
        })
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.order-detail-wrapper {
  padding: 30px;
  background-color: #f9f9f9;
  min-height: 100vh;
}
</style>
