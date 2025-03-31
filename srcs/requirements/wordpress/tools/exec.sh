#!/bin/bash

cd /var/www/html
#wordpress client download
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#setting permissions
chmod +x wp-cli.phar
#wordpress download
./wp-cli.phar core download --allow-root

# set wordpress configuration
./wp-cli.phar config create \
    --dbname="${DB_NAME}" \
    --dbuser="${DB_USER}" \
    --dbpass="${DB_PASSWORD}" \
    --dbhost="${DB_HOST}" --allow-root

#install wp konfig
./wp-cli.phar core install \
    --url="${DOMAIN_NAME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USR}" \
    --admin_password="${WP_ADMIN_PWD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root 

#add another user
./wp-cli.phar user create \
    "${WP_USR}" "${WP_EMAIL}" --role=author --user_pass="${WP_PWD}" --allow-root

exec php-fpm7.4 -F