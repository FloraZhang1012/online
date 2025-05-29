<template>
  <div v-if="isAdmin == 1">
  <el-button type="primary" @click="visible = true">添加景区轮播</el-button>
</div>
  <el-card shadow="never" style="margin-top: 10px;">

    <!-- 查询区域 -->
    <el-card shadow="never" style="margin: 10px 0;">
      <el-form :model="search">
        <el-row :gutter="30">
          <el-col :lb="24" :sm="12" :md="8" :lg="6">
            <el-form-item label="景区轮播名:">
              <el-input v-model="search.mingcheng" placeholder="请输入景区轮播名" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div style="text-align: right;">
        <el-button type="primary" @click="getList()">查询</el-button>
        <el-button @click="resetSearch()">重置</el-button>
      </div>
    </el-card>

    <!-- 表格区域 -->
    <el-table :data="tableData" stripe>
      <el-table-column prop="id" label="ID"  />
      <el-table-column label="景区轮播图片">
        <template #default="scope">
        <img :src="Host+'/upimg/' + scope.row.img_url" width="500" height="200">
        <!-- <img :src="scope.row.img_url" width="50" height="50"> -->
        </template>
      </el-table-column>
      
      <el-table-column label="操作" width="120" fixed="right">
        <template #default="scope">
          <div v-if="isAdmin == 1">
          <el-button link type="primary" size="small" @click="editItem(scope.row)">编辑</el-button>
          <el-popconfirm title="确定要删除吗?" @confirm="deleteItem(scope.row.id)">
            <template #reference>
              <el-button link type="primary" size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </div>
        </template>
      </el-table-column>


    </el-table>
    <!-- 分页 -->
    <el-pagination background @size-change="handleSizeChange" @current-change="handleCurrentChange"
      layout="sizes, total, prev, pager, next" :total="totalNum" :currentPage="search.pageNum"
      :pageSize="search.pageSize">
    </el-pagination>
  </el-card>
  <!-- 新增或编辑的抽屉 -->
  <sDrawer v-model="visible" :title="form.id ? '编辑' : '添加'" size="35%" :close-on-click-modal="false">

    <el-form :model="form" label-width="80px" ref="ruleFormRef">
    <el-form-item label="景区图片:">
        <div v-if="form.id">
          <el-upload
            class="upload-demo"
            :action="Host+'/img_upload/'"
            :data={data:form.id}
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :before-remove="beforeRemove"
            :on-success="handleSuccess1"
            multiple
            :limit="1"
            :on-exceed="handleExceed"> 
            <el-button type="primary" size="mini" icon="el-icon-upload">
                修改图片
            </el-button>
          </el-upload>
    </div>

    <div v-else>
            <el-upload
            class="upload-demo"
            :action="Host+'/img_upload/'"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :before-remove="beforeRemove"
            :on-success="handleSuccess1"
            multiple
            :limit="1"
            :on-exceed="handleExceed"> 
            <el-button type="primary" size="mini" icon="el-icon-upload">
                上传图片
            </el-button>
          </el-upload>
        </div>

    </el-form-item>
  </el-form>

    <template #footer>
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="saveData()">确定</el-button>
    </template>
  </sDrawer>
</template>

<script>
import sDrawer from "@/components/s-drawer/s-drawer.vue"
export default {
  components: {
    sDrawer,
  },
  watch: {
    visible(value) {
      if (!value) {
        this.form = {}
      }
    }
  },
  data() {
    return {
      form: {
        // id: '',
      },

      xydata: [],

      visible: false,
      tableData: [],
      totalNum: 100,
      search: {
        pageNum: 1,
        pageSize: 10,
        // token: "",
      },
    };
  },
  created() {
    // this.search.token = localStorage.getItem("token");
    this.getList();
    this.isAdmin = localStorage.getItem("isAdmin");
  },
  methods: {
    async getList() {
      this.$api.gethtlb(
        this.search
        ).then(res=>{
            if (res.data.code === 200){
              this.tableData = res.data.data;
              this.totalNum = res.data.zs
            }
        })
    },
    async saveData() {
      if (this.form.id) {
        this.$api.updatehtlb(this.form).then(res=>{
            if (res.data.code === 200){
              this.$message.success(res.data.message)
              this.getList()
              this.visible = false
            }
        })
      } else {
        this.$api.createhtlb(this.form).then(res=>{
            if (res.data.code === 200){
              this.$message.success(res.data.message)
              this.getList()
              this.visible = false
            }
        })
      }

      
    },
    async deleteItem(id) {
      this.$api.deletehtlb({id:id}).then(res=>{
            if (res.data.code === 200){
              this.$message.success(res.data.message)
              this.getList()
            }
        })
    },

    // 每页条数改变时触发 选择一页显示多少行
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.search.pageSize = val;
      this.getList();
    },
    // 当前页改变时触发 跳转其他页
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.search.pageNum = val;
      this.getList();
    },
    resetSearch() {
      let search = {
        pageNum: this.search.pageNum,
        pageSize: this.search.pageSize,
      };
      this.search = search;
      this.getList();
    },
    editItem(row) {
      this.form = this.$deepClone(row)
      this.visible = true
    },
    handleSuccess1(res) {
        console.log(res.data,'777777777777777777777777777777777777777')
        this.form.img_url = res.data.file
        this.dialogImageUrl = ''
        this.$notify({
            title: '通知',
            message: '上传照片成功~',
            type: 'success',
            duration: 5000
      })
    },
  },
};
</script>

<style scoped>
.el-pagination {
  margin-top: 10px;
}

.el-row {
  margin-bottom: 20px;
}

.el-row:last-child {
  margin-bottom: 0px;
}
</style>