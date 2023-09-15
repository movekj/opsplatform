import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
  state:{
    userinfo: {

    },
    selectedNode: {
      id: 0,
      name: "",
      path: "",
      type: "",
    },
    currentCutNode: {
      data:{
        id: 0,
        name: "",
        path: "",
        type: "",
      }
    },
    rbac: [],
  },
  mutations: {
    commitUserinfo(state, userinfo) {
      state.userinfo = userinfo
      state.rbac = userinfo.rbac
    },
    updateSelectedNode({commit}, node) {
      return new Promise(resolve => {
        commit('UPDATE_SELECTED_NODE', node)
        resolve()
      })
    },
    updateCurrentCutNode({commit}, node) {
      return new Promise(resolve => {
        commit('UPDATE_CURRENT_CUT_NODE', node)
        resolve()
      })
    },
    UPDATE_SELECTED_NODE: (state, node) => {
      state.selectedNode = {...node}
    },
    UPDATE_CURRENT_CUT_NODE: (state, node) => {
      state.currentCutNode = {...node}
    },
    EMPTY_CURRENT_CUT_NODE: (state) => {
      state.currentCutNode.id = 0
      state.currentCutNode.name = ""
      state.currentCutNode.path = ""
      state.currentCutNode.type = ""
    },
    EMPTY_SELECTED_NODE: (state) => {
      state.selectedNode.id = 0
      state.selectedNode.name = ""
      state.selectedNode.path = ""
      state.selectedNode.type = ""
    },
  },
  actions: {
    updateSelectedNodeData({commit}, node) {
      return new Promise(resolve => {
        commit('UPDATE_SELECTED_NODE', node)
        resolve()
      })
    },
    updateCurrentCutNode({commit}, node) {
      return new Promise(resolve => {
        commit('UPDATE_CURRENT_CUT_NODE', node)
        resolve()
      })
    },
    emptyCurrentCutNode({commit}) {
      return new Promise(resolve => {
        commit('EMPTY_CURRENT_CUT_NODE')
        resolve()
      })
    },
    emptySelectedNode({commit}){
      return new Promise(resolve => {
        commit('EMPTY_SELECTED_NODE')
        resolve()
      })
    }
  }
})

export default store
