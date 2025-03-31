
# penultimate stable version as base image
FROM debian:bullseye

# Install mariadb client and server
RUN apt-get update && apt-get install -y \
    php php-fpm php-mysql php-gd php-xml \
    php-curl php-zip curl iputils-ping netcat

#Verzeichnis für php erstellen und ownership setzen
RUN mkdir -p /var/run/php/ \
    && chown www-data:www-data /var/run/php/

# Copy custom wp configuration file; source --> destination
COPY /conf/www.conf /etc/php/7.4/fpm/pool.d

COPY /tools/exec.sh .

#set permissions
RUN chmod 777 exec.sh

# Expose port
EXPOSE 9000

# init database and start mariadb using mysqld_safe.
# skript lädt und konfiguriert wordpress über wp-cli
CMD ["./exec.sh"]
