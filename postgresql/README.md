# postgresql

## 备份

```bash
docker exec -it postgres pg_dumpall -U postgres > upgrade_backup.sql
```

## 导入

```bash
cat upgrade_backup.sql | docker exec -i postgres psql -U postgres
```
