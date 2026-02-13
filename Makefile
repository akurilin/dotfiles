SHELL := /bin/bash

SHELL_FILES := $(shell git ls-files | grep -E '\.sh$$' || true)
# Keep vint focused on actively maintained Vimscript files.
# Legacy/runtime-derived ftplugin files are intentionally excluded.
VINT_FILES := ftplugin/sh.vim ftplugin/haskell.vim ftplugin/markdown.vim ftplugin/yaml.vim ftplugin/text.vim ftplugin/csv.vim

.PHONY: lint lint-shell lint-vim fmt fmt-shell check-tools install-hooks

lint: lint-shell lint-vim

lint-shell: check-tools
	@shellcheck $(SHELL_FILES)
	@shfmt -d $(SHELL_FILES)

lint-vim: check-tools
	@vint $(VINT_FILES)

fmt: fmt-shell

fmt-shell: check-tools
	@shfmt -w $(SHELL_FILES)

check-tools:
	@command -v shellcheck >/dev/null || (echo "Missing tool: shellcheck" && exit 1)
	@command -v shfmt >/dev/null || (echo "Missing tool: shfmt" && exit 1)
	@command -v vint >/dev/null || (echo "Missing tool: vint" && exit 1)

install-hooks:
	@git config core.hooksPath .githooks
	@chmod +x .githooks/pre-commit
	@echo "Installed git hooks from .githooks/"
