#!/bin/bash

if [ -e $HOME/.vimrc ]
then
    rm $HOME/.vimrc
fi

ln -s $HOME/.vim/vimrc $HOME/.vimrc

sudo aptitude install rake vim-nox ruby-dev exuberant-ctags ack-grep pyflakes pep8 nodejs npm
sudo npm config set registry http://registry.npmjs.org/
sudo npm install -g jslint
sudo npm install -g jshint
sudo pip install flake8 yapf

cd ~/.vim
tar -zxvf rope-0.9.3.tar.gz
cd rope-0.9.3
sudo python setup.py build
sudo python setup.py install
cd ..
sudo rm -rf rope-0.9.3

cd ~/.vim/bundle/command-t
rake make

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

sudo chown -R $USER:$USER $HOME/.vimbackup $HOME/.vimswap $HOME/.vimviews

chmod a+x "$HOME/.vim/vimpsqlpager"
sudo ln -s "$HOME/.vim/vimpsqlpager" "/bin/vimpsqlpager"
chmod a+x "$HOME/.vim/vimpgclipager"
sudo ln -s "$HOME/.vim/vimpgclipager" "/bin/vimpgclipager"
