.PHONY: help update


help:  ## Print this help
	@awk -F:.*## 'BEGIN {printf "Usage:\n  $(MAKE) \033[36m<target>\033[0m\n"}/^[\/a-zA-Z_0-9-]+:.*?##/{printf "  \033[36m%-12s\033[0m %s\n",$$1,$$2}/^##@/{printf "\n\033[1m%s\033[0m\n", substr($$0, 5)}' $(MAKEFILE_LIST)

update: ## Update packages (presents in src/)
	$(MAKE) -C src all
