<template>
  <div style="display: flex; justify-content: left">
    <el-menu
      default-active="/permissionManage/role"
      router
    >
      <el-menu-item index="/permissionManage/role">
        <span slot="title">角色</span>
      </el-menu-item>
      <el-menu-item index="/permissionManage/resource" >
        <span slot="title">资源</span>
      </el-menu-item>
      <el-menu-item index="/permissionManage/verb">
        <span slot="title">动作</span>
      </el-menu-item>
    </el-menu>
    <div style="padding: 20px; width: 100%">

      <router-view></router-view>
    </div>
  </div>
</template>
<script>
export default {
  name: 'PermissionCp',
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
.el-menu {
  width: 160px;
  padding-right: 10px;
  height: calc(100vh - 60px);

}
.el-menu-item {
  width: 100%;
}
</style>
