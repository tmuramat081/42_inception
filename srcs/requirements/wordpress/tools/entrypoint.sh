#!/bin/bash

set -e
# while ! mariadbadmin ping -h"mariadb" --silent; do
#     sleep 1
#     counter=$((counter+1))

#     if ((counter % 10 == 0)); then
#         echo "Still waiting for mariadb to respond. Waited ${counter} seconds."
#     fi

#     if ((counter > 120)); then
#         echo "Error: mariadb did not respond after ${counter} seconds. Exiting."
#         exit 1
#     fi
# done
wait_until_db_start() {
	echo "Waiting for MariaDB to start."
	local i
	for i in {10..0}; do
	if [ "$i" = 0 ]; then
		echo "Could not connect to MariaDB."
	fi
	if mariadb -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" <<<'SELECT 1;' &> /dev/null; then
		echo "MariaDB is started."
		break
	fi
	sleep 1
	done
}

wait_until_db_start

wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=${DB_HOST} --allow-root && \
wp db create --allow-root & \
wp core install --url=www.tmuramat.com --title=inception --admin_user=tmuramat --admin_password=password --admin_email=mt15hydrangea@gmail.com --allow-root

echo "wordpress installed"
