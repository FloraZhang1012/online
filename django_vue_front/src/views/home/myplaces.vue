<template>
  <div class="place-container">
    <el-card class="place-card">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2>📍 我发布的景区列表 My Scenic Spots</h2>
        <el-button type="primary" @click="openAddDialog">➕ 新增景区 Add Scenic Spot</el-button>
      </div>

      <div style="margin-bottom: 20px; display: flex; gap: 20px;">
        <el-select v-model="filter.fenlei_id" placeholder="按分类筛选 / Filter by Category" clearable @change="getMyScenicSpots">
          <el-option v-for="item in categoryList" :key="item.id" :label="item.mingcheng" :value="item.id" />
        </el-select>
        <el-select v-model="filter.diqu_id" placeholder="按地区筛选 / Filter by Region" clearable @change="getMyScenicSpots">
          <el-option v-for="item in regionList" :key="item.id" :label="item.mingcheng" :value="item.id" />
        </el-select>
      </div>

      <div class="place-list">
        <el-row :gutter="20">
          <el-col :span="8" v-for="item in scenicList" :key="item.id">
            <div class="place-item">
              <img :src="getImageUrl(item.img_url)" alt="Scenic Image" class="place-image" />
              <div class="place-info">
                <h3>{{ item.name }}</h3>
                <p>🏷️ 等级 Level: {{ item.dengji }} </p>
                <p>📍 地址 Address: {{ item.dizhi }} </p>
                <p>📂 分类 Category: {{ item.fenlei?.mingcheng || '未分类' }} </p>
                <p>🗺️ 地区 Region: {{ item.diqu?.mingcheng || '未知地区' }} </p>
                <p>💲 价格 Price: {{ item.price }} NZD/人</p>
                <p class="place-jianjie" :class="{ expanded: hoverItem === item.id }">
                  {{ hoverItem === item.id ? item.jianjie : truncateText(item.jianjie, 60) }}
                </p>
                <div style="margin-top: 10px; display: flex; gap: 10px;">
                  <el-button type="primary" size="small" @click.stop="editItem(item)">编辑</el-button>
                  <el-button type="danger" size="small" @click.stop="deleteItem(item.id)">删除</el-button>
                </div>
              </div>
            </div>
          </el-col>
        </el-row>
      </div>

      <div class="pagination">
        <el-button @click="prevPage" :disabled="pageNum <= 1">上一页 Previous</el-button>
        <span style="margin: 0 10px;">第 {{ pageNum }} 页</span>
        <el-button @click="nextPage" :disabled="!hasMore">下一页 Next</el-button>
      </div>
    </el-card>

    <el-dialog title="{{ form.id ? '编辑景区 Edit Scenic Spot' : '新增景区 Add Scenic Spot' }}" v-model="dialogVisible">
      <el-form :model="form" label-width="120px">
        <el-form-item label="名称 Name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="价格 Price">
          <el-input v-model.number="form.price" type="number" />
        </el-form-item>
        <el-form-item label="地址 Address">
          <el-input v-model="form.dizhi" />
        </el-form-item>
        <el-form-item label="等级 Level">
          <el-input v-model="form.dengji" />
        </el-form-item>
        <el-form-item label="简介 Description">
          <el-input type="textarea" v-model="form.jianjie" />
        </el-form-item>
        <el-form-item label="分类 Category">
          <el-select v-model="form.fenlei_id" placeholder="请选择分类 / Please select category">
            <el-option v-for="item in categoryList" :key="item.id" :label="item.mingcheng" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="地区 Region">
          <el-select v-model="form.diqu_id" placeholder="请选择地区 / Please select region">
            <el-option v-for="item in regionList" :key="item.id" :label="item.mingcheng" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="封面图 Cover Image">
          <el-upload
            class="upload-demo"
            action="http://localhost:8000/hello/upload_avatar/"
            :on-success="handleUploadSuccess"
            :show-file-list="false"
            name="file"
          >
            <el-button type="primary">上传图片 Upload</el-button>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消 Cancel</el-button>
        <el-button type="primary" @click="submitForm">提交 Submit</el-button>
      </template>
    </el-dialog>
  </div>
</template>


<script>
import axios from "axios";

const baseURL = "http://localhost:8000";
axios.defaults.baseURL = baseURL;
axios.defaults.timeout = 15000;

