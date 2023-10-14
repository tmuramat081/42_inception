FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install --no-install-recommends -y bind9 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	chown -R bind:bind /etc/bind/

COPY ./conf/named.conf /etc/bind/named.conf
COPY ./conf/named.zone /etc/bind/named.zone
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
	chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 53/TCP 53/UDP

CMD [ "named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind" ]
