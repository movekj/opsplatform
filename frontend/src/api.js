import axios from "axios";
import router from "@/router";
import utils from "@/utils.js";
import { Message } from 'element-ui'

const http = axios.create({
  headers: {
    Accept: "application/json",
  },
});

http.interceptors.request.use((config) => {
  let token = utils.GetToken2LocalStorage()
  if (token.length > 10){
    config.headers['authorization'] = 'JWT ' + token
  }
  return config;
});

http.interceptors.response.use(
  (res) => {

    return Promise.resolve(res.data);
  },
  (err) => {
    let errMsg = undefined
    // eslint-disable-next-line no-prototype-builtins
    let error = err.response.data.error
    if (errMsg === undefined && error !== undefined){
      errMsg = err.response.data.error
    }

    let errors = err.response.data.errors
    if (errMsg === undefined && errors !== undefined && errors.length > 0){
      error = errors[0]
      errMsg = Object.values(error)[0]
    }
    let message = err.response.data.message
    if (errMsg === undefined && message !== undefined){
      errMsg = message
    }

    if (errMsg !== undefined){
      Message({
        message: errMsg,
        dangerouslyUseHTMLString: true,
        type: 'error',
        duration: 5 * 1000
      })
    }
    if (err.response.status === 401){
      router.push({name: 'login'})
    } else {
      Message({
        message: "未知错误，请联系系统管理员",
        dangerouslyUseHTMLString: true,
        type: 'error',
        duration: 5 * 1000
      })
    }
    return Promise.resolve(err);
  }
);

export default http;