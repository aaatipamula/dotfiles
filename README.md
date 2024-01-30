# Dotfiles

[![test-scripts](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml/badge.svg)](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml)

## About

This is a repo to host any files and scripts that help me get a machine set up faster. That way I don't have to go back and manually do all of this configuration again. （。＾▽＾）

## Directories

### config_files

This is just config files for various programs. They are listed below:

- Bash
- Git

### vim

This contains two different config files for vim. 

- vimrc
- basic.vim

The `vimrc` file contains my main fully decked out config for Vim. This is now deprecated as I have switched to neovim.<br> 

The `basic.vim` file is a basic config for Vim that I use on remote machines or machines I don't intend to use regularly.

### setupscripts

This contains 2 files. 

- `setup_functions.sh`
- `setup`

`setup_function.sh` is a collection of functions that each perform a specific install or setup action. <br>

The second file is a setup script where specific parts of setup can be initated. This setup script will add all my prefered shell configurations regardless of any flags present or not. There are also options to perform specific actions from `setup_functions.sh` as neeed.

### nvim

This contains configurations for nvim and nvchad. (*deprecated*)

### tests

This contains a scripts to test the install functions

