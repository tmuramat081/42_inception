FROM debian:bullseye-slim

RUN set -eux; \
	# upgrade packages
	apt-get update && \
	apt-get upgrade && \
	# install packages
	apt-get install --no-install-recommends -y php-fpm php-mysql wget unzip curl ca-certificates mariadb-client && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/php && \
	chown -R www-data:www-data /run/php

RUN set -eux; \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	wp core download --allow-root && \
	wp config create --dbname=wp_database --dbuser=wp_user --dbpass=password --dbhost=mariadb --allow-root && \
	wp db create --allow-root && \
	wp core install --url=www.tmuramat.com --title=inception --admin_user=tmuramat --admin_password=password --admin_email=mt15hydrangea@gmail.com --allow-root && \
	chown -R www-data:www-data /usr/src/wordpress;

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]