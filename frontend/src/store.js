import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
  state:{
    userinfo: {

    },
    rbac: []
  },
  mutations: {
    commitUserinfo(state, userinfo) {
      state.userinfo =userinfo
      state.rbac = userinfo.rbac
    }
  }
})

export default store
