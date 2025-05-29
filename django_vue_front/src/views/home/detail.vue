<template>
    <div style="padding-top: 20px;">
      <div class="detail-top">
        <div class="top-left">
          <div class="cover-img">
            <img :src="Host+'/upimg/' + detailinfo.img_url" width="270" height="200"
              style="object-fit: cover;">
          </div>
          <div>
            <div style="display: flex;align-items: center">
              <el-tag>景区状态</el-tag>
              <div style="margin-left:10px;font-size: 14px;">{{ detailinfo.is_kaifang }}</div>
            </div>
            <br>
            <div style="display: flex;align-items: center">
              <el-tag>审核状态</el-tag>
              <div style="margin-left:10px;font-size: 14px;">{{ detailinfo.is_shenhe }}</div>
            </div>
            <div style="line-height: 32px;font-size: 20px;margin:10px 0;">{{ detailinfo.name }}</div>
            <div class="row-item">¥{{ detailinfo.price }}元/人</div>
            <div class="row-item">分类：<span class="blue">{{ detailinfo.fenlei?.mingcheng }}</span></div>
            <div class="row-item">地区：<span class="blue">{{ detailinfo.diqu?.mingcheng }}</span></div>
            <div class="row-item">地址：<span class="blue">{{ detailinfo.dizhi }}</span></div>
            <el-button type="primary" style="margin-top: 20px;" @click="godingdan(detailinfo)">预订</el-button>
          </div>
        </div>
        <div class="top-right">
          <div style="display: flex;align-items: center;">
            <img src="https://travel.gitapp.cn/assets/want-read-hover-e9e227e2.svg"
              style="width: 32px;height: 32px;margin-right: 24px;">
            <div
              style="display: flex;justify-content: space-between;flex:1;color: #152844;font-size: 16px;font-weight: 600;">
              <span>B站程序员科科</span>
              <span>x</span>
            </div>
          </div>
          <el-divider />
          <div style="display: flex;align-items: center;">
            <img src="https://travel.gitapp.cn/assets/want-read-hover-e9e227e2.svg"
              style="width: 32px;height: 32px;margin-right: 24px;">
            <div
              style="display: flex;justify-content: space-between;flex:1;color: #152844;font-size: 16px;font-weight: 600;">
              <span type="primary" plain @click="favoriteButton(detailinfo)">{{ isFavorite ? '取消收藏' : '收藏' }}</span>
              <span>x</span>
            </div>
          </div>
          <el-divider />
          <div style="display: flex;align-items: center;">
            <img src="https://travel.gitapp.cn/assets/share-icon-d2ff6534.svg"
              style="width: 32px;height: 32px;margin-right: 24px;">
            <div
              style="display: flex;justify-content: space-between;flex:1;color: #152844;font-size: 16px;font-weight: 600;">
              <span>V:python_kk</span>
              <span>x</span>
            </div>
          </div>
          <el-divider />
        </div>
      </div>
      <div class="detail-bottom">
        <div class="bottom-left">
          <el-tabs v-model="activeName">
            <el-tab-pane label="评论" name="评论">
              <div style="padding-right: 20px;">
                <div style="font-weight: 600;font-size: 14px;line-height: 22px;color: #152844; margin: 24px 0 12px;">
                  评论需审核后展示~</div>
                <div style="display: flex;align-items: center;">
                  <el-avatar :size="32" src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    style="flex-shrink: 0;margin-right:10px;" />
                  <el-input type="textarea" placeholder="请输入内容" v-model="textarea" style="flex:1;"></el-input>
                  <el-button type="primary" style="margin-left:10px;" @click="addComment(detailinfo.id)">发表评论</el-button>
                </div>
                <div style="display: flex;justify-content: space-between;align-items: center;padding: 20px 0;">
                  <div style="color: #484848;font-size: 14px;">共有{{ plgs }}条评论</div>
                  <!-- <div><el-button link type="primary">最新</el-button>｜<el-button link type="primary">热门</el-button></div> -->
                </div>
  
  
                <div>
                  <div v-for="item in plList" :key="item.id" style="margin-bottom:20px;border-bottom: 1px dashed #cedce4;padding: 10px 0;">
                    <div style="display: flex;align-items: center;">
                      <el-avatar :size="32" :src="Host+'/upimg/' + item.shui.img_url"
                        style="flex-shrink: 0;margin-right:10px;" />
                      <div style="flex:1;">
                        <div style="font-weight: 600;font-size: 16px;">{{ item.shui.username }}</div>
                        <div style="font-size: 14px;color: #999;">{{ item.pl_date }}</div>
                        <div>{{ item.content }}</div>
                      </div>
                      <!-- <div style="flex-shrink: 0;"><el-button link type="primary">推荐</el-button> 1</div> -->
                    </div>
                  </div>
                </div>
              </div>
            </el-tab-pane>
            <el-tab-pane label="简介" name="简介">
              <div style="color: #484848;font-size: 16px;line-height: 26px;">
                {{ detailinfo.jianjie }}
              </div>
            </el-tab-pane>
          </el-tabs>
        </div>
        <div class="bottom-right">
          <div style="font-weight: 600;font-size: 18px;line-height: 26px;color: #152844;">同类推荐</div>
          <el-divider style="margin-top: 10px" />
          <div>
            <div v-for="item in tongleilist" :key="item.id" class="tj-item" @click="goDetailPage(item.id)">
              <div style="height:200px">
                <img :src="Host+'/upimg/' + item.img_url" width="270" height="200"
              style="object-fit: cover;">
              </div>
              <div style="padding: 10px 0;font-weight: 600;font-size: 18px;">{{ item.name }}</div>
              <div style="margin-bottom: 20px;font-size: 16px;">{{ item.dengji }} - {{ item.price }}元</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        activeName: '评论',
        detailinfo: [],
        tongleilist: [],
        plList: [],
        plgs:0,
        isFavorite: false,
        textarea: "",
      }
    },
  
    created() {
      this.userInfo = localStorage.getItem("userInfo");
      this.userInfoid = localStorage.getItem("userInfoid");
      this.token = localStorage.getItem("token");
      this.isAdmin = localStorage.getItem("isAdmin");
      let id = this.$route.query.id;
      // 详情
      this.xiangqing(id);
      // 检查收藏状态
      this.checkFavorite(id);
      // 评论接口
      this.ckpl(id);
    },
  
    methods: {
      goDetailPage(id){
        // 在新的窗口打开
        window.open('/home/detail?id=' + id )
        
      },
      // 详情
      xiangqing(id){
        this.$api.xiangqing({
                id: id,
            }).then(res => {
          if (res.data.code === 200) {
            this.detailinfo = res.data.data
            this.tongleilist = res.data.data2
            }
          });
      },
      // 跳转订单页面
      godingdan(detailinfo) {
        this.$router.push({ path: '/home/confirm', query: { id: detailinfo.id } });
      },
      // 检查收藏状态
      checkFavorite(id) {
        this.$api.checkFavorite({
          shui_id: this.userInfoid,
          xiangqing_id: id,
        }).then(res => {
          if (res.data.code === 200) {
            this.isFavorite = true;
          } else {
            this.isFavorite = false;
            // this.favoriteId=res.data;
          }
        })
      },
      // 收藏 取消收藏
      favoriteButton(detailinfo) {
        if (this.isFavorite) {
          this.$api.deleteFavorite({
            // id: this.favoriteId
            shui_id: this.userInfoid,
            xiangqing_id: detailinfo.id,
          }).then(res => {
            console.log(res);
            if (res.data.code === 200) {
              this.$message({
                message: '已取消收藏！',
                type: 'success'
              });
              this.isFavorite = false;
            } else {
              this.$message.error(res.message)
            }
          }).catch(e => {
          })
        } else {
          // 判断当前用户是否登录 如果该用户未登录 则需跳转登录
          if(this.userInfo){
              function getCurrentDate(format) {
              var now = new Date();
              var year = now.getFullYear(); //得到年份
              var month = now.getMonth();//得到月份
              var date = now.getDate();//得到日期
              var day = now.getDay();//得到周几
              var hour = now.getHours();//得到小时
              var minu = now.getMinutes();//得到分钟
              var sec = now.getSeconds();//得到秒
              month = month + 1;
              if (month < 10) month = "0" + month;
              if (date < 10) date = "0" + date;
              if (hour < 10) hour = "0" + hour;
              if (minu < 10) minu = "0" + minu;
              if (sec < 10) sec = "0" + sec;
              var time = "";
              //精确到天
              if (format == 1) {
                time = year + "-" + month + "-" + date;
              }
              //精确到分
              else if (format == 2) {
                time = year + "-" + month + "-" + date + " " + hour + ":" + minu + ":" + sec;
              }
              return time;
            }
            var currentDate = getCurrentDate(1);
            console.log(detailinfo)
            this.$api.addFavorite({
              shui_id: this.userInfoid,
              jingqu_id: detailinfo.id,
              // 时间
              sc_date: currentDate,
            }).then(res => {
              console.log(res);
              if (res.data.code === 200) {
                this.$message({
                  message: '已收藏！',
                  type: 'success'
                });
                this.isFavorite = true;
                this.favoriteId = res.data;
              } else {
                this.$message.error(res.message)
              }
            }).catch(e => {
            })
          }else{
            this.$message.warning("请您先登录后再尝试收藏~");
          }
  
        }
      },
      // 评论
      addComment(id) {
          // 判断当前用户是否登录 如果该用户未登录 则需跳转登录
          if(this.userInfo){
            if(this.textarea){
              function getCurrentDate(format) {
              var now = new Date();
              var year = now.getFullYear(); //得到年份
              var month = now.getMonth();//得到月份
              var date = now.getDate();//得到日期
              var day = now.getDay();//得到周几
              var hour = now.getHours();//得到小时
              var minu = now.getMinutes();//得到分钟
              var sec = now.getSeconds();//得到秒
              month = month + 1;
              if (month < 10) month = "0" + month;
              if (date < 10) date = "0" + date;
              if (hour < 10) hour = "0" + hour;
              if (minu < 10) minu = "0" + minu;
              if (sec < 10) sec = "0" + sec;
              var time = "";
              //精确到天
              if(format==1){
                  time = year + "-" + month + "-" + date;
              }
              //精确到分
              else if(format==2){
                  time = year + "-" + month + "-" + date+ " " + hour + ":" + minu + ":" + sec;
              }
              return time;
              }
              var currentDate = getCurrentDate(1);
              this.$api.pl({
                  shui_id:this.userInfoid,
                  pl_date:currentDate,
                  jingqu_id:id,
                  content:this.textarea,
              }).then(res=>{
                  if(res.data.code===200){
                      this.$message({
                          message: '留言成功！留言正在审核中',
                          type: 'success'
                      });
                      this.textarea='';
                  }else {
                      this.$message.error("留言失败！" + res.data.message);
                  }
              }).catch(()=>{
                  this.$message.error("留言失败！");
              });
  
            }else{
                this.$message.error("留言为空！");
            }
          }else{
            this.$message.warning("请您先登录后再尝试留言~");
          }
      },
      // 查看id已审核通过评论
      ckpl(id){
        this.$api.ckpl({
                spid: id,
                pageNum:1,
                pageSize:10
            }).then(res=>{
            if(res.data.code===200){
                this.plList=res.data.data;
                this.plgs = res.data.zs
                console.log(res.data.data)
            }else {
                
            }
        })
      },
  
    }
  }
  </script>
  
  <style scoped>
  .wh-100 {
    width: 100%;
    height: 100%;
  }
  
  .detail-top,
  .detail-bottom {
    display: flex;
  }
  
  .top-left,
  .bottom-left {
    flex: 1;
  }
  
  .top-right,
  .bottom-right {
    width: 275px;
  }
  
  .detail-top {
    height: 373px;
  }
  
  .top-left {
    display: flex;
  }
  
  .cover-img {
    width: 255px;
    height: 200px;
    background-color: #ccc;
    margin-right: 40px;
  }
  
  .row-item {
    line-height: 18px;
    font-size: 14px;
    margin-bottom: 5px;
  }
  
  .blue {
    color: #315c9e;
  }
  </style>