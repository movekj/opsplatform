<template>
  <div style='width: 30%; height: 100vh; margin:100px auto 0 auto'>
    <el-card >
      <div slot="header" style="text-align: left">
        <h2 style="text-align: center"> 运维资产管理平台</h2>
        <span>
            登录
        </span>

      </div>
      <el-form :model="loginForm" :rules="loginFormRule" ref="loginForm">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="loginForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="loginForm.password"></el-input>
        </el-form-item>
      </el-form>
      <div style="display: flex; justify-content: right">
        <el-button>
          取消
        </el-button>
        <el-button type="primary" @click="handleLogin">
          登录
        </el-button>
      </div>
    </el-card>
  </div>

</template>
<script>
import utils from "@/utils.js"
import http from "@/api.js"

export default {
  name: 'LoginCp',
  data(){
    return {
      loginForm: {
        username: '',
        password: ''
      },
      loginDialogVisible: false,
      loginFormRule: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ],
      }
    }
  },
  methods:{
      handleLogin(){
      this.$refs['loginForm'].validate((valid)=>{
        if (valid){
          http.post('api/v1/users/login/', this.loginForm).then(resp =>{
            utils.SetToken2LocalStorage(resp.data.token)
            this.$router.push('/')
          })
        }
      })
    }

  }
}
</script>

<style scoped>


</style>