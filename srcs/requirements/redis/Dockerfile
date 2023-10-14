FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get install --no-install-recommends -y lsb-release curl ca-certificates  gpg && \
    curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list && \
	apt-get update && \
    apt-get install redis -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/redis.conf etc/redis/redis.conf

EXPOSE 6379

CMD [ "/usr/bin/redis-server", "/etc/redis/redis.conf", "--appendonly", "yes" ]
