<template>
  <div>
    <el-card class="box-card">
      <div slot="header" style="text-align: left">
        <span>
            用户列表
        </span>
        <div style="float: right">
          <el-button @click="openAddUserDialog" type="primary"
          >添加</el-button>
        </div>
      </div>
      <el-table :data="users"
        style="width: 100%"
      >
        <el-table-column
          prop="username"
          label="用户名"
        >
        </el-table-column>
        <el-table-column
          prop="cname"
          label="中文名"
        >
        </el-table-column>
        <el-table-column
          prop="phone"
          label="手机号"
        >
        </el-table-column>
        <el-table-column
          prop="email"
          label="邮箱"
        >
        </el-table-column>

        <el-table-column
          fixed="right"
          label="操作"
          width="120">
            <template slot-scope="scope">
              <el-button
                @click.native.prevent="openEditUserDialog(scope.row)"
                type="text"
                size="small">
                编辑
              </el-button>
              <el-button
                @click.native.prevent="deleteUser(scope.row)"
                type="text"
                size="small">
                删除
              </el-button>
            </template>
        </el-table-column>
      </el-table>
    </el-card>
    <el-dialog
      :title="dialogTypeMap[dialogType]"
      :visible.sync="userDialogVisible"
      width="30%"
      >
        <el-form :model="userForm" :rules="userFormRule" ref="userFormRef">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="userForm.username"></el-input>
          </el-form-item>
          <el-form-item label="中文名" prop="cname">
            <el-input v-model="userForm.cname"></el-input>
          </el-form-item>
          <template v-if="dialogType === 'add'">
            <el-form-item label="密码" prop="password">
                <el-input type="password" v-model="userForm.password"></el-input>
            </el-form-item>
            <el-form-item label="再次输入密码" prop="confirm_password">
                <el-input type="password" v-model="userForm.confirm_password"></el-input>
            </el-form-item>
          </template>
          <el-form-item label="邮箱" prop="email">
            <el-input v-model="userForm.email"></el-input>
          </el-form-item>
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="userForm.phone"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="userDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="handleUser">确 定</el-button>
        </span>
    </el-dialog>
  </div>
</template>
<script>
import http from "@/api"
export default {
  name: 'UserCp',
  data(){
    var validatePassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入密码'));
      } else {
        if (this.userForm.confirm_password !== '') {
          this.$refs.userFormRef.validateField('confirm_password');
        }
        callback();
      }
    };
    var validateConfirmPassword = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.userForm.password) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {

      users: [],
      userForm: {
        id: undefined,
        password: '',
        confirm_password: '',
        username: '',
        email: '',
        phone: '',
        cname: ''
      },
      userFormRule:{
        password: [
          { required: true, validator: validatePassword, trigger: 'blur' }
        ],
        confirm_password: [
          { required: true, validator: validateConfirmPassword, trigger: 'blur' }
        ],
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        email: [
          { required: true, message: '请输入邮箱', trigger: 'blur' }
        ],
        phone: [
          { required: true, message: '请输入手机号', trigger: 'blur' }
        ],
        cname: [
          { required: true, message: '请输入中文名', trigger: 'blur' }
        ],
      },
      dialogType: '',
      dialogTypeMap: {
        add: '添加用户',
        edit: '编辑用户'
      },
      emptyuserForm: {

      },
      userDialogVisible: false

    }
  },

  mounted() {
      this.getUsers()
  },
  methods:{
    getUsers(){
      http.get('/api/v1/users/').then(resp => {
        this.users = resp.data
      })
    },
    deleteUser(user){
      this.$confirm('此操作将永久删除用户[' + user.username +'], 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        http.delete('/api/v1/users/', {data: {id: user.id}}).then(()=>{
          this.getUsers()
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
    openEditUserDialog(user){
      this.dialogType = 'edit'
      http.get('/api/v1/users/', {params: {id: user.id}}).then(resp => {
        this.emptyuserForm = Object.assign({}, this.userForm)
        this.userForm = Object.assign({}, resp.data)
        this.userDialogVisible = true
      })
    },
    editUser(){
      this.$refs["userFormRef"].validate((valid)=>{
        if (valid){
          http.put('/api/v1/users/', this.userForm).then(() => {
            this.getUsers()
            this.userForm = Object.assign({}, this.emptyuserForm)
            this.userDialogVisible = false
            this.$refs["userFormRef"].resetFields()
          })
        }

      })
    },
    addUser(){
      this.$refs["userFormRef"].validate((valid)=>{
        if (valid){
          http.post('/api/v1/users/', this.userForm).then(() => {
            this.getUsers()
            this.userForm = Object.assign({}, this.emptyuserForm)
            this.userDialogVisible = false
            this.$refs["userFormRef"].resetFields()

          })
        }
      })
    },
    handleUser(){
      if (this.dialogType === 'edit'){
        this.editUser()
      }
      if (this.dialogType === 'add'){
        this.addUser()
      }
    },
    openAddUserDialog(){
      this.dialogType = 'add'
      this.userDialogVisible = true
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
</style>
