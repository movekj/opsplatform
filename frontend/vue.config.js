const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  devServer:{
    host: "10.112.0.9",
    port: 8080,
    proxy: {
      '^/api': {
        target: 'http://10.112.0.9:8889',
        changeOrigin: true,
      }
    }
  }
})
