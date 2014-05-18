#!/bin/bash

ln -f -s `pwd`/.bashrc.extras ~/.bashrc.extras
ln -f -s `pwd`/.tmux.conf ~/.tmux.conf
ln -f -s `pwd`/.vimrc ~/.vimrc
ln -f -s `pwd`/.gemrc ~/.gemrc
if [ ! -f ~/.vimrc.vimwiki ]
then
  ln -s `pwd`/.vimrc.vimwiki ~/.vimrc.vimwiki
fi
ln -f -s `pwd`/.gitconfig ~/.gitconfig


mkdir -p ~/.vim/after
ln -f -s $PWD/ftplugin ~/.vim/after
ln -f -s $PWD/syntax   ~/.vim/after

mkdir -p ~/.xmonad
ln -f -s $PWD/xmonad.hs ~/.xmonad/xmonad.hs
