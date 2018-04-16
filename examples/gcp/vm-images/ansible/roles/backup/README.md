# PG-WAL-E

Configures the [WAL-E backup tool](https://github.com/wal-e/wal-e) for Postgres.

## Useful Commands

### I want to test my archive command

Force the WAL archives to swap, so that you can ensure that your backup works.

```sql
SELECT pg_switch_xlog();
```

### database recovery

Suppose you've corrupted or deleted your postgres data directory:

1. stop the database: `sudo service postgresql stop`.
2. delete everything from the postgres data directory: `sudo rm -rf /mnt/postgresql/*`
3. look in `recovery.example`, there's a command here for downloading a base
  backup of the database.
4. copy `recovery.example` to `recovery.conf`. this file directs postgres to perform recovery.
5. start the database server: `sudo service postgresql start`

