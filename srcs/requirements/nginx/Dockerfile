FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get install --no-install-recommends -y nginx gettext-base && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
    	mkdir -p /var/www/adminer

COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
        chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]/www/adminer

COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
	chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
