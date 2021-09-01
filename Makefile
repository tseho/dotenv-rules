ifneq (,$(wildcard ./.env))
	MAKEFILE_DOTENV_PATH=/tmp/$(shell basename $$(pwd)).env.mk
	MAKEFILE_DOTENV=$(shell cat .env | grep -v --perl-regexp '^('$$(env | sed 's/=.*//'g | tr '\n' '|')')\=' | sed 's/=/?=/g' > $(MAKEFILE_DOTENV_PATH); echo '$(MAKEFILE_DOTENV_PATH)')
	include $(MAKEFILE_DOTENV)
endif

ORIGIN ?= make

export

.PHONY: bash
bash:
	@echo $(ORIGIN)

.PHONY: docker
docker:
	@docker-compose up --no-log-prefix 2>/dev/null | grep "ORIGIN" | sed -E "s/^.*=//g"
