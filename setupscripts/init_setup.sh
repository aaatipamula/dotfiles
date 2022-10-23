#!/bin/sh

# This setup file is meant specifically for debian/ubuntu systems.

# Check if root
if [ $(whoami) != "root" ]
then
    echo Please run this script as root!
    exit 1
fi

# Add repo for neovim
sudo add-apt-repository ppa:neovim-ppa/stable

# Update and upgrade
sudo apt-get update && sudo apt-get upgrade

# Install commonly used programs (If not already installed)
sudo apt install htop ssh.server vim tmux docker rsync python3 neofetch neovim

# Install nvm for node version control etc.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Reload for nvm
source ~/.bashrc

# Install node 14.10.0
nvm install 14.10.0

