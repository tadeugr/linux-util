#!/bin/bash

# Location to place backups. Postgres user must have write permission
backup_dir="/DATA/BKP/DB"

# String to append to the name of the backup files
backup_date=`date +%Y-%m-%d-%H-%M`

# Numbers of days you want to keep copie of your databases
number_of_days=3

databases=`psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`
for i in $databases; do
  if [ "$i" != "template0" ] && [ "$i" != "template1" ]; then
    echo Dump $backup_dir/$i\_$backup_date

    pg_dump -b -F p postgres > $backup_dir/$i\_$backup_date.sql

    tar -cjvf $backup_dir/$i\_$backup_date.sql.tar.bz2 $backup_dir/$i\_$backup_date.sql

    if [ $? -eq 0 ]; then
        rm $backup_dir/$i\_$backup_date.sql
    fi
  fi
done

find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;

