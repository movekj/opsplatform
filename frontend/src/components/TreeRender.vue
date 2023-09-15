<template>
  <div class="node"
    style="width: 100%"
    :class="{selected: currentCutNode.data.id === DATA.id}" tabindex="0"
    @keydown.ctrl.88="handleCutNode"
    @keydown.meta.88="handleCutNode"
    @keydown.ctrl.86="handlePasteNode"
    @keydown.meta.86="handlePasteNode"
  >
      <i v-if="DATA.type === 'dir' && NODE.expanded"  class="el-icon-folder-opened"></i>
      <i v-else-if="DATA.type === 'dir'"  class="el-icon-folder"></i>
      <i v-if="DATA.type === 'file'"  class="el-icon-document"></i>
      <span
        v-show="NODE.data.id !== operation.newNodeId"
        style="width: 100%;"
      >
        <span>{{ NODE.label }}</span>
        <span @click.stop style="margin-left: 5px; display: inline-block">
          <el-dropdown @command="handleDropDownMenu">
            <span class="el-dropdown-link">
              <i class="el-icon-circle-plus"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item v-if="DATA.typ === nodeType.group" :command="operation.createCompany">新建公司</el-dropdown-item>
              <el-dropdown-item v-if="DATA.typ === nodeType.company" :command="operation.createBu">新建业务线</el-dropdown-item>
              <el-dropdown-item v-if="DATA.typ === nodeType.bu" :command="operation.createAppGroup">新建组项目</el-dropdown-item>
              <el-dropdown-item v-if="DATA.typ === nodeType.appGroup" :command="operation.createAppDir">新建目录</el-dropdown-item>
              <el-dropdown-item v-if="DATA.typ === nodeType.appDir" :command="operation.createService">新建服务</el-dropdown-item>
              <el-dropdown-item v-if="DATA.typ === nodeType.service" :command="operation.createServiceEnv">新建环境</el-dropdown-item>
              <el-dropdown-item :command="operation.renameCommand">重命名</el-dropdown-item>
              <el-dropdown-item :command="operation.deleteCommand">删除</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </span>
      </span>
      <span v-show="NODE.data.id === operation.newNodeId">
        <el-input
          ref="newNodeInput"
          v-model="newNodeName"
          @blur="handleCreateNode"
          @keyup.enter.native="handleCreateNode"
          v-focus
          placeholder="请输入名称"
        ></el-input>
      </span>
  </div>
</template>

<script>
import utils from '@/utils'
import {TreeOperation} from "@/const";
import {TreeNodeType} from "@/const";

export default {
  name: "TreeRender",
  data () {
    return {
      operation: TreeOperation,
      nodeType: TreeNodeType,
      newNodeName: "",
      defaultExpandedKeys: [],
    };
  },
  props: {
    NODE: {
      type: Object,
      default(){
        return {}
      }
    },
    DATA: {
      type: Object,
      default(){
        return {}
      }
    },

  },
  components: {
  },

  computed: {
    currentCutNode(){
      return this.$store.state.currentCutNode
    }

  },

  mounted() {
    if (this.NODE.data.id === this.operation.newNodeId){
      let mounted = utils.Debounce(()=>{
        this.$nextTick(()=>{
          if ("newNodeInput" in this.$refs){
            this.$refs.newNodeInput.focus()
          }
        })
      }, 100)
      mounted()
    }
    this.newNodeName = this.DATA.name
  },
  methods: {
    handleCreateNode(){
      let nodeCreate = utils.Debounce(()=>{
        this.$emit("nodeCreate", this.NODE, this.newNodeName)
      }, 100)
      nodeCreate()
    },
    handleDropDownMenu(command){
      this.$emit("nodeOperation", command, this.NODE)
    },

    addNodeIdToDefaultExpandedKeys(id){
      if (this.defaultExpandedKeys.indexOf(id) === -1){
        this.defaultExpandedKeys.push(id)
      }
    },
    handleCutNode(){
      this.$message.success("剪切成功")
      this.$store.dispatch("updateCurrentCutNode", this.NODE)
    },
    handlePasteNode(){
      if (this.DATA.id === this.currentCutNode.id || this.DATA.type === this.nodeType.serviceEnv){
        return
      }
      this.$emit("nodePaste", this.DATA.id, this.currentCutNode.data.id, this.NODE, this.currentCutNode.parent)
    }
  }
}

</script>
<style lang='scss' scoped>

  .el-input--mini {
     /deep/ .el-input__inner{
      height: 24px;
      line-height: 24px;
      padding-left: 4px;
      padding-right: 4px;
    }
  }
  .el-dropdown-link {
    display: none;
  }
  .selected{
    color: red;
  }
  .node {
    &:hover .el-dropdown-link{
      display:block;
    }
  }
</style>
