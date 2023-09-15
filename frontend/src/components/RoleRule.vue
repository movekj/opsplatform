

<template>
  <div style="width: 50%">
    <div slot="header" style="text-align: left;">
      <span>
        资源授权规则列表
      </span>
      <div style="float: right">
        <el-button type="primary" @click="roleRuleDialogVisible = true">
          授权
        </el-button>
      </div>
    </div>
    <el-table :data="roleRules">
      <el-table-column label="名称" prop="name">
      </el-table-column>
      <el-table-column label="ref" prop="ref">
      </el-table-column>
      <el-table-column label="类型" prop="type">
      </el-table-column>
      <el-table-column
        label="动作"
        width="120">
          <template slot-scope="scope">
            <el-tag
              closable
              @close="handleDeleteRoleRuleVerb(scope.row, verb)"
              :key="verb.id"
              v-for="verb in scope.row.verbs"
              style="margin-top: 4px"
              >{{ verb.name }}</el-tag>
          </template>
      </el-table-column>
      <el-table-column
        label="操作"
        width="120">
          <template slot-scope="scope">
            <el-button
              @click.native.prevent="handleDeleteRoleRule(scope.row)"
              type="text"
              size="small">
              删除
            </el-button>
          </template>
      </el-table-column>
    </el-table>
    <el-dialog
      :visible.sync="roleRuleDialogVisible"
      @open="handleRoleRuleDialogOpen"
      title="添加角色规则"
    >
    <el-form :model="roleRuleForm" :rules="roleRuleFormRule" ref="roleRuleFormRef">
      <el-form-item label="资源" prop="resourceId">
        <el-select v-model="roleRuleForm.resourceId">
          <el-option :key="option.id"
                     :label="option.name+'@'+option.type"
                     :value="option.id"
                     v-for="option in resourceOptions">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="动作" prop="verbIds">
        <el-select v-model="roleRuleForm.verbIds" multiple>
          <el-option :key="option.id"
                     :label="option.name"
                     :value="option.id"
                     v-for="option in verbOptions">
          </el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="roleRuleDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="handleAddRoleRule" >确 定</el-button>
    </span>
    </el-dialog>
  </div>
</template>

<script>
import http from "@/api"

export default {
  name: "RoleRule",
  data() {
    return {
      roleRuleForm: {
        resourceId: '',
        verbIds: [],
        roleId: ''
      },
      roleRuleFormRule:{
        resourceId: [
          { required: true,  message: '请选择资源', trigger: 'blur' }
        ],
        verbIds: [
          { required: true,  message: '请选择动作', trigger: 'blur' }
        ],
      },
      roleRules: [],
      roleRuleDialogVisible: false,
      verbOptions: [],
      resourceOptions: []
    }
  },
  watch:{
    "$route.query.id": {
      handler(){
        this.getRoleRules()
      },
      immediate:true
    }
  },
  mounted() {
    this.getRoleRules()
  },
  methods:{
    getverbs(){
      http.get("/api/v1/permissions/verb/").then(resp=>{
        this.verbOptions = resp.data
      })
    },
    getResources(){
      http.get("/api/v1/permissions/resource/").then(resp=>{
        this.resourceOptions = resp.data
      })
    },
    getRoleRules(){
      http.get("/api/v1/permissions/role/rule/",{params: {id: this.$route.query.id}}).then(resp=>{
        this.roleRules = resp.data
      })
    },
    handleDeleteRoleRule(row, verb){
     console.log(row, verb)
     this.$confirm('此操作将永久资源['+ row.name +'@'+ row.type + '], 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
     }).then(() => {
        http.delete('/api/v1/permissions/role/rule/', {
          data: {role_id: this.$route.query.id, resource_id: row.id}
        }).then(()=>{
          this.getRoleRules()
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

    handleDeleteRoleRuleVerb(row, verb){
     this.$confirm('此操作将永久资源['+ row.name +'@'+ row.type + ']动作[' + verb.name +'], 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
     }).then(() => {
        http.delete('/api/v1/permissions/role/rule/verb/', {
          data: {role_id: this.$route.query.id, resource_id: row.id, verb_id: verb.id}
        }).then(()=>{
          this.getRoleRules()
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
    handleAddRoleRule(){
      this.roleRuleForm.roleId = this.$route.query.id
      this.$refs['roleRuleFormRef'].validate((valid)=>{
        if (valid){
          http.post("/api/v1/permissions/role/rule/", this.roleRuleForm).then(()=>{
            this.getRoleRules()
            this.roleRuleDialogVisible = false
          })
        }
      })

    },
    handleRoleRuleDialogOpen(){
      this.getverbs()
      this.getResources()
    }
  },
}
</script>

<style scoped>

</style>