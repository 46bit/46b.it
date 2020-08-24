.DEFAULT_GOAL := help

.PHONY: clean
clean: ## delete build cache
	rm -rf build

.PHONY: preview
preview: clean ## run a webserver for previewing the site
	bundle exec jekyll server

.PHONY: build
build: clean ## build the site to a deployable state
	bundle exec jekyll build

.PHONY: test
test: build ## check the site for dead links
	bundle exec htmlproofer ./build

.PHONY: help
help:
	@awk -F":.*## " '$$2&&$$1~/^[a-zA-Z_%-]+/{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
