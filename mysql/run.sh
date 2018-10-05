#!/bin/bash

#### install db on docker run ####

if [ -d /app/mysql ]; then
  echo "[i] MySQL directory already present, skipping creation"
  touch x
else
  echo "[i] MySQL data directory not found, creating initial DBs"

  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  chown -R mysql:mysql /var/lib/mysql
  chmod 777 /var/lib/mysql

  if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
    MYSQL_ROOT_PASSWORD='DBAdmin1'
    echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
  fi

  MYSQL_USER=${MYSQL_USER:-""}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

  if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
  fi

  tfile="$(mktemp)"
  chown mysql:mysql $tfile

  echo $tfile
  if [ ! -f "$tfile" ]; then
      return 1
  fi

  cat << EOF > $tfile

USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
EOF

  if [ "$MYSQL_USER" != "" ]; then
    echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
    echo "GRANT ALL ON *.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
    echo "GRANT ALL ON *.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
  fi

  mysqld_safe --init-file=$tfile
  rm -f $tfile
fi

exec mysqld_safe
