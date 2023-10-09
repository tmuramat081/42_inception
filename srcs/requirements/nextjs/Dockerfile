# Dockerfile
FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y ca-certificates curl gnupg && \
	mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
	NODE_MAJOR=18 && \
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
	apt-get update && \
	apt-get install -y nodejs && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY conf/package.json /package.json

COPY tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
	chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 3000

CMD ["sh", "-c", "while true; do sleep 3600; done"]
# CMD ["npm", "start"]
