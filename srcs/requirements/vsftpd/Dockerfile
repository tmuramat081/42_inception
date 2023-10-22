FROM debian:bullseye-slim

ARG FTP_PASSWORD="ftp_password"

RUN set -eux; \
    apt-get update && \
    apt-get install -y --no-install-recommends vsftpd && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

RUN mkdir -p /var/www/html /var/run/vsftpd/empty && \
    useradd -m ftpuser && \
    echo "ftpuser:${FTP_PASSWORD}" | chpasswd && \
    chown -R ftpuser:ftpuser /var/www/html && \
    chmod -R 755 /var/www/html 

EXPOSE 20-21

EXPOSE 21100-21110

CMD ["vsftpd", "/etc/vsftpd.conf"]