export default {
  name: "MyPlaces",
  data() {
    return {
      baseURL,
      scenicList: [],
      categoryList: [],
      regionList: [],
      loading: false,
      pageNum: 1,
      pageSize: 6,
      totalCount: 0,
      hoverItem: null,
      userInfoid: localStorage.getItem("userInfoid"),
      dialogVisible: false,
      filter: {
        fenlei_id: "",
        diqu_id: ""
      },
      form: {
        name: "",
        price: 0,
        dizhi: "",
        dengji: "",
        jianjie: "",
        img_url: "",
        fenlei_id: "",
        diqu_id: ""
      },
      defaultAvatar: "https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png"
    };
  },
  created() {
    this.getMyScenicSpots();
    this.getCategoryList();
    this.getRegionList();
  },
  computed: {
    hasMore() {
      return this.pageNum * this.pageSize < this.totalCount;
    }
  },
  methods: {
    getCategoryList() {
      axios.get("/hello/fl/").then(res => {
        if (res.data.code === 200) {
          this.categoryList = res.data.data;
        }
      });
    },
    getRegionList() {
      axios.get("/hello/dq/").then(res => {
        if (res.data.code === 200) {
          this.regionList = res.data.data;
        }
      });
    },
    openAddDialog() {
      this.dialogVisible = true;
      this.form = {
        id: "",
        name: "",
        price: 0,
        dizhi: "",
        dengji: "",
        jianjie: "",
        img_url: "",
        fenlei_id: "",
        diqu_id: ""
      };
    },
    editItem(item) {
    this.form = {
      ...item,
      fenlei_id: item.fenlei?.id || '',
      diqu_id: item.diqu?.id || ''
    };
    this.dialogVisible = true;
  },

    handleUploadSuccess(res) {
      if (res.code === 200) {
        this.form.img_url = res.data.file;
        this.$message.success("上传成功");
      } else {
        this.$message.error("上传失败");
      }
    },
    submitForm() {
      this.form.maijia_id = this.userInfoid;

  // ✅ 强制设为英文默认值
  this.form.zhuangtai = "Available";
  this.form.is_kaifang = "Open";
  this.form.is_shenhe = "Approved";

      if (this.form.id) {
        // 编辑
        axios
          .put(`/hello/jingqu/update/${this.form.id}`, this.form)
          .then((res) => {
            if (res.data.code === 200) {
              this.$message.success("更新成功");
              this.dialogVisible = false;
              this.getMyScenicSpots();
            } else {
              this.$message.error(res.data.message || "更新失败");
            }
          })
          .catch(() => {
            this.$message.error("更新失败，请检查网络");
          });
      } else {
        // 新增
        axios
          .post("/hello/jingqu/create", this.form)
          .then((res) => {
            if (res.data.code === 200) {
              this.$message.success("创建成功");
              this.dialogVisible = false;
              this.getMyScenicSpots();
            } else {
              this.$message.error(res.data.message || "创建失败");
            }
          })
          .catch(() => {
            this.$message.error("创建失败，请检查网络");
          });
      }
    },
    deleteItem(id) {
      this.$confirm('确定要删除这个景区吗？This action will permanently delete this spot.', '警告 Warning', {
        confirmButtonText: '删除 Delete',
        cancelButtonText: '取消 Cancel',
        type: 'warning'
      }).then(() => {
        axios
          .delete(`/hello/jingqu/delete/${id}`)
          .then(res => {
            if (res.data.code === 200) {
              this.$message.success('删除成功 Deleted');
              this.getMyScenicSpots();
            } else {
              this.$message.error(res.data.message || '删除失败 Failed to delete');
            }
          })
          .catch(() => {
            this.$message.error('删除失败，请检查网络');
          });
      }).catch(() => {
        this.$message.info('已取消删除 Cancelled');
      });
    },

    getMyScenicSpots() {
      this.loading = true;
      const params = {
        user_id: this.userInfoid,
        fenlei_id: this.filter.fenlei_id,
        diqu_id: this.filter.diqu_id
      };
      axios
        .get("/hello/jingqu/mylist", { params })
        .then((response) => {
          this.loading = false;
          if (response.data.code === 200) {
            this.scenicList = response.data.data;
            this.totalCount = response.data.data.length;
          } else {
            this.$message.error(response.data.message || "加载失败");
          }
        })
        .catch((error) => {
          console.error("加载失败:", error);
          this.loading = false;
          this.$message.error("加载失败，请检查网络");
        });
    },
    goDetailPage(id) {
      this.$router.push({ path: "/home/placedetail", query: { id } });
    },
    getImageUrl(fileName) {
      if (!fileName) {
        return this.defaultAvatar;
      }
      return fileName.startsWith("http")
        ? fileName
        : `${this.baseURL}/upimg/${fileName}`;
    },
    truncateText(text, length) {
      if (!text) return "";
      return text.length > length ? text.slice(0, length) + "..." : text;
    },
    nextPage() {
      if (this.hasMore) {
        this.pageNum++;
        this.getMyScenicSpots();
      }
    },
    prevPage() {
      if (this.pageNum > 1) {
        this.pageNum--;
        this.getMyScenicSpots();
      }
    }
  }
};
</script>

<style scoped>
.place-list {
  margin-top: 20px;
}
.place-image {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 8px;
  transition: transform 0.3s ease;
}

.place-item {
  margin-bottom: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  transition: transform 0.2s ease;
  background: white;
}
.place-item:hover {
  transform: scale(1.02);
}
.place-info {
  padding: 12px;
}
.place-jianjie {
  color: #666;
  line-height: 1.4;
  margin-top: 5px;
}
</style>
