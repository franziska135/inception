# Use (penultimate stable version) as base image
FROM debian:bullseye

# Install mariadb server and client
RUN apt-get update && apt-get install -y mariadb-server mariadb-client \
    net-tools

# Create  directories and amend ownerships
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && \
    mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# (Optional) Copy  custom MariaDB configuration file
# Create a minimal configuration file in the same directory named "my.cnf"
COPY /conf/mariadb.cnf /etc/mysql/mariadb.conf.d

COPY /tools/exec.sh .

RUN chmod 777 exec.sh

# On first run, initialize the database and then start MariaDB using mysqld_safe.
CMD ["./exec.sh"]