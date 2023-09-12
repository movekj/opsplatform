<template>
  <div id="app" style="height: 100vh">

    <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
  },
  methods:{
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
*{
    margin:0;
    padding:0
}
li{
    list-style:none
}
img{
    vertical-align:top;
    border:none
}

</style>
