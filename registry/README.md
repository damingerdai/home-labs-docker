# registry

启动一个一次性容器用于创建账号密码.密码文件路径以/root/registry/htpasswd为例,账号密码以admin和12345678为例.

```bash
docker run --rm --entrypoint \
    htpasswd httpd:2 -Bbn \
    admin 12345678 > ./registry/htpasswd
```

启动

```bash

docker-compose up -d
```
