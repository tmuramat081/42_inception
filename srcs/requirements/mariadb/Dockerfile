FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get install --no-install-recommends -y mariadb-server ca-certificates && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

EXPOSE 3306

# ENTRYPOINT [ "./tools/createdb.sh" ]

CMD ["mysqld"]