import Vue from 'vue'
import axios from 'axios'
import store from '@/store'
import App from './App.vue'
import router from "@/router";
import VueAxios from 'vue-axios'
import VueRouter from 'vue-router'
import ElementUI from 'element-ui';

import 'element-ui/lib/theme-chalk/index.css';

const originalPush = VueRouter.prototype.push

VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.config.productionTip = false

Vue.use(VueAxios, axios)
Vue.use(ElementUI);
Vue.use(VueRouter);

Vue.directive('focus', {
  // 当被绑定的元素插入到 DOM 中时……
  inserted: function (el) {
    // 聚焦元素
    // el.focus()
    el.querySelector('input').focus()
  }
})


new Vue({
  render: h => h(App),
  router,
  store
}).$mount('#app')
