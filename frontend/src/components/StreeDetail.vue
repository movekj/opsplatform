<template>
  <div style="height: 100%; width: 100%; margin-top: 4px; margin-left: 4px; margin-right: 4px;position: relative; " class="streeDetail">
    <el-tabs style="position: relative;" v-model="activeName" type="card" @tab-click="handleClick">
      <span>{{ TreeNodeTypeMap[$store.state.selectedNode.typ] }}: {{ $store.state.selectedNode.path }}</span>

      <el-tab-pane  label="基本信息" name="basicInfo" style="margin-top: 15px">
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
          <el-card style="width: 100%; overflow-y: auto" class="overflowCard" shadow="never" v-if="$store.state.selectedNode.typ === TreeNodeType.service || $store.state.selectedNode.typ === TreeNodeType.serviceEnv">
            <span style="display: flex; justify-content: space-between; margin-bottom: 20px">
              配置信息
              <template v-if="$store.state.selectedNode.typ === TreeNodeType.service">
                <el-button size="mini" v-if="modifyServiceConf" @click="modifyServiceConf = false">修改</el-button>
                <template  v-else>
                  <span>
                    <el-button  size="mini"  @click="modifyServiceConf=fa">取消</el-button>
                    <el-button type="primary" size="mini" @click="handleModifyServiceConf">确定</el-button>
                  </span>
                </template>
              </template>
            </span>

            <el-form :label-position="'right'" :model="serviceConfForm" label-width="120px">
              <el-form-item label="git地址:" style="margin-bottom: 10px" prop="git">
                <el-input v-model="serviceConfForm.git" v-if="!modifyServiceConf"></el-input>
                <span v-else>{{ serviceConfForm.git}}</span>
              </el-form-item>
              <el-form-item label="运维负责人:" style="margin-bottom: 10px" prop="opadmin">
                <el-input v-model="serviceConfForm.opadmin" v-if="!modifyServiceConf"></el-input>
                <span v-else>{{ serviceConfForm.opadmin}}</span>
              </el-form-item>
              <el-form-item label="研发负责人:" style="margin-bottom: 10px" prop="rdadmin">
                <el-input v-model="serviceConfForm.rdadmin" v-if="!modifyServiceConf"></el-input>
                <span v-else>{{ serviceConfForm.rdadmin}}</span>
              </el-form-item>
              <el-form-item label="域名:" style="margin-bottom: 10px" prop="domain">
                <el-input v-model="serviceConfForm.domain" v-if="!modifyServiceConf"></el-input>
                <span v-else>{{ serviceConfForm.domain}}</span>
              </el-form-item>
              <el-form-item label="打包命令:" style="margin-bottom: 10px" prop="build_command">
                <el-input v-model="serviceConfForm.build_command" type="textarea" rows="5" v-if="!modifyServiceConf"></el-input>
                <span v-else>{{ serviceConfForm.build_command}}</span>
              </el-form-item>
              <el-form-item label="启动命令:" style="margin-bottom: 10px" prop="start_command">
                <el-input v-model="serviceConfForm.start_command" type="textarea" rows="5"  v-if="!modifyServiceConf"></el-input>
                <span v-else>{{ serviceConfForm.start_command}}</span>
              </el-form-item>
            </el-form>

          </el-card>
          <el-card style="overflow-y: auto; width: 100%"  v-if="$store.state.selectedNode.typ === 'service_env'" class="overflowCard"  shadow="never">
            <span style="display: block; margin-bottom: 20px">
              主机列表
              <el-button @click="getServiceEnvHost" size="mini">刷新</el-button>
              <el-button @click="addServiceEnvHostVisible = true" type="primary" size="mini">关联主机</el-button>
            </span>
            <el-table :data="serviceEnvHosts">
              <el-table-column label="主机名" prop="hostname"></el-table-column>
              <el-table-column label="ip地址" prop="ip"></el-table-column>
              <el-table-column label="cpu核心数" prop="cpu"></el-table-column>
              <el-table-column label="内存" prop="memory"></el-table-column>
              <el-table-column label="操作">
                <template slot-scope="scope">
                  <el-button typ="text" @click="handleDeleteServiceEnvHost(scope.row)" size="mini" type="text">解除关联</el-button>
                  <el-button typ="text" @click="$router.push({path: '/stree/terminal', query: {host_id: scope.row.id}})" size="mini" type="text">登录</el-button>

                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </div>
      </el-tab-pane>
      <el-tab-pane label="打包发布" v-if="$store.state.selectedNode.typ === TreeNodeType.serviceEnv" class="builPub" style="height: 100%; ">
        <el-tabs tab-position="left" style="height: 100%;" @tab-click="clickBuildPubTab">
          <el-tab-pane label="代码打包" >
            <el-button style="float: right" :disabled="buildHistory.length !== 0 && buildHistory[0].status === 'ING'" type="primary" @click="handleBuild">打包</el-button>
            <div style="background-color: #eeffb4; height: calc(100vh - 120px); float: left; width: 280px; padding: 4px; overflow-y: auto;">
              <div :style="{backgroundColor: (selectBuildHistory.id === buildHistory.id? '#fffb1b': '#eeffb4')}" :key="buildHistory.id" v-for="buildHistory in buildHistory" class="buildHistory" @click="getBuildHistoryById(buildHistory)" style="height: 60px;border-top: #484f6c dashed 1px; padding: 5px; ">
                <div style="display: flex; height: 30px; justify-content: space-between;;">
                  <span style="height: 30px;line-height: 30px; display: inline-block" size="mini">版本:{{ buildHistory.version }}</span>
                  <el-tag v-if="buildHistory.status ==='SUCCESS'" type="success" style="height: 30px;line-height: 30px; display: inline-block">成功</el-tag>
                  <el-tag v-if="buildHistory.status ==='ING'" type="info" style="height: 30px;line-height: 30px; display: inline-block"><i class="el-icon-loading"></i>进行中</el-tag>
                  <el-tag v-if="buildHistory.status ==='FAIL'" type="danger" style="height: 30px;line-height: 30px; display: inline-block">失败</el-tag>
                </div>
                操作人: <span style=" display: inline-block">{{ buildHistory.operator }}</span>
              </div>
            </div>
            <i class="el-icon-loading" v-if="selectBuildHistory.status === 'ING'"></i>
            <div style="height: calc(100vh - 120px); padding: 5px; overflow-y: scroll" v-html="selectBuildHistory.build_log.replaceAll('\n', '<br>')">

            </div>

          </el-tab-pane>
          <el-tab-pane label="代码发布">
            <el-button style="float: right" :disabled="pubHistorys.length !== 0 && pubHistorys[0].status === 'ING'" type="primary" @click="handlePub">发布</el-button>
            <div style="background-color: #eeffb4; height: calc(100vh - 120px); float: left; width: 280px; padding: 4px; overflow-y: scroll">
              <div :style="{backgroundColor: (selectPubHistory.id === pubHistory.id? '#fffb1b': '#eeffb4')}" :key="pubHistory.id" v-for="pubHistory in pubHistorys" class="buildHistory" @click="getPubHistoryById(pubHistory)" style="height: 60px;border-top: #484f6c dashed 1px; padding: 5px;">
                <div style="display: flex; height: 30px; justify-content: space-between;;">
                  <span style="height: 30px;line-height: 30px; display: inline-block" size="mini">版本:{{ pubHistory.version }}</span>
                  <el-tag v-if="pubHistory.status ==='SUCCESS'" type="success" style="height: 30px;line-height: 30px; display: inline-block">成功</el-tag>
                  <el-tag v-if="pubHistory.status ==='ING'" type="info" style="height: 30px;line-height: 30px; display: inline-block"><i class="el-icon-loading"></i>进行中</el-tag>
                  <el-tag v-if="pubHistory.status ==='FAIL'" type="danger" style="height: 30px;line-height: 30px; display: inline-block">失败</el-tag>
                </div>
                操作人: <span style=" display: inline-block">{{ pubHistory.operator }}</span>
              </div>
            </div>
            <i class="el-icon-loading" v-if="selectPubHistory.status === 'ING'"></i>
            <div style="height: calc(100vh - 120px);padding-left: 5px; overflow-y: scroll" v-html="selectPubHistory.pub_log.replaceAll('\n', '<br>')">

            </div>

          </el-tab-pane>
        </el-tabs>


      </el-tab-pane>x
    </el-tabs>
    <el-dialog
      :visible.sync="addServiceEnvHostVisible"
      @open="getHostOptions"
      title="关联主机"
    >
      <el-form>
        <el-form-item label="主机">
          <el-select v-model="serviceEnvHostForm.hostIds" multiple style="width: 100%; overflow: hidden">
            <el-option :key="option.id" style="width: 100%"
                       :label="option.hostname + '(' + option.ip + ')'"
                       :value="option.id"
                       v-for="option in hostOptions">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addServiceEnvHostVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleAddServiceEnvHost" >确 定</el-button>
      </span>

    </el-dialog>
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
import {TreeOperation,  TreeNodeType, TreeNodeTypeMap} from "@/const"

