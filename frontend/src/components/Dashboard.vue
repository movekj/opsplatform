<template>
  <div style="height: 100%">
    <el-menu
        :default-active="activeIndex"
        class="el-menu"
        background-color="#545c64"
        text-color="#fff"
        active-text-color="#ffd04b"
        mode="horizontal"
        router
    >

      <el-menu-item index="/stree/detail" v-if='HasPerm($store.state.rbac, [{ref:"module.stree",verb:"read"}])'>服务树</el-menu-item>
      <el-menu-item index="/hostManage" v-if='HasPerm($store.state.rbac, [{ref:"module.hosts",verb:"read"}])'>主机管理</el-menu-item>
      <el-menu-item index="/permissionManage/role" v-if='HasPerm($store.state.rbac, [{ref:"module.permissions",verb:"read"}])'>权限管理</el-menu-item>
      <el-menu-item index="/userManage" v-if='HasPerm($store.state.rbac, [{ref:"module.users",verb:"read"}])'>用户管理</el-menu-item>
      <el-button type="text" style="float: right;margin-right: 20px;margin-top: 10px"
         @click="handleLoginOut"
      >退出登录</el-button>
    </el-menu>
    <router-view></router-view>

  </div>
</template>
<script>
import utils from "@/utils";
import http from "@/api"
export default {
  name: 'DashboardCp',
  data () {
    return {
      activeIndex: '/stree',
    }
  },
  mounted(){
    http.get("/api/v1/users/info/").then((resp)=>{
      this.$store.commit('commitUserinfo', resp.data)
    })
  },
  methods: {
    HasPerm: utils.HasPerm,
    handleLoginOut(){
      this.$confirm('确定退出登录？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        utils.DeleteToken2LocalStorage()
        this.$router.push({name:'login'})
        this.$message({
          type: 'success',
          message: '退出成功!'
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消退出'
        });
      });
    }
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
.el-menu{
  width: 100%;
}

</style>
