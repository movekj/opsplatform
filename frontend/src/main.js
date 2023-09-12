import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'
import router from "@/router";
import ElementUI from 'element-ui';
import VueRouter from 'vue-router'
import VueAxios from 'vue-axios'

import 'element-ui/lib/theme-chalk/index.css';

const originalPush = VueRouter.prototype.push

VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.config.productionTip = false

Vue.use(VueAxios, axios)
Vue.use(ElementUI);
Vue.use(VueRouter);

new Vue({
  render: h => h(App),
  router
}).$mount('#app')
