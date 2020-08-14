.DEFAULT_GOAL := help

.PHONY: preview
preview: ## run a webserver for previewing the site
	rm -rf _preview
	bundle exec jekyll server --destination _preview --drafts --future

.PHONY: build
build: ## build the site to a deployable state
	rm -rf build
	bundle exec jekyll build

.PHONY: help
help:
	@awk -F":.*## " '$$2&&$$1~/^[a-zA-Z_%-]+/{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
