## 环境要求

* python 3.10.10
* nodejs v14.17.6


## 导入系统初始数据
```bash 
mysql -uroot -p < init.sql
```

## 编译前代码端

```bash
$ cd frontend
$ npm install 
$ npm run build
$ mkdir /opt
$ cp -a dist /opt/opsplatform
```

## 编译后端代码
```bash 
$ cd backend 
$ pip install -r requirements.txt
```

## 启动后端服务
```bash
 gunicorn -w 16 -b 0.0.0.0:8889 opsplatform.wsgi 
```

## 配置nginx
```bash
server {
    listen       8777;
    server_name  localhost;


    location / {
        root   /opt/opsplatform;
        index  index.html index.htm;
    }
    location /api/v1 {
        proxy_pass http://127.0.0.1:8889;
    }
}

```

## 访问
* 使用浏览器打开http://127.0.0.1:8777

## 账号信息
* 系统管理员：账号：admin，密码: .......1
* 测试普通账号：账号：test，密码: 123456