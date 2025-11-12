# Dotfiles

[![test-scripts](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml/badge.svg)](https://github.com/aaatipamula/dotfiles/actions/workflows/test.yml)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Vim](https://img.shields.io/badge/VIM-%2311AB00.svg?style=for-the-badge&logo=vim&logoColor=white)

## About

This repo hosts my [dotfiles](https://missing.csail.mit.edu/2019/dotfiles/) for *most* Linux machines and commonly used programs. I also have some setup and helper scripts.

## Setup

Run the two following commands to get started.

```bash
git clone https://github.com/aaatipamula/dotfiles.git ~
cd ~/dotfiles && ./setupscripts/setup
```

The following options are availabile for `setup`:

```
Use:
  setup preset [PRESETS] [PACKAGE_MANAGER]
  setup [FUNCTION]
  setup help -- This message

[PACKAGE_MANAGER]
  - brew
  - apt
  - dnf

[PRESETS]
  - main:  Configures all programs, installs all common applications.
  - progs: Configures all programs.
  - bare:  Configure just bash, git, basic vim.

[FUNCTION]
  - apps [PACKAGE_MANAGER]
  - zsh
  - bash
  - git
  - vim
  - nvim
  - tmux
  - hypr
  - waybar
  - kitty
  - wezterm
  - wofi
  - electron
  - ghostty
  - fastfetch
  - wsl
```

# TODO

- [ ] Add Arch Linux post-install scripts

