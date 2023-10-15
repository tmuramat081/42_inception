FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y php-fpm php-mysql php-pgsql php-sqlite3 php-mongodb nginx curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/php && \
    mkdir -p /var/www/adminer && \
	chown -R www-data:www-data /var/www/adminer

WORKDIR /var/www/adminer

RUN curl -L -o adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 8080

CMD ["php-fpm7.4", "-F"]
