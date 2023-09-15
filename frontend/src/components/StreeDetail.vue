<template>
  <div style="height: 100%; width: 100%;margin-top: 4px; margin-left: 4px; margin-right: 4px;position: relative; ">
    <el-tabs style="height: 100%;; position: relative;" v-model="activeName" type="card" @tab-click="handleClick">
      <span> {{ $store.state.selectedNode.path }}({{  $store.state.selectedNode.typ  }})</span>

      <el-tab-pane  label="基本信息" name="basicInfo" style="height: 100%;">
        <div style="display: flex;justify-content: space-between">

          <el-card style="width: 100%;" shadow="never">
            <span style="display: block; margin-bottom: 20px">
              权限列表
            </span>
            <el-table :data="permData.result" border>
              <el-table-column label="角色" prop="name"></el-table-column>
              <el-table-column label="描述" prop="description"></el-table-column>
              <el-table-column label="用户">
                <template slot-scope="scope">
                  <div  style="display: flex; justify-content: space-between">
                    <span>
                      <span v-for="(user, index) in scope.row.users" :key="index">
                        [
                        {{ user.cname }}
                        <span
                          class="link-type"
                          v-if=" user.readonly != 1"
                          @click="handleDeleteTURD(scope.row, user)"
                          ><i class="el-icon-delete"></i
                        ></span>
                        ]
                      </span>
                    </span>
                    <i class="el-icon-plus" @click="handleAddTURDialogOpen(scope.row)"></i>
                  </div>
                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </div>
        <div style="display: flex; height: 100%;justify-content: space-between; margin-top: 10px; margin-bottom: 10px">
          <el-card style="width: 49%; overflow-y: auto" class="overflowCard" shadow="never">
            <span style="display: flex; justify-content: space-between; margin-bottom: 20px">
              配置信息
              <el-button type="primary" size="mini">确定</el-button>
            </span>

            <el-form :label-position="'right'" :model="serviceConfForm" label-width="120px">
              <el-form-item label="git地址" style="margin-bottom: 10px" prop="git">
                <el-input v-model="serviceConfForm.git"></el-input>
              </el-form-item>
              <el-form-item label="运维负责人" style="margin-bottom: 10px" prop="opadmin">
                <el-input v-model="serviceConfForm.opadmin"></el-input>
              </el-form-item>
              <el-form-item label="研发负责人" style="margin-bottom: 10px" prop="rdadmin">
                <el-input v-model="serviceConfForm.rdadmin"></el-input>
              </el-form-item>
              <el-form-item label="域名" style="margin-bottom: 10px" prop="domain">
                <el-input v-model="serviceConfForm.domain"></el-input>
              </el-form-item>
              <el-form-item label="打包命令" style="margin-bottom: 10px" prop="build_command">
                <el-input v-model="serviceConfForm.build_command"></el-input>
              </el-form-item>
              <el-form-item label="启动命令" style="margin-bottom: 10px" prop="start_command">
                <el-input v-model="serviceConfForm.start_command"></el-input>
              </el-form-item>
            </el-form>


          </el-card>
          <el-card style="width: 50%;overflow-y: auto"  class="overflowCard"  shadow="never">
            <span style="display: block; margin-bottom: 20px">
              主机列表
            </span>
          </el-card>
        </div>
      </el-tab-pane>
      <el-tab-pane label="打包发布" name="third">角色管理</el-tab-pane>
    </el-tabs>
    <el-dialog
      :visible.sync="addTURDialogVisible"
      @open="getUserOptions"
      title="添加用户"
    >
      <el-form>

        <el-form-item label="用户">
          <el-select v-model="treeNodeRuleUserForm.user_ids" multiple>
            <el-option :key="option.id"
                       :label="option.cname"
                       :value="option.id"
                       v-for="option in userOptions">
            </el-option>
          </el-select>

        </el-form-item>

      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addTURDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleAddTUR" >确 定</el-button>
      </span>

    </el-dialog>
  </div>
</template>
<script>
import http from '@/api'
import {TreeOperation} from "@/const"


export default {
  name: 'StreeDetailCp',

  data(){
    return {
      activeName: "basicInfo",
      permData: [],
      addTURDialogVisible: false,
      userOptions: [],
      serviceConfForm: {
        git: '',
        opadmin: '',
        rdadmin: '',
        domain: '',
        start_command: '',
        build_command: ''
      },
      treeNodeRuleUserForm: {
        user_ids: [],
        tree_id: '',
        role_id: ''
      },
      emptyTreeNodeRuleUserForm: {
        user_ids: [],
        tree_id: '',
        role_id: ''
      }
    }
  },
  watch:{
    "$store.state.selectedNode.id": {
      handler(){
        this.getPermData()
      },
      immediate:true
    }
  },
  methods:{
    handleClick(){

    },
    getUserOptions(){
      http.get("/api/v1/users/",).then((resp)=>{
        this.userOptions = resp.data
      })
    },
    handleAddTURDialogOpen(row){
      this.addTURDialogVisible = true
      this.treeNodeRuleUserForm.role_id = row.id
      this.treeNodeRuleUserForm.tree_id = this.$store.state.selectedNode.id
    },
    handleAddTUR(){
      http.post('/api/v1/stree/node/perm', this.treeNodeRuleUserForm).then(()=>{
        this.addTURDialogVisible = false
        this.getPermData()
        this.treeNodeRuleUserForm = Object.assign({}, this.emptyTreeNodeRuleUserForm)
      })
    },
    handleDeleteTURD(row, user){
     this.$confirm('是否删除用户['+ user.cname + ']的'+ row.name +'@' + this.$store.state.selectedNode.path + '权限?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
     }).then(() => {
        http.delete('/api/v1/stree/node/perm', {data:{
          role_id:row.id, user_id: user.id,tree_id: this.$store.state.selectedNode.id}
        }).then(()=>{
          this.getPermData()
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
    getPermData(){
      if (this.$store.state.selectedNode.id === 0 || this.$store.state.selectedNode.id === TreeOperation.newNodeId){
        return
      }
      http.get("/api/v1/stree/node/perm",{params:{id: this.$store.state.selectedNode.id}}).then((resp)=>{
        this.permData = resp.data
      })
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.el-form-item{
  margin: 0;
}
.el-form-item__content{
  line-height: 30px !important;
}
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

.overflowCard{

  overflow: auto;


}
a {
  color: #42b983;
}
.custom-tree-node{
  width: 100%;
}
.el-tabs{
  height: 100% !important;
}
</style>
