#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe --skip-networking & until mysqladmin ping --silent; do
    sleep 1
done

cat << EOF > init.sql
CREATE DATABASE IF NOT EXISTS \`${MDB_NAME}\`;
CREATE USER IF NOT EXISTS '${MDB_USER}'@'%' IDENTIFIED BY '${MDB_PWD}';
GRANT ALL PRIVILEGES ON \`${MDB_NAME}\`.* TO '${MDB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysql -u root -p${MDB_ROOT_PWD} < init.sql
rm -f init.sql

mysqladmin -u root -p${MDB_ROOT_PWD} shutdown

exec mysqld --bind-address=0.0.0.0
