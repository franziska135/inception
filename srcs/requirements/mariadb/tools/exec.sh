#!/bin/bash

cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# mysqld_safe --defaults-file=/etc/mysql/mariadb.conf.d/mariadb.conf

mysql_install_db --user=mysql --datadir=/var/lib/mysql

exec mysqld --init-file=/etc/mysql/init.sql