# Dotfiles

[![test-scripts](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml/badge.svg)](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Vim](https://img.shields.io/badge/VIM-%2311AB00.svg?style=for-the-badge&logo=vim&logoColor=white)

## About

This repo hosts my [dotfiles](https://missing.csail.mit.edu/2019/dotfiles/). I also have some setup and helper scripts.

## Quick Setup

I only use this for temporary machines and/or remote machines.

Copy `.vimrc`:

```sh
curl https://raw.githubusercontent.com/aaatipamula/dotfiles/master/vim/basic.vim > ~/.vimrc
```

Copy `.bashrc`:

```sh
curl https://raw.githubusercontent.com/aaatipamula/dotfiles/master/config_files/.bashrc > ~/.bashrc
```

## Setup

Clone this repository:

```sh
# SSH URL is git@github.com:aaatipamula/dotfiles.git
git clone https://github.com/aaatipamula ~/dotfiles
```

Use a preset:

```sh
cd ~/dotfiles && ./scripts/setup preset <tag> <package-manager?>
```

`tag` options:

- main - *Requires sudo permissions and `<package-manager?>` to be specified*
- server - *Requires sudo permissions and `<package-manager?>` to be specified*
- bare

`package-manager` options:

- apt
- brew
- dnf

Setup specific items:

```sh
cd ~/dotfiles && ./scripts/setup <function> <package-manager?>
```

`function` options:

- apps - *Requires sudo permissions and `<package-manager?>` to be specified*
- bash
- git
- vim
- vim-plug
- dracula-vim
- vimb
- nvim

## Files

### `config_files`

This are just config files for various programs.

- Bash
- Git

### `vim`

This contains two different config files for vim. 

- vimrc
- basic.vim

The `vimrc` file contains my main fully decked out config for Vim.

The `basic.vim` file is a basic config for Vim that I use on remote machines or machines I don't intend to use regularly.

### `setupscripts`

This contains 2 files. 

- `setup`
- `setup_functions.sh`

The first file is a script that makes running setup funtions easier. This setup script can run a few presets I've defined, (`main`, `server`, `bare`). There are also options to perform specific actions from `setup_functions.sh` as need.

`setup_function.sh` is a collection of functions that each perform a specific install or setup action. <br>


### `nvim`

My config for neovim. Mirrors my standard vim config but does not use `coc.nvim` for LSP which removes the `node.js` dependency.

### `tests`

This contains a scripts to test the install functions.

