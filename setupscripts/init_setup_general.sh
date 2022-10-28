#!/bin/sh

# This is a general purpose setup file

# Check if root
if [ $(whoami) != "root" ]
then
    echo Please run this script as root!
    exit 1
fi

# update and upgrade
sudo $1 update && sudo $1 upgrade

# install commonly used programs
sudo $1 install htop vim tmux docker python3 
