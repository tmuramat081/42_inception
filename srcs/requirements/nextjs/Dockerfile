# Dockerfile
FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update && \
	apt-get install -y --no-install-recommends ca-certificates curl gnupg && \
	mkdir -p /etc/apt/keyrings && \
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
	NODE_MAJOR=18 && \
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
	apt-get update && \
	apt-get install -y nodejs && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

COPY ./app .

RUN npm install

RUN npm run build && npm run export

RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", "out", "-p", "3000"]