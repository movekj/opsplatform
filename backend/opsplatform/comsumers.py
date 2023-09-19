import asyncio
import json
from channels.consumer import AsyncConsumer, SyncConsumer
from random import randint
from time import sleep

import asyncio
import json
from channels.consumer import AsyncConsumer
from random import randint
from time import sleep
import threading
import subprocess
import pty
import os
import select
import sys


class WebTerminal(SyncConsumer):
    def __init__(self):
        self.threading = None
        self._master_fd = None

    def run(self):
        master_fd, slave_fd = pty.openpty()
        self._master_fd = master_fd

        p = subprocess.Popen('sh',
                             shell=True,
                             stdin=slave_fd,
                             stdout=slave_fd,
                             stderr=slave_fd,
                             preexec_fn=os.setsid,
                             env=dict(os.environ, TERM='xterm-256color'))
        os.write(master_fd, 'stty rows 45 columns 160\n'.encode())

        while p.poll() is None:
            r, w, e = select.select([sys.stdin, master_fd], [], [])
            if sys.stdin in r:
                user_input = os.read(sys.stdin.fileno(), 10240)
                os.write(master_fd, user_input)
            elif master_fd in r:
                output = os.read(master_fd, 10240).decode()
                # os.write(sys.stdout.fileno(), output)
                self.send({"type": "websocket.send",
                           "text": output})

    def send_msg(self, msg):
        self.send({"type": "websocket.send",
                   "text": msg})

    def websocket_connect(self, event):
        # when websocket connects
        self.send({"type": "websocket.accept"})

        thread = threading.Thread(target=self.run)
        thread.start()
        # print(self.proc)

    def websocket_receive(self, event):
        # when messages is received from websocket
        os.write(self._master_fd, event.get('text').encode())

    def websocket_disconnect(self, event):
        # when websocket disconnects
        print("disconnected", event)