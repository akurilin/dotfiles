#!/bin/bash

ln -f -s `pwd`/.bashrc.extras ~/.bashrc.extras
ln -f -s `pwd`/.tmux.conf ~/.tmux.conf
ln -f -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/.vimrc.vimwiki ~/.vimrc.vimwiki
ln -f -s `pwd`/.gitconfig ~/.gitconfig


ln -f -s $PWD/ftplugin ~/.vim
ln -f -s $PWD/syntax   ~/.vim
