# Dotfiles

[![Lint](https://github.com/akurilin/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/akurilin/dotfiles/actions/workflows/lint.yml)

## Neovim Configuration

Run these commands from the dotfiles repo root (`/Users/alex/code/dotfiles`) to configure Neovim to use this repo for both `init.vim` and `ftplugin`:

```bash
mkdir -p ~/.config/nvim
ln -sfn /Users/alex/code/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sfn /Users/alex/code/dotfiles/ftplugin ~/.config/nvim/ftplugin
```

## Linting And Hooks

- Run checks: `make lint`
- Auto-format shell scripts: `make fmt`
- Enable repo hooks: `make install-hooks`

The pre-commit hook runs `make lint` (shellcheck + shfmt + vint).

`vint` is intentionally scoped to a small set of maintained `ftplugin/*.vim` files to avoid noise from legacy Vim runtime-style scripts.
