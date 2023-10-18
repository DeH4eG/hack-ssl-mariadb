.DEFAULT_GOAL:=help
SHELL ?= bash

USER_NAME ?= $(shell id -un)
USER_ID ?= $(shell id -u)

DOCKER := docker
DOCKER_COMPOSE := $(shell ((which docker-compose > /dev/null 2>&1 && echo docker-compose) || echo docker compose))
DOCKER_COMPOSE_WITH_ENV := USER_NAME=${USER_NAME} USER_ID=${USER_ID} ${DOCKER_COMPOSE}

##@ Common

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Docker

.PHONY: ps
ps: ## Lists containers for a Compose project, with current status and exposed ports.
	@$(DOCKER_COMPOSE) ps

.PHONY: build
build: ## Build or rebuild services [--pull (Always attempt to pull a newer version of the image)] [--no-cache (Do not use cache when building the image)]
	@$(DOCKER_COMPOSE_WITH_ENV) build --pull --no-cache

.PHONY: up
up: ## Create and start containers [--remove-orphans (Remove containers for services not defined in the Compose file)] [--detach (Detached mode: Run containers in the background)]
	@$(DOCKER_COMPOSE_WITH_ENV) up --remove-orphans --detach

.PHONY: down
down: ## Stop and remove containers, networks [--remove-orphans (Remove containers for services not defined in the Compose file)]
	@$(DOCKER_COMPOSE) down --remove-orphans

.PHONY: logs
logs: ## View output from containers
	@$(DOCKER_COMPOSE) logs

.PHONY: logs-f
logs-f: ## View output from containers [--follow (Follow log output)]
	@$(DOCKER_COMPOSE) logs --follow

##@ Application

.PHONY: shell-db
shell-db: ## Starts a new shell session in the php service container
	@$(DOCKER_COMPOSE) exec -it db bash

.PHONY: start
start: up ## Same as `up`

.PHONY: restart
restart: down start ## Same as `down` and `start` commands