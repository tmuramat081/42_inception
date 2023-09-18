FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get install --no-install-recommends -y php-fpm php-mysql wget unzip curl ca-certificates && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/php && \
	chown -R www-data:www-data /run/php

RUN set -eux; \
	version='6.3.1'; \
	sha1='052777aef40e7f627c63c8a26eefe37b843a44df'; \
	curl -o wordpress.tar.gz -fL "https://wordpress.org/wordpress-$version.tar.gz"; \
	echo "$sha1 *wordpress.tar.gz" | sha1sum -c -; \
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress;

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT ["/bin/bash"]

CMD ["php-fpm7.4", "-F"]