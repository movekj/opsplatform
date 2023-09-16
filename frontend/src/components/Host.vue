<template>
  <div>
    <div slot="header" style="text-align: left;">
      <span>
        主机列表
      </span>
      <div style="float: right">
        <el-button type="primary" @click="hostDialogVisible = true; opType='add'"
        >添加</el-button>
      </div>
    </div>
    <el-table :data="hosts">
      <el-table-column label="主机名" prop="hostname"></el-table-column>
      <el-table-column label="ip地址" prop="ip"></el-table-column>
      <el-table-column label="CPU核心数" prop="cpu"></el-table-column>
      <el-table-column label="内存" prop="memory"></el-table-column>
      <el-table-column label="系统" prop="os"></el-table-column>
      <el-table-column label="管理用户" prop="username"></el-table-column>
      <el-table-column label="密码" prop="password"></el-table-column>
      <el-table-column label="主机位置" prop="position"></el-table-column>
      <el-table-column
        label="操作"
        width="120">
          <template slot-scope="scope">
            <el-button
              @click.native.prevent="openEditHostDialog(scope.row)"
              type="text"
              size="small">
              编辑
            </el-button>
            <el-button
              @click.native.prevent="deleteHost(scope.row)"
              type="text"
              size="small">
              删除
            </el-button>
          </template>
        </el-table-column>
    </el-table>
    <el-dialog
      :visible.sync="hostDialogVisible"
      :title="opTypeMap[opType]"
    >
      <el-form :model="hostForm" ref="hostRef" :rules="hostFormRule">
        <el-form-item label="主机名" prop="hostname">
          <el-input v-model="hostForm.hostname"></el-input>
        </el-form-item>
        <el-form-item label="ip地址" prop="ip">
          <el-input v-model="hostForm.ip"></el-input>
        </el-form-item>
        <el-form-item label="CPU核心数" prop="cpu">
          <el-input v-model="hostForm.cpu"></el-input>
        </el-form-item>
        <el-form-item label="操作系统" prop="os">
          <el-input v-model="hostForm.os"></el-input>
        </el-form-item>
        <el-form-item label="内存" prop="memory">
          <el-input v-model="hostForm.memory"></el-input>
        </el-form-item>
        <el-form-item label="管理用户名" prop="username">
          <el-input v-model="hostForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="hostForm.password"></el-input>
        </el-form-item>
        <el-form-item label="主机位置" prop="position">
          <el-input v-model="hostForm.position"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="hostDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleHost">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import http from "@/api"
export default {
  name: "HostCp",
  data(){
    return {
      hosts: [],
      opType: '',
      opTypeMap: {
        add: '添加主机',
        edit: '编辑主机'
      },
      hostFormRule:{
        hostname: [
          { required: true,  message: '请输入主机名', trigger: 'blur' }
        ],
        ip: [
          { required: true,  message: '请输入IP地址', trigger: 'blur' }
        ],
        os: [
          { required: true,  message: '请输入系统', trigger: 'blur' }
        ],
        memory: [
          { required: true,  message: '请输入内存', trigger: 'blur' }
        ],
        position: [
          { required: true,  message: '请输入主机位置', trigger: 'blur' }
        ],
        username: [
          { required: true,  message: '请输入管理用户名', trigger: 'blur' }
        ],
        password: [
          { required: true,  message: '请输入用户管理密码', trigger: 'blur' }
        ],
        cpu: [
          { required: true,  message: '请输入CPU核心数', trigger: 'blur' }
        ],
      },
      hostForm:{
        id:'',
        hostname: '',
        ip: '',
        username: '',
        password: '',
        os: '',
        memory: '',
        position: '',
        cpu: ''
      },
      emptyHostForm:{

      },
      hostDialogVisible: false
    }
  },
  mounted() {
    this.getHosts()
  },
  methods:{
    addHost(){
      this.$refs['hostRef'].validate((valid)=>{
        if (valid){
          http.post("/api/v1/hosts/", this.hostForm).then(()=>{
            this.getHosts()
            this.$refs['hostRef'].resetFields()
            this.hostForm = Object.assign({}, this.emptyHostForm)
            this.hostDialogVisible = false
          })
        }
      })
    },
    deleteHost(host){
      this.$confirm('此操作将永久删除主机[' + host.hostname + '@' + host.ip +'], 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        http.delete('/api/v1/hosts/', {data: {id: host.id}}).then(()=>{
          this.getHosts()
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
    editHost(){
      this.$refs['hostRef'].validate((valid)=>{
        if (valid){
          http.put("/api/v1/hosts/", this.hostForm).then(()=>{
            this.getHosts()
            this.$refs['hostRef'].resetFields()
            this.hostForm = Object.assign({}, this.emptyHostForm)
            this.hostDialogVisible = false
          })
        }
      })
    },

    handleHost(){
      if (this.opType === 'add'){
        this.addHost()
      }
      if (this.opType === 'edit'){
        this.editHost()
      }
    },
    openEditHostDialog(host){
      this.emptyHostForm = Object.assign({}, this.hostForm)
      this.hostForm = Object.assign({}, host)
      this.hostForm.id = host.id
      this.hostDialogVisible = true
      this.opType = 'edit'
    },
    getHosts(){
      http.get("/api/v1/hosts/").then(resp=>{
        this.hosts = resp.data
      })
    }
  }
}
</script>
<style scoped>

</style>