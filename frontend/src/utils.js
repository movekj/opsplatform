let utils = {
  SetToken2LocalStorage(token) {
    localStorage.setItem("token", token)
  },
  GetToken2LocalStorage() {
    return localStorage.getItem("token") || ""
  },
  DeleteToken2LocalStorage() {
    return localStorage.removeItem("token")
  },
  HasPerm(rbac, requirePerms){
    for (let i=0 ;i<rbac.length;i++){
      for (let j=0; j<requirePerms.length; j++){
        console.log(rbac[i], requirePerms[j])
        if (rbac[i].resource_ref === requirePerms[j].ref &&  rbac[i].verb === requirePerms[j].verb)
          return true
      }
    }
  },
}

export default utils

