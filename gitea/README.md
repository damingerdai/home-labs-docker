# gitea

## 创建数据库

```sql
CREATE DATABASE gitea;
CREATE USER gitea WITH PASSWORD '123456';
GRANT ALL PRIVILEGES ON DATABASE gitea TO gitea;
GRANT ALL PRIVILEGES ON DATABASE gitea TO gitea;
GRANT USAGE ON SCHEMA public TO gitea;
GRANT CREATE ON SCHEMA public TO gitea;
```

## gitea action runner

gitea action需要nodejs的支持

```bash
docker exec gitea_runner apk add --no-cache nodejs
```

## runner labels

```
    - "ubuntu-latest:docker://gitea/runner-images:ubuntu-latest"
    - "ubuntu-22.04:docker://gitea/runner-images:ubuntu-22.04"
    - "ubuntu-20.04:docker://gitea/runner-images:ubuntu-20.04"

```
