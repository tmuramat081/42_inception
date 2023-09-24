#!/bin/bash
set -e

# MariaDBサービスを起動
service mysql start

# SQLコマンドの実行
mysql -u root <<-EOSQL
	CREATE DATABASE IF NOT EXISTS wp_database;
	CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'password';
	GRANT ALL PRIVILEGES ON wp_database.* TO 'wp_user'@'%';
	FLUSH PRIVILEGES;
EOSQL