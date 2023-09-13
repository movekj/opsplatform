import utils from "@/utils";
import VueRouter from 'vue-router'
import Host from './components/Host.vue'
import User from './components/User.vue'
import Verb from './components/Verb.vue'
import Role from "@/components/Role.vue";
import Stree from './components/Stree.vue'
import Login from './components/Login.vue'
import RoleRule from "@/components/RoleRule.vue";

import Resource from "@/components/Resource.vue";
import Dashboard from './components/Dashboard.vue'
import Permission from './components/Permission.vue'



const routes = [
  { path: '/', component: Dashboard,
    children: [
      { path: '/stree', component: Stree },
      { path: '/permissionManage', component: Permission,
        children:[
          { path: '/permissionManage/role', component: Role,
            children: [
              { path: '/permissionManage/role/rule', component: RoleRule },
            ]
          },
          { path: '/permissionManage/verb', component: Verb},
          { path: '/permissionManage/resource', component: Resource },
        ]
      },
      { path: '/hostManage', component: Host },
      { path: '/userManage', component: User },
    ]
  },
  {
    path: '/login', component: Login, meta: { requireLogin: false }, name: 'login'
  }
]

const router = new VueRouter({
  routes
})
router.beforeEach((to, from, next) =>{
    let token = utils.GetToken2LocalStorage()
    if (to.meta.requireLogin === undefined && !to.meta.requireLogin){
      if (token.length < 10){
        router.push('/login')
        return
      }
    }

    next()
  }
)
export default router