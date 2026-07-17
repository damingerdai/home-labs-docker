# Zot Registry

必须使用 Bcrypt 算法生成加密文件，以确保 v2.1.14 能够正确解析。

```bash
# 安装工具链
sudo apt-get install apache2-utils -y

# 生成 Bcrypt 加密文件 (-B 是核心参数)
# 账号：admin，密码：123456
htpasswd -bc -B .htpasswd admin 123456
```

需开启 UI 扩展并正确指向权限文件路径。

```json
{
  "distSpecVersion": "1.1.0",
  "storage": {
    "rootDirectory": "/var/lib/zot"
  },
  "http": {
    "address": "0.0.0.0",
    "port": "5000",
    "realm": "zot",
    "auth": {
      "htpasswd": { "path": "/etc/zot/htpasswd" }
    }
  },
  "extensions": {
    "ui": { "enable": true },
    "search": { "enable": true }
  }
}
```