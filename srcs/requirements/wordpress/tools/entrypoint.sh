#!/bin/bash
set -eu -o pipefail

wait_until_db_start() {
	echo "Waiting for MariaDB to start."
	local i
	for i in {30..0}; do
	if mariadb -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" <<<'SELECT 1;' &> /dev/null; then
		echo "MariaDB is started."
		return 0;
	fi
	sleep 1
	done
	echo "Could not connect to MariaDB."
	exit 1;
}

db_exists() {
	mariadb -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '${DB_NAME}'" | grep "${DB_NAME}" &> /dev/null
}

setup_wordpress() {
	if [ ! -f wp-config.php ]; then
		wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASSWORD} --dbhost=${DB_HOST} --allow-root
		wp config set FORCE_SSL_ADMIN true --raw --allow-root
		sed -i "/\/\/ marker for custom code/a if ( ! empty( \$_SERVER['HTTP_X_FORWARDED_PROTO'] ) &&\n\$_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' ) {\n    \$_SERVER['HTTPS']='on';\n}" wp-config.php
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
}

_main() {
	wait_until_db_start
	setup_wordpress
	echo "wordpress installed";
	exec "$@"
}

_main "$@"