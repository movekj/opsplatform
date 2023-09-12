let utils = {
  SetToken2LocalStorage(token) {
    localStorage.setItem("token", token)
  },
  GetToken2LocalStorage() {
    return localStorage.getItem("token") || ""
  }
}

export default utils

