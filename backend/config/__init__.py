class Config(object):
    MYSQL_HOST = "10.112.0.9"
    MYSQL_USER = "opsplatform"
    MYSQL_PORT = 3308
    MYSQL_PASSWORD = "dfsfse2344as"
    MYSQL_DB = "opsplatform"
    MYSQL_CHARSET = "utf8"
    MYSQL_COLLATION = "utf8_general_ci"
    MYSQL_UNIX_SOCKET = ""
    TOKEN_EXPIRE_DAYS = 7
    AUTH_WHITE_LIST = ['/api/v1/users/login/']

