<template>
  <div class="carousel-manage">
    <h2>🖼️ 轮播管理 / Carousel Management</h2>

    <!-- 🖼️ 上传区域 Upload Area -->
    <el-upload
      ref="upload"
      class="upload-demo"
      drag
      action="http://localhost:8000/hello/lb/upload/"
      :on-success="handleSuccess"
      :show-file-list="false"
      :data="{ title: newTitle }"
      :before-upload="beforeUpload"
    >
      <i class="el-icon-upload"></i>
      <div class="el-upload__text">拖动文件或 <em>点击上传</em> / Drag or <em>Click to Upload</em></div>
      <div class="el-upload__tip" slot="tip">只能上传 JPG/PNG 文件 / Only JPG/PNG files allowed</div>
    </el-upload>

    <!-- ✏️ 标题输入 Title Input -->
    <el-input
      placeholder="轮播图标题（可选） / Carousel Title (optional)"
      v-model="newTitle"
      style="margin: 10px 0; width: 300px"
    />

    <!-- 📋 图片列表 Image List -->
    <el-table :data="tableData" style="margin-top: 20px" border stripe>
      <el-table-column label="预览 / Preview" width="180" align="center">
        <template #default="scope">
          <img :src="getImageUrl(scope.row.img_url)" style="width: 150px; height: auto" />
        </template>
      </el-table-column>
      <el-table-column prop="title" label="标题 / Title" align="center" />
      <el-table-column prop="created_at" label="上传时间 / Created At" align="center" />
      <el-table-column label="操作 / Action" align="center" width="120">
        <template #default="scope">
          <el-button type="danger" size="mini" @click="deleteImg(scope.row.id)">删除 / Delete</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 📄 分页 Pagination -->
    <el-pagination
      layout="prev, pager, next"
      :page-size="pageSize"
      :total="total"
      @current-change="loadData"
      style="margin-top: 20px; text-align: center"
    />
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      tableData: [],
      total: 0,
      pageSize: 5,
      pageNum: 1,
      newTitle: '' // 📝 新标题（可选）
    };
  },
  mounted() {
    this.loadData(1);
  },
  methods: {
    // 🔗 拼接图片路径
    getImageUrl(url) {
      return `http://localhost:8000/upimg/${url}`;
    },
    // 📥 加载数据
    loadData(page) {
      this.pageNum = page;
      axios.get('http://localhost:8000/hello/lb/', {
        params: { pageNum: page, pageSize: this.pageSize }
      }).then(res => {
        this.tableData = res.data.data;
        this.total = res.data.zs;
      });
    },
    // ✅ 上传成功后处理
    handleSuccess(res) {
      this.$message.success(res.message || '上传成功 / Upload successful');
      this.$refs.upload?.clearFiles?.(); // 清空上传框
      this.newTitle = '';
      this.loadData(this.pageNum);
    },
    // ⚠️ 上传前校验
    beforeUpload(file) {
      const isImg = file.type === 'image/jpeg' || file.type === 'image/png';
      if (!isImg) {
        this.$message.error('只能上传 JPG/PNG 图片 / Only JPG/PNG allowed');
      }
      return isImg;
    },
    // 🗑️ 删除图片
    deleteImg(id) {
      this.$confirm('确定删除该轮播图？ / Confirm delete?', '警告 / Warning', {
        confirmButtonText: '确定 / Confirm',
        cancelButtonText: '取消 / Cancel',
        type: 'warning'
      }).then(() => {
        axios.delete(`http://localhost:8000/hello/lb/delete/${id}/`).then(res => {
          this.$message.success(res.data.message || '删除成功 / Deleted');
          this.loadData(this.pageNum);
        });
      });
    }
  }
};
</script>

<style scoped>
.carousel-manage {
  padding: 30px;
  background: #fff;
  min-height: 100vh;
}
.upload-demo {
  border: 2px dashed #d9d9d9;
  padding: 20px;
  margin-bottom: 20px;
  border-radius: 10px;
  background-color: #fafafa;
  text-align: center;
}
</style>
