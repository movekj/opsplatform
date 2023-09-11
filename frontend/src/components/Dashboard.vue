<template>
  <div>
    <el-menu
        :default-active="activeIndex"
        class="el-menu-demo"
        background-color="#545c64"
        text-color="#fff"
        active-text-color="#ffd04b"
        mode="horizontal"
        router
    >
      <el-menu-item index="/stree">服务树</el-menu-item>
      <el-menu-item index="/hostManage">主机管理</el-menu-item>
      <el-menu-item index="/permissionManage">权限管理</el-menu-item>
      <el-menu-item index="/userManage">用户管理</el-menu-item>
    </el-menu>
    <router-view></router-view>
  </div>
</template>
<script>
export default {
  name: 'DashboardCp',
  data () {
    return {
      activeIndex: '/stree'
    }
  },
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
