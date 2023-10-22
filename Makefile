NAME := inception
SRCS_DIR := srcs

VOLUMES_DIR := ~/data/mariadb ~/data/wordpress ~/data/redis ~/data/adminer

#: Start containers.
all: create-dirs
	docker compose up -d

#: Stop containers.
down:
	docker compose down

#: Stop containers and remove images, volumes, and networks.
clean:
	docker compose down --rmi all -v

build:
	docker compose build

#: Stop containers and remove images, volumes, networks, and build images.
re: clean all

#: Display containers status.
ps:
	docker compose ps

#: Create X.509 SSL certificate.
ssl:
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout srcs/requirements/nginx/ssl/private.key -out srcs/requirements/nginx/ssl/certificate.crt

#: Check the coding style of all Dockerfiles.
norm:
	hdolint srcs/requirements/**/Dockerfile

create-dirs:
	@for dir in $(VOLUMES_DIR); do \
		[ -d $$dir ] || mkdir -p $$dir; \
	done

#: Display all commands.
help:
	@grep -A1 -E "^#:" --color=auto Makefile \
	| grep -v -- -- \
	| sed 'N;s/\n/###/' \
	| sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
	| sed -e 's/^/make /' \

.PHONY: all clean fclean up down build rebuild ps ssl norm create-dir
