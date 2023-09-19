<template>
  <div style="height: calc(100vh - 70px); display: flex">
    <div style="width: 260px;">
      <el-tree
        :load="loadNode"
        node-key="id"
        :lazy="lazy"
        style="height: 100%;background-color: #e4e4e4"
        :highlight-current="true"
        :props="defaultProps"
        :default-expanded-keys="defaultExpandedKeys"
        ref="tree"
        @node-click="handleNodeClick"
      >
        <span class="custom-tree-node" slot-scope="{ node, data }">
          <TreeRender
            :NODE="node"
            :DATA="data"
            @nodeCreate="doNodeCreate"
            @nodeOperation="nodeOperation"
            @nodePaste="nodePaste"
          ></TreeRender>
        </span>
      </el-tree>
    </div>
    <router-view></router-view>
  </div>
</template>
<script>
import http from '@/api'
import TreeRender from "@/components/TreeRender.vue";
import {TreeOperation} from "@/const";
import {TreeNodeType} from "@/const";

export default {
  name: 'StreeCp',
  components: {TreeRender},
  data(){
    return {
      lazy: true,
      defaultProps: {
        children: "children",
        label: "name",
        isLeaf: "leaf",
      },
      defaultExpandedKeys: [1],

    }
  },
  methods:{
    addLeafProp(nodes) {
      nodes.forEach((node) => {
        if (node.typ === TreeNodeType.serviceEnv) {
          node.leaf = true;
        }
      });
      return nodes;
    },
    nodeOperation(command, node){

      switch (command) {

        case TreeOperation.createCompany:
          this.handleCreateCompany(node)
          this.addNodeIdToDefaultExpandedKeys(node.data.id)
          break

        case TreeOperation.createBu:
          this.handleCreateBu(node)
          this.addNodeIdToDefaultExpandedKeys(node.data.id)
          break
        case TreeOperation.createAppGroup:
          this.handleCreateAppGroup(node)
          this.addNodeIdToDefaultExpandedKeys(node.data.id)
          break
        case TreeOperation.createAppDir:
          this.handleCreateAppDir(node)
          this.addNodeIdToDefaultExpandedKeys(node.data.id)
          break
        case TreeOperation.createService:
          this.handleCreateService(node)
          this.addNodeIdToDefaultExpandedKeys(node.data.id)
          break
        case TreeOperation.createServiceEnv:
          this.handleCreateServiceEnv(node)
          this.addNodeIdToDefaultExpandedKeys(node.data.id)
          break
        case TreeOperation.deleteCommand:
          this.handleDelete(node)
          break

        case TreeOperation.renameCommand:
          this.handleRename(node)
          break

        default:
      }
    },
    handleNodeClick(data, node){
      this.$store.dispatch("updateSelectedNodeData", node.data)
      this.$router.push("/stree/detail")
    },
    handleCreateCompany(node){

      let newNodeData = {
        id: TreeOperation.newNodeId,
        name: "",
        type: TreeNodeType.company,
        path: "",
      }
      this.create(node, newNodeData)
    },
    addNodeIdToDefaultExpandedKeys(id){
      if (this.defaultExpandedKeys.indexOf(id) === -1){
        this.defaultExpandedKeys.push(id)
      }
    },
    handleCreateAppGroup(node){
      let newNodeData = {
        id: TreeOperation.newNodeId,
        name: "",
        type: TreeNodeType.appGroup,
        path: "",
      }
      this.create(node, newNodeData)
    },
    handleCreateAppDir(node){
      let newNodeData = {
        id: TreeOperation.newNodeId,
        name: "",
        type: TreeNodeType.appDir,
        path: "",
      }
      this.create(node, newNodeData)
    },
    handleCreateService(node){
      let newNodeData = {
        id: TreeOperation.newNodeId,
        name: "",
        type: TreeNodeType.service,
        path: "",
      }
      this.create(node, newNodeData)
    },
    handleCreateBu(node){
      let newNodeData = {
        id: TreeOperation.newNodeId,
        name: "",
        type: TreeNodeType.bu,
        path: "",
      }
      this.create(node, newNodeData)
    },
    handleCreateServiceEnv(node){
      let newNodeData = {
        id: TreeOperation.newNodeId,
        name: "",
        type: TreeNodeType.serviceEnv,
        path: "",
      }
      this.create(node, newNodeData)
    },
    create(node, newNodeData){
      let parentNode = this.$refs.tree.getNode(node.data.id)
      parentNode.expanded = true
      let childNodes = parentNode.childNodes
      if (childNodes.length > 0){
        let firstChild =  childNodes[0]
        this.$refs.tree.insertBefore(newNodeData,firstChild)
      } else {
        this.$refs.tree.append(newNodeData,parentNode)
      }
    },

    nodePaste(dest_id, src_id, dest_parent, src_parent){
      http.post("/api/v1/stree/children/move", {dest_id:dest_id, src_id:src_id }).then(()=>{
        this.addNodeIdToDefaultExpandedKeys(dest_id)
        this.$message.success("粘贴成功")
          this.getChildren(dest_parent.data.id)
          this.getChildren(src_parent.data.id)
        // }
        this.$store.dispatch("emptyCurrentCutNode")
      })
    },
    doNodeCreate(node, newNodeName){
      let parent_id = node.parent.data.id
      if (node.data.originId === undefined){
        if (newNodeName.length > 0 ){
          let data = node.data
          data.name = newNodeName
          data.parent_id = parent_id
          http.post("/api/v1/stree/children", data).then(()=>{
            this.getChildren(parent_id)
          })
          return
        }
        this.getChildren(parent_id)

        return
      }
      http.put("/api/v1/stree/children", {id: node.data.originId, name: newNodeName}).then(()=>{
        this.getChildren(parent_id)
      })

    },

    handleDelete(node){
      if (node.childNodes.length > 0){
        this.$message.warning("该目录下含有其他子节点，无法删除！")
        return
      }
      this.$confirm('此操作将删除'+ node.data.name +', 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {

        http.delete("/api/v1/stree/children", {data:{id: node.data.id}}).then(()=>{
          this.getChildren(node.parent.data.id)
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      })
    },
    removeChildNodes(node){
      if (node !== null){
        const childNodes = node.childNodes
        for (let i = childNodes.length - 1; i >= 0; i--) {
          const child = childNodes[i]
          console.log(child)
          this.$refs.tree.remove(child.data)
        }
      }
    },
    getChildren(tree_id){

      let node = this.$refs.tree.getNode(tree_id)
      this.removeChildNodes(node)
      http.get('/api/v1/stree/children/',{params:{tree_id: tree_id}}).then((resp)=>{
        this.$refs.tree.updateKeyChildren(tree_id, resp.data);
      })
    },
    handleRename(node){
      let data = {...node.data}
      data.originId = data.id
      data.id = TreeOperation.newNodeId
      data.type = data.typ
      this.$refs.tree.insertAfter(data, node)
      this.$refs.tree.remove(node.data)
      this.addNodeIdToDefaultExpandedKeys(data.id)
    },
    getDetail(tree_id){
      return http.get('/api/v1/stree/node/detail',{params:{id:tree_id}}).then((resp)=>{
        return resp
      })
    },
    loadNode(node, resolve) {
      if (node.level === 1) {
        this.getDetail(node.data.id).then((resp)=>{
          this.$store.dispatch("updateSelectedNodeData", resp.data)
        });
      }
      if (node.level === 0) {
        http.get('/api/v1/stree/init/').then((response)=>{
          this.loading = false;
          resolve([response.data]);
        })
      } else {
        if (node.data.id === TreeOperation.newNodeId) {
            resolve([node]);
        } else {
          http.get('/api/v1/stree/children/',{params:{tree_id: node.data.id}}).then((response)=>{
            this.loading = false;
            let nodes = this.addLeafProp(response.data);
            resolve(nodes);
          })
        }
      }
    },

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
.custom-tree-node{
  width: 100%;
}
</style>
