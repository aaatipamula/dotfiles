# Dotfiles

[![test-scripts](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml/badge.svg)](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml)

## About

This is a repo to host any files and scripts that help me get a machine set up faster. That way I don't have to go back and manually do all of this configuration again. （。＾▽＾）

### config_files

This is just config files for various programs. They are listed below:
- Bash
- Git
This also contains a script that makes it easier to access README.md files

### vim

This contains two different config files for vim. 

- vimrc
- basic.vim

The `vimrc` file contains my main fully decked out config for Vim. This is mostly used on any machine that I will regularly code on. 
The `basic.vim` file is a basic config for Vim that I use on remote machines or machines I don't intend to use regularly.

### setupscripts

This contains 3 files. 

- `dracula_install.sh`
- `init_setup.sh`

> The first file is a simple script to install the Dracula theme for vim. I don't intend to use this often however its there if I need it.
> The second file is a setup script where specific parts of setup can be initated or no. This setup script will add all my prefered shell configurations regardless of any flags present or not. There are also options to install vim and install apps that I use often based on how often I plan on using the machine. 
> The third file is a setup script for any other Linux machine I may use. Its here just incase the previous file doesn't work for one reason or another
