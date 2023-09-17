FROM debian:bullseye

RUN apt-get update && apt-get install -y php-fpm php-mysql wget unzip

RUN wget https://wordpress.org/latest.zip && unzip latest.zip -d /var/www/html/

# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.4"]