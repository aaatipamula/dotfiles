#!/bin/sh

# This is a general purpose setup file

# Check if root
if [ $(whoami) != "root" ]
then
    echo Please run this script as root!
    exit 1
fi

sudo $1 update && sudo $1 upgrade

sudo $1 install htop ssh.server vim tmux docker rsycn python3 neofetch neovim node.js
