#!/bin/sh

if [ ! -d ~/.vim/pack/themes/start ]
then
    mkdir -p ~/.vim/pack/themes/start
fi

cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula


