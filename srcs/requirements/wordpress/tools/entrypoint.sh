#!/bin/bash
set -eu -o pipefail

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

db_exists() {
	mariadb -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '${DB_NAME}'" | grep "${DB_NAME}" &> /dev/null
}

wait_until_db_start

if [ ! -f wp-config.php ]; then
	wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=${DB_HOST} --allow-root
else
	echo "wp-config.php already exists, skipping config creation."
fi

if ! db_exists; then
	wp db create --allow-root
else
	echo "Database ${DB_NAME} already exists, skipping creation."
fi

if ! wp core is-installed --allow-root; then
	wp core install --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
fi

echo "wordpress installed";

exec "$@"