FROM nginx:1.24.0

RUN set -eux; \
	apt-get update && \
	apt-get install --no-install-recommends -y gettext-base && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/www/adminer

# 設定ファイルのコピー
COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN set -eux; \
	chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

# ポートの公開
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
