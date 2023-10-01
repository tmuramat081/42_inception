FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get install --no-install-recommends -y mariadb-server ca-certificates gosu && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
	chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 3306

CMD ["mysqld"]