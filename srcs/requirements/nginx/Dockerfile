FROM nginx:1.24.0

RUN mkdir -p /var/wwww/adminer

# 設定ファイルのコピー
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# ポートの公開
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
