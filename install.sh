#!/bin/bash

if [ -e $HOME/.vimrc ]
then
    rm $HOME/.vimrc
fi

ln -s $HOME/.vim/vimrc $HOME/.vimrc

sudo aptitude install -y rake vim-nox ruby-dev exuberant-ctags ack-grep pyflakes pep8 silversearcher-ag python-pip
sudo pip install flake8 yapf

cd ~/.vim
git submodule update --init --recursive

sudo aptitude install -y build-essential cmake python-dev
~/.vim/bundle/YouCompleteMe/install.sh

if [ ! -e "$HOME/.vimbackup" ]
then
    mkdir "$HOME/.vimbackup"
fi

if [ ! -e "$HOME/.vimswap" ]
then
    mkdir "$HOME/.vimswap"
fi

if [ ! -e "$HOME/.vimviews" ]
then
    mkdir "$HOME/.vimviews"
fi

if [ ! -e "$HOME/.vimundodir" ]
then
    mkdir "$HOME/.vimundodir"
fi

sudo chown -R $USER:$USER $HOME/.vimbackup $HOME/.vimswap $HOME/.vimviews $HOME/.vimundodir
