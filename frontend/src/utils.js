let utils = {
  SetToken2LocalStorage(token) {
    localStorage.setItem("token", token)
  },
  GetToken2LocalStorage() {
    return localStorage.getItem("token") || ""
  },
  DeleteToken2LocalStorage() {
    return localStorage.removeItem("token")
  }
}

export default utils

