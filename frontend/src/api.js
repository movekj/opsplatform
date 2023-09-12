import axios from "axios";
import utils from "@/utils.js";

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
    return Promise.reject(err);
  }
);

export default http;