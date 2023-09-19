import asyncio
import json
from channels.consumer import AsyncConsumer, SyncConsumer
from random import randint
from time import sleep
import threading
import pty
import os
import select
import sys
import paramiko

from hosts import models as host_models


class WebTerminal(SyncConsumer):
    def __init__(self):
        self.threading = None
        self._master_fd = None
        self.channel = None
        self.stdin = None
        self.command = ""

    def run(self):
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        query_string = self.scope.get('query_string')
        query_dict = dict(pair.split('=') for pair in query_string.decode().split('&'))
        host_id = query_dict.get('host_id')

        host = host_models.Host.objects.filter(id=host_id).first()
        if not host:
            self.send({"type": "websocket.send",
                       "text": "主机不存在"})
            return

        client.connect(hostname=host.ip, username=host.username, password=host.password)
        self.channel = client.invoke_shell()
        self.stdin = self.channel.makefile_stdin("wb", 1024)
        while True:

            if self.channel.exit_status_ready():
                break

            # 检查通道是否有数据可读
            if self.channel.recv_ready():
                line = self.channel.recv(1024).decode('utf-8')

                if line:
                    self.send({"type": "websocket.send",
                               "text": str(line)})
            # 检查通道是否有错误输出可读
            if self.channel.recv_stderr_ready():
                line = self.channel.recv(1024).decode('utf-8')

                if line:
                    self.send({"type": "websocket.send",
                            "text": line})


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

        self.stdin.channel.send(event["text"].rstrip("\n"))

    def websocket_disconnect(self, event):
        # when websocket disconnects
        print("disconnected", event)