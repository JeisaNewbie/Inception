NAME = inception

SRC_DIR = ./srcs

DOCKER_COMPOSE_FILE = $(SRC_DIR)/docker-compose.yml

DOCKER_COMPOSE = docker-compose -f $(DOCKER_COMPOSE_FILE)


$(NAME) : all

all : up

clean : stop
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume prune || \
	echo "clean up"

up :
	$(DOCKER_COMPOSE) up -d --build

down :
	$(DOCKER_COMPOSE) down

start :
	$(DOCKER_COMPOSE) start

stop :
	$(DOCKER_COMPOSE) stop

status :
	$(DOCKER_COMPOSE) ps

.PHONY: all clean up down start stop status