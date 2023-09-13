<template>
  <div style="width: 100%; display: flex; justify-content: left">
    <div style="width: 50%">
        <div slot="header" style="text-align: left;">
        <span>
          角色列表
        </span>
        <div style="float: right">
          <el-button type="primary" @click="roleDialogVisible = true; opType='add'"
          >添加</el-button>
        </div>
      </div>
      <el-table :data="roles" @row-click="handleRowClick">
        <el-table-column label="名称" prop="name">
        </el-table-column>
        <el-table-column
          label="操作"
          width="120">
            <template slot-scope="scope">
              <el-button
                @click.native.prevent="openEditRoleDialog(scope.row)"
                type="text"
                size="small">
                编辑
              </el-button>
              <el-button
                @click.native.prevent="deleteRole(scope.row)"
                type="text"
                size="small">
                删除
              </el-button>
            </template>
        </el-table-column>
      </el-table>
    </div>
    <el-divider direction="vertical" ></el-divider>
    <el-dialog
      :visible.sync="roleDialogVisible"
      :title="opTypeMap[opType]"
    >
      <el-form :model="roleForm">
        <el-form-item label="名称" prop="name">
          <el-input v-model="roleForm.name"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="roleDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleRole">确 定</el-button>
      </span>
    </el-dialog>
    <router-view></router-view>
  </div>

</template>
<script>
import http from "@/api"

export default {
  name: "RoleCp",
  data(){
    return {
      roleForm: {
        name: '',
        id: ''
      },
      emptyRoleForm: {},
      opType: '',
      opTypeMap: {
        add: '添加角色',
        edit: '编辑角色'
      },
      roles: [],
      roleDialogVisible: false
    }
  },
  mounted() {
    this.getRoles()
  },
  methods: {
    getRoles(){
      http.get('/api/v1/permissions/role/').then((resp)=>{
        this.roles = resp.data
      })
    },
    addRole(){
      http.post('/api/v1/permissions/role/', this.roleForm).then(()=>{
        this.getRoles()
        this.roleDialogVisible = false
      })
    },
    editRole(){
      http.put('/api/v1/permissions/role/',  this.roleForm).then(()=>{
        this.getRoles()
        this.roleDialogVisible = false
      })
    },
    deleteRole(role){
      this.$confirm('此操作将永久删除角色[' + role.name +'], 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        http.delete('/api/v1/permissions/role/', {data: {id: role.id}}).then(()=>{
          this.getRoles()
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    openEditRoleDialog(role){
      this.emptyRoleForm = Object.assign({}, this.roleForm)
      this.roleForm =  Object.assign({}, role)
      this.opType = 'edit'
      this.roleDialogVisible = true
    },
    handleRowClick(row){
      this.$router.push({
        path:'/permissionManage/role/rule',
        query:{
          id: row.id
        }})
    },
    handleRole(){
      if (this.opType === 'add'){
        this.addRole()
      }
      if (this.opType === 'edit'){
        this.editRole()
      }

    }
  }
}
</script>
<style scoped>
  .el-divider {
   height: 100vh
  }

</style>