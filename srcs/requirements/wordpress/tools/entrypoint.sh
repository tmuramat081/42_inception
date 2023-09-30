#!/bin/bash
set -e

while ! mysqladmin ping -h"mariadb" --silent; do
    sleep 1
done

wp config create --dbname=wp_database --dbuser=wp_user --dbpass=password --dbhost=mariadb:3306 --allow-root && \
wp db create --allow-root && \
wp core install --url=www.tmuramat.com --title=inception --admin_user=tmuramat --admin_password=password --admin_email=mt15hydrangea@gmail.com --allow-root

exec "$@"