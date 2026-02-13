# Dotfiles

## Neovim Configuration

Run these commands from the dotfiles repo root (`/Users/alex/code/dotfiles`) to configure Neovim to use this repo for both `init.vim` and `ftplugin`:

```bash
mkdir -p ~/.config/nvim
ln -sfn /Users/alex/code/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sfn /Users/alex/code/dotfiles/ftplugin ~/.config/nvim/ftplugin
```
