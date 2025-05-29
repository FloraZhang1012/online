<template>
  <UserLayout>
    <template #default>
      <div class="order-wrapper" v-loading="loading">
        <h2 style="margin-bottom: 30px;">📦 我的订单 / My Orders</h2>

        <el-card class="order-card">
          <el-table :data="orders" stripe border style="width: 100%">
            <el-table-column prop="title" label="景区 / Scenic Spot" align="center" />
            <el-table-column prop="price" label="价格 / Price (NZD)" align="center" />
            <el-table-column prop="gmsj" label="下单时间 / Date" align="center" />
            <el-table-column prop="zfzt" label="支付状态 / Status" align="center">
              <template #default="scope">
                <span style="color: green;" v-if="scope.row.zfzt === 'Paid'">✅ 已支付</span>
                <span style="color: orange;" v-else>⏳ 待支付</span>
              </template>
            </el-table-column>
            <el-table-column label="操作 / Actions" align="center" width="240">
              <template #default="scope">
                <el-button
                  size="mini"
                  type="primary"
                  @click="viewDetail(scope.row.id)"
                >
                  📖 查看 / View
                </el-button>
                <el-button
                  size="mini"
                  type="success"
                  v-if="scope.row.zfzt !== 'Paid'"
                  @click="payOrder(scope.row.id)"
                >
                  💰 支付 / Pay
                </el-button>
                <el-button
                  size="mini"
                  type="danger"
                  @click="cancelOrder(scope.row.id)"
                >
                  ❌ 取消 / Cancel
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
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
      orders: []
    }
  },
  mounted() {
    this.fetchOrders()
  },
  methods: {
    fetchOrders() {
      this.loading = true
      axios
        .get('http://localhost:8000/hello/dingdan/my/', {
          params: { userId: localStorage.getItem('user_id') }
        })
        .then(res => {
          this.orders = res.data.data
          this.loading = false
        })
        .catch(() => {
          this.$message.error("加载订单失败 / Failed to load orders")
          this.loading = false
        })
    },
    viewDetail(orderId) {
      this.$router.push(`/home/orderdetail?id=${orderId}`)
    },
    payOrder(orderId) {
      axios
        .post(`http://localhost:8000/hello/dingdan/pay/${orderId}/`)
        .then(res => {
          this.$message.success(res.data.message || "支付成功 / Payment success")
          this.fetchOrders()
        })
        .catch(() => {
          this.$message.error("支付失败 / Payment failed")
        })
    },
    cancelOrder(orderId) {
      this.$confirm("确认取消该订单吗？", "提示", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        axios
          .delete(`http://localhost:8000/hello/dingdan/cancel/${orderId}/`)
          .then(res => {
            this.$message.success(res.data.message || "取消成功 / Canceled")
            this.fetchOrders()
          })
          .catch(() => {
            this.$message.error("取消失败 / Cancel failed")
          })
      }).catch(() => {})
    }
  }
}
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
