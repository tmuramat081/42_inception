FROM debian:bullseye-slim

RUN set -eux; \
	# upgrade packages
	apt-get update && \
	apt-get upgrade -y && \
	# install packages
	apt-get install -y --no-install-recommends -y php-fpm php-mysql wget unzip curl ca-certificates mariadb-client sendmail redis php-redis && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/php && \
	mkdir -p /var/www/html && \
	chown -R www-data:www-data /var/www/html && \
	chown -R www-data:www-data /run/php

WORKDIR /var/www/html

RUN set -eux; \
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	wp core download --allow-root

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
	chmod +x /entrypoint.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["php-fpm7.4", "-F"]
