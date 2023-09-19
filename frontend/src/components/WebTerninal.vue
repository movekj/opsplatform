<script>

import 'xterm/css/xterm.css'
import { Terminal } from 'xterm'
import { FitAddon } from 'xterm-addon-fit'
import { AttachAddon } from 'xterm-addon-attach'

export default {
  name: 'WebTerminalCp',
  props: {
    socketURI: {
      type: String,
      default: ''
    },
  },
  mounted() {
    this.initSocket()
  },
  beforeDestroy() {
    this.socket.close()
    this.term.dispose()
  },
  methods: {
    initTerm() {
      const term = new Terminal({
        fontSize: 14,
        cursorBlink: true,

      });
      const attachAddon = new AttachAddon(this.socket);
      const fitAddon = new FitAddon();
      term.loadAddon(attachAddon);
      term.loadAddon(fitAddon);
      term.open(document.getElementById('xterm'));
      fitAddon.fit();
      term.focus();
      let cmd = ''
      term.onKey(
        (key, )=> {
          if (key.length > 0) {
            this.term.write(key);
            this.term.write("\r\n");
          }
          if (key === 13) {
            term.write(key + '\n')
            cmd = ''
          } else if (key === 8) {
            term.write('\b \b')
            cmd = cmd.substring(0, cmd.length - 1)
          } else {
            cmd = cmd + key
            term.write(key)
          }
        }
      )
      this.term = term
    },
    initSocket() {
      this.socket = new WebSocket('ws://10.112.0.9:8889/terminal/');
      this.socketOnClose();
      this.socketOnOpen();
      this.socketOnError();
    },
    socketOnOpen() {
      this.socket.onopen = () => {
        // 链接成功后
        this.initTerm()
      }
    },
    socketOnClose() {
      this.socket.onclose = () => {
        // console.log('close socket')
      }
    },
    socketOnError() {
      this.socket.onerror = () => {
        // console.log('socket 链接失败')
      }
    }
  }
}

</script>

<template>
  <div id="xterm" class="xterm" style="width: 100%" />

</template>

<style scoped>
.xterm{
  height: 100%;
}

</style>