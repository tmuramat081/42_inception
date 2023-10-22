FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get install --no-install-recommends -y bind9 gettext-base && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	chown -R bind:bind /etc/bind/

COPY ./conf/named.conf.template /etc/bind/named.conf.template
COPY ./conf/named.zone.template /etc/bind/named.zone.template
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
	chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 53/TCP 53/UDP

CMD [ "named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind" ]
