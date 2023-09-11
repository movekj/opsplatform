import VueRouter from 'vue-router'
import Stree from './components/Stree.vue'
import Host from './components/Host.vue'
import User from './components/User.vue'
import Permission from './components/Permission.vue'

const routes = [
  { path: '/stree', component: Stree },
  { path: '/permissionManage', component: Permission },
  { path: '/hostManage', component: Host },
  { path: '/userManage', component: User },
]

const router = new VueRouter({
  routes
})
export default router