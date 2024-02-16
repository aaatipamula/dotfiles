# Dotfiles

[![test-scripts](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml/badge.svg)](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml)

## About

This repo hosts my [dotfiles](https://missing.csail.mit.edu/2019/dotfiles/). I also have some setup scripts and testing scripts.

## Files

### config_files

This is just config files for various programs. They are listed below:

- Bash
- Git

### vim

This contains two different config files for vim. 

- vimrc
- basic.vim

The `vimrc` file contains my main fully decked out config for Vim.

The `basic.vim` file is a basic config for Vim that I use on remote machines or machines I don't intend to use regularly.

### setupscripts

This contains 2 files. 

- `setup`
- `setup_functions.sh`

The first file is a script that makes running setup funtions easier. This setup script can run a few presets I've defined, (`main`, `server`, `bare`). There are also options to perform specific actions from `setup_functions.sh` as need.

`setup_function.sh` is a collection of functions that each perform a specific install or setup action. <br>


### nvim

This contains configurations for nvim and nvchad. (**deprecated**)

### tests

This contains a scripts to test the install functions.