export default {
  name: 'StreeDetailCp',
  computed: {
  },

  data(){
    return {
      activeName: "basicInfo",
      permData: [],
      addTURDialogVisible: false,
      addServiceEnvHostVisible: false,
      userOptions: [],
      hostOptions: [],
      serviceEnvHostForm: {
        hostIds: [],
        tree_id: ''
      },
      buildHistory: [],
      serviceConfForm: {
        tree_id: '',
        git: '',
        opadmin: '',
        rdadmin: '',
        domain: '',
        start_command: '',
        build_command: ''
      },
      TreeNodeType,
      serviceEnvHosts: [],
      modifyServiceConf: true,
      treeNodeRuleUserForm: {
        user_ids: [],
        tree_id: '',
        role_id: ''
      },
      selectBuildHistory:{
        build_log:''
      },
      pubHistorys: [],
      selectPubHistory:{
        pub_log:''
      },
      TreeNodeTypeMap: TreeNodeTypeMap,
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
        if (this.$store.state.selectedNode.typ === TreeNodeType.service){
          this.getServiceConf()
        }
        if (this.$store.state.selectedNode.typ === TreeNodeType.serviceEnv){
          this.getServiceEnvHost()
          this.getBuildHistory()
        }
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
    getHostOptions(){
      http.get("/api/v1/hosts/",).then((resp)=>{
        this.hostOptions = resp.data
      })
    },

    getServiceEnvHost(){
      http.get('/api/v1/stree/service/env/host', {params:{tree_id:this.$store.state.selectedNode.id}}).then((resp)=>{
        this.serviceEnvHosts = resp.data
      })
    },
    getServiceConf(){
      http.get('/api/v1/stree/service/conf', {params:{tree_id:this.$store.state.selectedNode.id}}).then((resp)=>{
        this.serviceConfForm = resp.data
      })
    },
    handleAddTURDialogOpen(row){
      this.addTURDialogVisible = true
      this.treeNodeRuleUserForm.role_id = row.id
      this.treeNodeRuleUserForm.tree_id = this.$store.state.selectedNode.id
    },
    handleModifyServiceConf(){
      this.serviceConfForm.tree_id = this.$store.state.selectedNode.id
      http.post('/api/v1/stree/service/conf', this.serviceConfForm).then(()=>{
        this.getServiceConf()
        this.modifyServiceConf = true
      })
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
    handleAddServiceEnvHost(){
      this.serviceEnvHostForm.tree_id = this.$store.state.selectedNode.id
      http.post('/api/v1/stree/service/env/host', this.serviceEnvHostForm ).then(()=>{
        this.getServiceEnvHost()
        this.addServiceEnvHostVisible = false

      })
    },
    handleDeleteServiceEnvHost(host){
     this.$confirm('是否解除'+ host.hostname + '与'+ this.$store.state.selectedNode.path
     + '的关联?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
     }).then(() => {
        http.delete('/api/v1/stree/service/env/host', {data:{
          host_id: host.id,tree_id: this.$store.state.selectedNode.id}
        }).then(()=>{
          this.getServiceEnvHost()
          this.$message({
            type: 'success',
            message: '接触关联成功!'
          });
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消'
        });
      });
    },
    handleBuild(){
      http.post("/api/v1/stree/service/build",{tree_id: this.$store.state.selectedNode.id}).then(()=>{
        this.getBuildHistory()
      })
    },
    handlePub(){
      http.post("/api/v1/stree/service/pub",{tree_id: this.$store.state.selectedNode.id}).then(()=>{
        this.getPubHistory()
      })
    },
    getBuildingLog(){
      if (this.selectBuildHistory.status === 'ING'){
        setTimeout(()=>{
          this.getBuildHistoryById(this.selectBuildHistory)
          this.getBuildingLog()
        },1000)
      }else{
        this.getBuildHistory()
      }
    },
    getPubingLog(){
      if (this.selectPubHistory.status === 'ING'){
        setTimeout(()=>{
          this.getPubHistoryById(this.selectPubHistory)
          this.getPubingLog()
        },1000)
      }else{
        this.getPubHistory()
      }
    },
    getBuildHistory(){
      http.get("/api/v1/stree/service/build",{params:{tree_id: this.$store.state.selectedNode.id}}).then((resp)=>{
        this.buildHistory = resp.data
        if (this.buildHistory.length !== 0){
          if (this.buildHistory[0].status === 'ING') {
            this.selectBuildHistory = this.buildHistory[0]
            this.getBuildingLog()
          }
        }
      })
    },
    getBuildHistoryById(buildHistory){
      http.get("/api/v1/stree/service/build",{params:{id:buildHistory.id}}).then((resp)=>{
        let build_log = resp.data.build_log
        if (build_log === null){
          build_log = ''
        }
        build_log =  "打包开始时间：" + resp.data.start_time + "\n\n" +  buildHistory.status + '\n' + build_log + '\n\n'

        resp.data.build_log = build_log
        this.selectBuildHistory = resp.data
      })
    },
    getPubHistory(){
      http.get("/api/v1/stree/service/pub",{params:{tree_id: this.$store.state.selectedNode.id}}).then((resp)=>{
        this.pubHistorys = resp.data
        if (this.pubHistorys.length !== 0){
          if (this.pubHistorys[0].status === 'ING') {
            this.selectPubHistory = this.pubHistorys[0]
            this.getPubingLog()
          }
        }
      })
    },
    getPubHistoryById(pubHistory){
      http.get("/api/v1/stree/service/pub",{params:{id:pubHistory.id}}).then((resp)=>{
        let pub_log = resp.data.pub_log
        if (pub_log === null){
          pub_log = ''
        }
        pub_log =  "打包开始时间：" + resp.data.start_time + "\n\n" +  pubHistory.status + '\n' + pub_log + '\n\n'

        resp.data.pub_log = pub_log
        this.selectPubHistory = resp.data
      })
    },
    clickBuildPubTab(tab){
      if (tab.label === '代码打包'){
        this.getBuildHistory()
      }
      if (tab.label === '代码发布'){
        this.getPubHistory()
      }
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
<style  lang="scss">
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
.buildHistory{
  overflow-y: scroll !important;
  &:hover{
    background-color: #f9ff6e;
  }
}
.streeDetail{
  .el-tabs {
    .el-tabs__content {
        height: calc(100vh - 130px)!important;
        overflow-y: scroll;

    }
  }
}
.builPub{
  .el-tabs {
    .el-tabs__content {
        height: calc(100vh)!important;
        //overflow-y: hidden;

    }
  }
}

a {
  color: #42b983;
}

.custom-tree-node{
  width: 100%;
}


</style>
