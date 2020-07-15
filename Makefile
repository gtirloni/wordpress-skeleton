PROJECT= website
COMPOSE_FILE=deploy/docker-compose.yml
COMPOSE=docker-compose -p ${PROJECT} -f ${COMPOSE_FILE}
COMPOSER=docker run --rm -ti -v ${CURDIR}/.composer/cache:/tmp -v ${CURDIR}:/app --user $(shell id -u):$(shell id -g) composer

.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo

.PHONY: build
build:  ## Build new images
	@${COMPOSE} build

.PHONY: check-clean-all
check-clean-all:
	@echo -n "This will deleted EVERYTHING (including the database). Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]

.PHONY: clean
clean:  ## Stop and remove containers
	@${COMPOSE} down

.PHONY: clean-all
clean-all: check-clean-all  ## Stop and remove containers, images and volumes (CAREFUL)
	@${COMPOSE} down --volumes --rmi local

.PHONY: clean-db
clean-db:  ## Remove volume containing database
	@docker volume rm --force ${PROJECT}_db

.PHONY: clean-wordpress
clean-wordpress: ## Remove volume containing project code
	@docker volume rm --force ${PROJECT}_wordpress

.PHONY: install
install: ## Performs initial project configuration (install packages, etc.)
	@mkdir -p ${CURDIR}/.composer/cache
	@${COMPOSER} install

.PHONY: logs
logs:  ## Show container logs
	@${COMPOSE} logs --follow

.PHONY: restart
restart: stop start ## Stop and start containers

.PHONY: start
start:  ## Start containers, network and volumes
	@${COMPOSE} up --detach

.PHONY: stop
stop:  ## Stop containers
	@${COMPOSE} stop

.PHONY: status
status:  ## Show container and volume statuses
	@echo -e "\nContainers:\n"
	@${COMPOSE} ps
	@echo -e "\nVolumes:\n"
	@docker volume ls | grep -E "${PROJECT}_" || true

.PHONY: update
update:  ## Update Composer packages
	@${COMPOSER} update
