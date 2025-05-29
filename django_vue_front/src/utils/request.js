import axios from 'axios'
import { ElMessage } from 'element-plus'
import Router from '../router'

let hostURL = 'http://127.0.0.1:8000'

// 创建axios实例
const request = axios.create({
  baseURL: hostURL,
  timeout: 15000, // 请求超时时间
})

// 响应拦截器
request.interceptors.response.use(
  res => {
    if (res.data.code && res.data.code !== 200) {
      if (res.data.code === 401) {
        Router.push("/login")
        localStorage.clear()
      }
      ElMessage({
        showClose: true,
        message: res.data.message || "Unknown error",
        type: 'warning',
      })
    }
    return res
  },
  error => {
    let errorMessage = error.response?.data?.message || "Internal error"
    ElMessage({
      showClose: true,
      message: errorMessage,
      type: 'error',
    })
    return Promise.reject(error)  // ✅ Return a rejected promise for better error handling
  }
);

// 请求拦截器
request.interceptors.request.use(
  config => {
    let token = localStorage.getItem("token");
    if (token) {
      config.headers['Ac-Token'] = token
    }
    return config
  },
  error => {
    console.error("Request error:", error);
    return Promise.reject(error);
  }
);

export default request;
