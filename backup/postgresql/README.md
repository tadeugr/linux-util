# Simple PostgreSQL backup script

Backup all databases

Requirements
-----------

pg_hba.conf must allow localhost connections without password. Sample:

```
# Database administrative login by Unix domain socket
local   all             postgres                                peer
```
Installation
-----------

Create log directory:

```
# mkdir /var/log/backup-postgre
# chown postgres:postgres /var/log/backup-postgre
```

Copy script:

```
# cp linux-postgresql-backup/backup-postgre.sh YOUR_CRON_PATH/backup-postgre.sh
# chown postgres:postgres YOUR_CRON_PATH/backup-postgre.sh
# chmod +rx YOUR_CRON_PATH/backup-postgre.sh
```

Edit /etc/crontab file and put the following configuration:

```
# Backup - PostgreSQL
01 00 * * * postgres YOUR_CRON_PATH/backup-postgre.sh > /var/log/backup-postgre/backup-postgre-$( date '+%Y-%m-%d_%H-%M-%S' ).log
```
