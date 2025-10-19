# MySQL 数据库的备份和恢复命令

## 🚨 风险提示

在命令行中使用纯文本密码（如 -p"123456"）存在安全风险，因为它会被记录在主机的历史命令（如 .bash_history）中。在生产环境中，强烈建议使用环境变量或配置文件的形式来传递密码。

## 步骤一：数据库备份（从旧版本容器）

假设您的旧容器名称是 `mysql-8.3` 并且正在运行。

1. 创建备份目录

```bash
mkdir -p backup
```

2. 执行备份命令

此命令会在运行中的 mysql-8.3 容器内执行 mysqldump，将所有数据库内容导出，并通过管道重定向到主机上的 SQL 文件。

```bash
docker exec mysql-8.3 sh -c 'exec mysqldump --all-databases --no-tablespaces -uroot -p"123456"' > ./backup/mysql_upgrade_backup.sql
```

3. 停止并移除旧容器

```bash
docker compose stop mysql-8.3
```

4. 创建新的mysql数据目录

```bash
mkdir -p mysql9-data
```

## 步骤二：数据恢复（到新版本容器）

假设您已更新 docker-compose.yml 到新版本（例如 mysql:9.4.0）并使用新容器名 mysql-9.4，且已通过 docker compose up -d 启动了新的空容器。

1. 执行导入命令：

此命令会读取主机上备份的 SQL 文件，并通过管道将其内容传输给运行中的 mysql-9.4 容器内的 mysql 客户端，进行数据导入。

```bash
cat ./backup/mysql_upgrade_backup.sql | docker exec -i mysql-9.4 sh -c 'exec mysql -uroot -p"123456"'
```

2. 验证数据:

您可以连接到新容器，检查数据是否成功迁移。

``bash
docker exec -it mysql-9.4 mysql -uroot -p"123456"

SHOW DATABASES;

```

```
