.DEFAULT_GOAL := help

.PHONY: build
build: ## build the site
	rm -rf build
	bundle exec jekyll build

.PHONY: server
server: ## run a webserver for previewing the site
	rm -rf build
	bundle exec jekyll server

.PHONY: release
release: ## release and deploy the master branch
	./deploy.sh

.PHONY: help
help:
	@awk -F":.*## " '$$2&&$$1~/^[a-zA-Z_%-]+/{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
