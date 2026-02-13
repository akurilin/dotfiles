# Dotfiles

[![Lint](https://github.com/akurilin/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/akurilin/dotfiles/actions/workflows/lint.yml)

## Neovim Configuration

Run the setup script from the dotfiles repo root (`/Users/alex/code/dotfiles`):

```bash
./set-up-symlinks.sh
```

## Linting And Hooks

- Run checks: `make lint`
- Auto-format shell scripts: `make fmt`
- Enable repo hooks: `make install-hooks`

The pre-commit hook runs `make lint` (shellcheck + shfmt + vint).

`vint` is intentionally scoped to a small set of maintained `ftplugin/*.vim` files to avoid noise from legacy Vim runtime-style scripts.
