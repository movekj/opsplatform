<template>
  <div>
    <div slot="header" style="text-align: left;">
      <span>
        资源列表
      </span>
      <div style="float: right">
        <el-button type="primary" @click="resourceDialogVisible = true; opType='add'"
        >添加</el-button>
      </div>
    </div>
    <el-table :data="resources">
      <el-table-column label="名称" prop="name"></el-table-column>
      <el-table-column label="ref" prop="ref"></el-table-column>
      <el-table-column label="类型" prop="type"></el-table-column>

      <el-table-column
        label="操作"
        width="120">
          <template slot-scope="scope">
            <el-button
              @click.native.prevent="openEditResourceDialog(scope.row)"
              type="text"
              size="small">
              编辑
            </el-button>
            <el-button
              @click.native.prevent="deleteResource(scope.row)"
              type="text"
              size="small">
              删除
            </el-button>
          </template>
        </el-table-column>
    </el-table>
    <el-dialog
      :visible.sync="resourceDialogVisible"
      :title="opTypeMap[opType]"
    >
      <el-form :model="resourceForm" ref="resourceRef" :rules="resourceFormRule">
        <el-form-item label="名称" prop="name">
          <el-input v-model="resourceForm.name"></el-input>
        </el-form-item>
        <el-form-item label="ref" prop="ref">
          <el-input v-model="resourceForm.ref" :disabled="opType === 'edit'"></el-input>
        </el-form-item>
        <el-form-item label="类型" prop="type">
          <el-radio-group v-model="resourceForm.type" :disabled="opType === 'edit'">
            <el-radio-button label="module"></el-radio-button>
            <el-radio-button label="api"></el-radio-button>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="resourceDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleResource">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import http from "@/api"
export default {
  name: "ResourceCp",
  data(){
    return {
      resources: [],
      opType: '',
      opTypeMap: {
        add: '添加角色',
        edit: '编辑角色'
      },
      resourceFormRule:{
        name: [
          { required: true,  message: '请输入名称', trigger: 'blur' }
        ],
        ref: [
          { required: true,  message: '请输入ref', trigger: 'blur' }
        ],
        type: [
          { required: true,  message: '请输入类型', trigger: 'blur' }
        ]
      },
      resourceForm:{
        name: '',
        ref: '',
        type: ''
      },
      emptyResourceForm:{

      },
      resourceDialogVisible: false
    }
  },
  mounted() {
    this.getResources()
  },
  methods:{
    addResource(){
      this.$refs['resourceRef'].validate((valid)=>{
        if (valid){
          http.post("/api/v1/permissions/resource/", this.resourceForm).then(()=>{
            this.getResources()
            this.$refs['resourceRef'].resetFields()
            this.resourceForm = Object.assign({}, this.emptyResourceForm)
            this.resourceDialogVisible = false
          })
        }
      })
    },
    deleteResource(resource){
      this.$confirm('此操作将永久删除资源[' + resource.name + '@' + resource.type +'], 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        http.delete('/api/v1/permissions/resource/', {data: {id: resource.id}}).then(()=>{
          this.getResources()
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
    editResource(){
      this.$refs['resourceRef'].validate((valid)=>{
        if (valid){
          http.put("/api/v1/permissions/resource/", this.resourceForm).then(()=>{
            this.getResources()
            this.$refs['resourceRef'].resetFields()
            this.resourceForm = Object.assign({}, this.emptyResourceForm)
            this.resourceDialogVisible = false
          })
        }
      })
    },

    handleResource(){
      if (this.opType === 'add'){
        this.addResource()
      }
      if (this.opType === 'edit'){
        this.editResource()
      }
    },
    openEditResourceDialog(resource){
      this.emptyResourceForm = Object.assign({}, this.resourceForm)
      this.resourceForm = Object.assign({}, resource)
      this.resourceDialogVisible = true
      this.opType = 'edit'
    },
    getResources(){
      http.get("/api/v1/permissions/resource/").then(resp=>{
        this.resources = resp.data
      })
    }
  }
}
</script>
<style scoped>

</style>