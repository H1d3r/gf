SHELL := /bin/bash

.PHONY: tidy
tidy:
	$(eval files=$(shell find . -name go.mod))
	@set -e; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		cd $$goModPath; \
		go mod tidy; \
		cd -; \
	done

.PHONY: lint
lint:
	golangci-lint run

# make version to=v2.4.0
.PHONY: version
version:
	newVersion=$(to); \
	.github/workflows/version.sh ./contrib $$newVersion; \
	.github/workflows/version.sh ./example $$newVersion; \
	echo done

# make cliversion to=v2.4.0
.PHONY: cliversion
cliversion:
	newVersion=$(to); \
	ls -l .github/workflows; \
	.github/workflows/version.sh ./cmd/gfly $$newVersion; \ 
	echo done


