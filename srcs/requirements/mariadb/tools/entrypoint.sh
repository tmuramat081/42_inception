#!/bin/bash
set -eo pipefail

SOCKET="/run/mysqld/mysqld.sock"

docker_temp_server_start() {
	echo "docker temp server start"
	mysqld&
	MARIADB_PID=$!
	local i
	for i in {30..0}; do
		echo "..."
		if mariadb --protocol=socket -uroot -hlocalhost -ppassword --socket="$SOCKET" -e 'SELECT 1;' &> /dev/null; then
			echo "database is up"
			return 0
		fi
		sleep 1
	done
	echo "Unable to start server."
	exit 1
}

docker_temp_server_stop() {
	kill "$MARIADB_PID"
	wait "$MARIADB_PID"
}

docker_create_database() {
# 	mysql -uroot -hlocalhost -ppassword << EOF
# CREATE DATABASE IF NOT EXISTS $DB_NAME;
# CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
# GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
# FLUSH PRIVILEGES;
# ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
# EOF
	mysql -uroot -hlocalhost -ppassword << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
USE $DB_NAME;
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS DoesUserExist()
BEGIN
	DECLARE userCount INT;
	SELECT COUNT(*) INTO userCount FROM mysql.user WHERE User='$DB_USER' AND Host='%';
	IF userCount = 0 THEN
		CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
		GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
		FLUSH PRIVILEGES;
	END IF;
END //
DELIMITER ;
CALL DoesUserExist();
DROP PROCEDURE IF EXISTS DOESUserExist;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
EOF
}

is_initialized() {
	[ -e /var/lib/mysql/"${DB_NAME}" ]
}

_main() {
	if ! is_initialized; then
		docker_temp_server_start
		docker_create_database
		echo "Now MariaDB is setup"
		docker_temp_server_stop
	fi
	exec "$@"
}

_main "$@"
