import request from './request';

const api = {
    // 前台 Api
    // 首页 Api
    // 全部分类
    flquanbu(query) {
        return request({
            url: '/hello/jqysh/',
            method: 'get',
            params: query
        });
    },
    // 分类筛选
    flshaixuan(query) {
        return request({
            url: '/hello/jqysh/',
            method: 'get',
            params: query
        });
    },
    // 地区筛选
    dqshaixuan(query) {
        return request({
            url: '/hello/jqysh/',
            method: 'get',
            params: query
        });
    },
    // 已审核景区
    getList(query) {
        return request({
            url: '/hello/jqysh/',
            method: 'get',
            params: query
        });
    },
    // 景区分类
    getfl(query) {
        return request({
            url: '/hello/fl/',
            method: 'get',
            params: query
        });
    },
    // 景区地区
    getdq(query) {
        return request({
            url: '/hello/dq/',
            method: 'get',
            params: query
        });
    },
    // 景区协同过滤算法
    xtgl(query) {
        return request({
            url: '/hello/xtgl/',
            method: 'get',
            params: query
        });
    },
    // 景区轮播图
    lb(query) {
        return request({
            url: '/hello/lb/',
            method: 'get',
            params: query
        });
    },


    // 详情页 Api
    // 检查收藏
    checkFavorite(query) {
        return request({
            url: '/hello/sc/' + query.xiangqing_id + '/',
            method: 'get',
            params: query
        });
    },
    // 收藏
    addFavorite(data) {
        return request({
            url: '/hello/sc/',
            method: 'post',
            data: data
        });
    },
    // 取消收藏
    deleteFavorite(data) {
        return request({
            url: '/hello/sc/' + data.xiangqing_id + '/',
            method: 'put',
            data: data
        });
    },
    // 查看评论
    ckpl(query){
        return request({
            url: '/hello/plysh/',
            method: 'get',
            params: query
        });
    },
    // 详情评论
    pl(data) {
        return request({
            url: '/hello/pl/',
            method: 'post',
            data: data
        });
    },


    // 确认页 Api
    // 订单
    xiangqing(query) {
        return request({
            url: '/hello/jq/' + query.id + '/',
            method: 'get',
            params: query
        });
    },
    // 地址
    getAddress(query) {
        return request({
            url: '/hello/dz/',
            method: 'get',
            params: query
        });
    },
    // 支付
    addOrder(data) {
        return request({
            url: '/hello/dd/',
            method: 'post',
            data: data
        });
    },


    // 个人 Api
    // 我的评论
    mypinglun(query) {
        return request({
            url: '/hello/plysh/',
            method: 'get',
            params: query
        });
    },
    // 我的收藏
    myshoucang(query) {
        return request({
            url: '/hello/sc/',
            method: 'get',
            params: query
        });
    },
    // 我的订单
    mydingdan(query) {
        return request({
            url: '/hello/dd/',
            method: 'get',
            params: query
        });
    },
    // 我的地址
    mydz(query) {
        return request({
            url: '/hello/dz/',
            method: 'get',
            params: query
        });
    },
    // 修改地址
    updatedizhi(data) {
        return request({
            url: '/hello/dz/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除地址
    deletedizhi(data) {
        return request({
            url: '/hello/dz/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建地址
    createdizhi(data) {
        return request({
            url: '/hello/dz/',
            method: 'post',
            data: data
        });
    },
    
    // 修改个人信息
    updatexinxi(data){
        return request({
            url: '/hello/guanli/' + data.id + '/',
            method: 'put',
            data: data
        });
    },


    


    // 后台 Api
    // 卖家 Api
    // 查看卖家
    gethtcs(query) {
        return request({
            url: '/hello/cs/',
            method: 'get',
            params: query
        });
    },
    // 修改卖家
    updatehtcs(data) {
        return request({
            url: '/hello/cs/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除卖家
    deletehtcs(data) {
        return request({
            url: '/hello/cs/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建卖家
    createhtcs(data) {
        return request({
            url: '/hello/cs/',
            method: 'post',
            data: data
        });
    },

    // 买家 Api
    // 查看买家
    gethtgm(query) {
        return request({
            url: '/hello/gm/',
            method: 'get',
            params: query
        });
    },
    // 修改买家
    updatehtgm(data) {
        return request({
            url: '/hello/gm/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除买家
    deletehtgm(data) {
        return request({
            url: '/hello/gm/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建买家
    createhtgm(data) {
        return request({
            url: '/hello/gm/',
            method: 'post',
            data: data
        });
    },

    // 轮播 Api
    // 查看轮播
    gethtlb(query) {
        return request({
            url: '/hello/lb/',
            method: 'get',
            params: query
        });
    },
    // 修改轮播
    updatehtlb(data) {
        return request({
            url: '/hello/lb/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除轮播
    deletehtlb(data) {
        return request({
            url: '/hello/lb/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建轮播
    createhtlb(data) {
        return request({
            url: '/hello/lb/',
            method: 'post',
            data: data
        });
    },

    // 分类 Api
    // 查看分类
    gethtfl(query) {
        return request({
            url: '/hello/fl/',
            method: 'get',
            params: query
        });
    },
    // 修改分类
    updatehtfl(data) {
        return request({
            url: '/hello/fl/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除分类
    deletehtfl(data) {
        return request({
            url: '/hello/fl/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建分类
    createhtfl(data) {
        return request({
            url: '/hello/fl/',
            method: 'post',
            data: data
        });
    },

    // 地区 Api
    // 查看地区
    gethtdq(query) {
        return request({
            url: '/hello/dq/',
            method: 'get',
            params: query
        });
    },
    // 修改地区
    updatehtdq(data) {
        return request({
            url: '/hello/dq/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除地区
    deletehtdq(data) {
        return request({
            url: '/hello/dq/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建地区
    createhtdq(data) {
        return request({
            url: '/hello/dq/',
            method: 'post',
            data: data
        });
    },

    // 个人信息 Api
    // 查看信息
    gethtguanli(query) {
        return request({
            url: '/hello/guanli/',
            method: 'get',
            params: query
        });
    },
    // 修改信息
    updatehtguanli(data) {
        return request({
            url: '/hello/guanli/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除信息
    deletehtguanli(data) {
        return request({
            url: '/hello/guanli/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建信息
    createhtguanli(data) {
        return request({
            url: '/hello/guanli/',
            method: 'post',
            data: data
        });
    },

    // 商品 Api
    // 查看信息
    gethtsp(query) {
        return request({
            url: '/hello/jq/',
            method: 'get',
            params: query
        });
    },
    // 修改信息
    updatehtsp(data) {
        return request({
            url: '/hello/jq/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除信息
    deletehtsp(data) {
        return request({
            url: '/hello/jq/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建信息
    createhtsp(data) {
        return request({
            url: '/hello/jq/',
            method: 'post',
            data: data
        });
    },

    // 地址 Api
    // 查看地址
    gethtdz(query) {
        return request({
            url: '/hello/dz/',
            method: 'get',
            params: query
        });
    },
    // 修改地址
    updatehtdz(data) {
        return request({
            url: '/hello/dz/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除地址
    deletehtdz(data) {
        return request({
            url: '/hello/dz/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建地址
    createhtdz(data) {
        return request({
            url: '/hello/dz/',
            method: 'post',
            data: data
        });
    },

    // 订单 Api
    // 查看订单
    gethtdd(query) {
        return request({
            url: '/hello/dd/',
            method: 'get',
            params: query
        });
    },
    // 修改订单
    updatehtdd(data) {
        return request({
            url: '/hello/dd/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 删除订单
    deletehtdd(data) {
        return request({
            url: '/hello/dd/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },
    // 创建订单
    createhtdd(data) {
        return request({
            url: '/hello/dd/',
            method: 'post',
            data: data
        });
    },
    
    // 景区审核 Api
    // 景区待审核
    gethtjqsh(query) {
        return request({
            url: '/hello/jqdsh/',
            method: 'get',
            params: query
        });
    },
    // 景区审核
    updatehtjqsh(data) {
        return request({
            url: '/hello/jq/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 景区已审核
    gethtjqysh(query) {
        return request({
            url: '/hello/jqysh/',
            method: 'get',
            params: query
        });
    },



    // 评论待审核 Api
    gethtpldsh(query) {
        return request({
            url: '/hello/pl/',
            method: 'get',
            params: query
        });
    },
    // 评论审核
    updatehtplsh(data) {
        return request({
            url: '/hello/pl/' + data.id + '/',
            method: 'put',
            data: data
        });
    },
    // 评论已审核
    gethtplysh(query) {
        return request({
            url: '/hello/plysh/',
            method: 'get',
            params: query
        });
    },


    // 评论 Api
    // 查看评论
    gethtpl(query) {
        return request({
            url: '/hello/qbpl/',
            method: 'get',
            params: query
        });
    },
    // 删除评论
    deletehtpl(data) {
        return request({
            url: '/hello/pl/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },

    // 收藏 Api
    // 查看收藏
    gethtsc(query) {
        return request({
            url: '/hello/sc/',
            method: 'get',
            params: query
        });
    },
    // 删除收藏
    deletehtsc(data) {
        return request({
            url: '/hello/sc/' + data.id + '/',
            method: 'delete',
            data: data
        });
    },


    

};


export default api;