#!/bin/bash

# neovim specific (nvim config folder is below and the .vimrc is called
# init.vim)
mkdir -p ~/.config/nvim
ln -f -s "$PWD/.vimrc" ~/.config/nvim/init.vim
ln -f -s "$PWD/ftplugin" ~/.config/nvim/ftplugin
