#!/bin/sh

# This is a general purpose setup file

# Check if root
if [ $(whoami) != "root" ]
then
    echo Please run this script as root!
    exit 1
fi

sudo $1 update && sudo $1 upgrade

sudo $1 install htop ssh.server vim tmux docker python3 neovim nodejs
