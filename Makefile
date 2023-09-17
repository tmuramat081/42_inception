SRCS_DIR = srcs

up:
	cd ${SRCS_DIR} && docker-compose up -d

down:
	cd ${SRCS_DIR} && docker-compose down

build:
	cd ${SRCS_DIR} && docker-compose build

rebuild: down build up

ps:
	cd ${SRCS_DIR} && docker-compose ps

.PHONY: up down build rebuild ps
