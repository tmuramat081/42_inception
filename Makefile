NAME := inception
SRCS_DIR := srcs
IMAGES := nginx wordpress mariadb

#: Start containers.
all:
	cd ${SRCS_DIR} && docker-compose up -d

#: Stop containers.
clean:
	cd ${SRCS_DIR} && docker-compose down

#: Stop containers and remove images, volumes, and networks.
fclean:
	cd ${SRCS_DIR} && docker-compose down --rmi all -v

build:
	cd ${SRCS_DIR} && docker-compose build

nginx:
	cd ${SRCS_DIR} && docker-compose exec -it nginx bash

wordpress:
	cd ${SRCS_DIR} && docker-compose exec -it wordpress bash

#: Stop containers and remove images, volumes, networks, and build images.
re: fclean all

#: Display containers status.
ps:
	cd ${SRCS_DIR} && docker-compose ps

ssl:
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout srcs/requirements/nginx/ssl/private.key -out srcs/requirements/nginx/ssl/certificate.crt

#: Display all commands.
help:
	@grep -A1 -E "^#:" --color=auto Makefile \
	| grep -v -- -- \
	| sed 'N;s/\n/###/' \
	| sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
	| sed -e 's/^/make /' \

.PHONY: up down build rebuild ps
