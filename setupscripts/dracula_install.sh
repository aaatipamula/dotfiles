#!/bin/sh

if [ -d ~/.vim/pack/themes/start ]
then
    cd ~/.vim/pack/themes/start
    git clone https://github.com/dracula/vim.git dracula
else
    mkdir -p ~/.vim/pack/themes/start
    cd ~/.vim/pack/themes/start
    git clone https://github.com/dracula/vim.git dracula
fi


