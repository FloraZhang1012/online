<template>
    <div>
      <h2>景区列表</h2>
      <ul>
        <li v-for="jingqu in jingquList" :key="jingqu.id">
          {{ jingqu.name }} - {{ jingqu.price }} NZD
        </li>
      </ul>
    </div>
  </template>
  
  <script>
  import api from "@/utils/api.js";
  
  export default {
    data() {
      return {
        jingquList: [],
      };
    },
    async created() {
      let response = await api.get("jingqu/");
      this.jingquList = response.data;
    },
  };
  </script>
  