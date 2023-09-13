<template>
  <div>
    <div slot="header" style="text-align: left;">
      <span>
        动作列表
      </span>
      <div style="float: right">
        <el-button type="primary" @click="verbDialogVisible = true; opType='add'"
        >添加</el-button>
      </div>
    </div>
    <el-table :data="verbs">
      <el-table-column label="名称" prop="name"></el-table-column>
    

      <el-table-column
        label="操作"
        width="120">
          <template slot-scope="scope">
            <el-button
              @click.native.prevent="openEditVerbDialog(scope.row)"
              type="text"
              size="small">
              编辑
            </el-button>
            <el-button
              @click.native.prevent="deleteverb(scope.row)"
              type="text"
              size="small">
              删除
            </el-button>
          </template>
        </el-table-column>
    </el-table>
    <el-dialog
      :visible.sync="verbDialogVisible"
      :title="opTypeMap[opType]"
    >
      <el-form :model="verbForm" ref="verbRef" :rules="verbFormRule">
        <el-form-item label="名称" prop="name">
          <el-input v-model="verbForm.name"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="verbDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleverb">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import http from "@/api"
export default {
  name: "VerbCp",
  data(){
    return {
      verbs: [],
      opType: '',
      opTypeMap: {
        add: '添加动作',
        edit: '编辑动作'
      },
      verbFormRule:{
        name: [
          { required: true,  message: '请输入名称', trigger: 'blur' }
        ],
      },
      verbForm:{
        name: '',
        ref: '',
        type: ''
      },
      emptyVerbForm:{

      },
      verbDialogVisible: false
    }
  },
  mounted() {
    this.getverbs()
  },
  methods:{
    addverb(){
      this.$refs['verbRef'].validate((valid)=>{
        if (valid){
          http.post("/api/v1/permissions/verb/", this.verbForm).then(()=>{
            this.getverbs()
            this.$refs['verbRef'].resetFields()
            this.verbForm = Object.assign({}, this.emptyVerbForm)
            this.verbDialogVisible = false
          })
        }
      })
    },
    deleteverb(verb){
      this.$confirm('此操作将永久删除资源[' + verb.name + '], 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        http.delete('/api/v1/permissions/verb/', {data: {id: verb.id}}).then(()=>{
          this.getverbs()
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
    editverb(){
      this.$refs['verbRef'].validate((valid)=>{
        if (valid){
          http.put("/api/v1/permissions/verb/", this.verbForm).then(()=>{
            this.getverbs()
            this.$refs['verbRef'].resetFields()
            this.verbForm = Object.assign({}, this.emptyVerbForm)
            this.verbDialogVisible = false
          })
        }
      })
    },

    handleverb(){
      if (this.opType === 'add'){
        this.addverb()
      }
      if (this.opType === 'edit'){
        this.editverb()
      }
    },
    openEditVerbDialog(verb){
      this.emptyVerbForm = Object.assign({}, this.verbForm)
      this.verbForm = Object.assign({}, verb)
      this.verbDialogVisible = true
      this.opType = 'edit'
    },
    getverbs(){
      http.get("/api/v1/permissions/verb/").then(resp=>{
        this.verbs = resp.data
      })
    }

  }
}
</script>
<style scoped>

</style>