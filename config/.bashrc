# VIM is my default editor
export VISUAL="vim"
export EDITOR="vim"
export XDG_CONFIG_HOME="$HOME/.config" # Config home
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_DOWNLOADS_DIR="$HOME/Downloads"
export TERM=xterm-256color             # Correct terminal

# Configuration file locations
export dotfiles="$HOME/dotfiles"
export bashrc="$HOME/.bashrc"
export bashpr="$HOME/.bash_profile"
export vimrc="$HOME/.vim/vimrc"
export gitconf="$HOME/.gitconfig"
export bashal="$HOME/.bash_aliases"
export nvimc="$XDG_CONFIG_HOME/nvim"
export tmuxc="$XDG_CONFIG_HOME/tmux/tmux.conf"

# Get git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

alias ls="ls -lh --color=auto"
alias l.="ls -d .*"         # Only hidden directory
alias ll="ls -rt"           # Organize by date modified
alias ld="ls -Ud */"        # Only directories
alias la="ls -a"            # Everything including hidden files
alias size="du -sh"         # Check folder size
alias mkdirs="mkdir -p"     # Shortcut create directory if not exists
alias p3="python3"          # Shortcut python3 bin
alias hist="history"        # Shortcut history
alias gd="git diff"         # Quick diff
alias gs="git status"       # Quick status
alias gl="git log"          # Quick log
alias tmn="tmux new -s"     # tmux new session
alias tma="tmux a -t"       # tmux attach to session

# Easy access/edit config files
alias vimrc="$VISUAL $vimrc"
alias bashrc="$VISUAL $bashrc"
alias bashpr="$VISUAL $bashpr"
alias gitconf="$VISUAL $gitconf"
alias bashal="$VISUAL $bashal"
alias nvimc="$VISUAL $nvimc"
alias tmuxc="$VISUAL $tmuxc"
alias loadbash="source $bashrc"
alias dotfiles="cd $dotfiles"

# Machine specific config
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Set machine name
if [ $machine_name ]; then
  NAME=$machine_name
else
  NAME="\h"
fi

# Command Prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]$NAME \[$(tput setaf 3)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\]\$(parse_git_branch)\[$(tput setaf 6)\]\n-> \[$(tput sgr0)\]"

# Make sure path includes my local bin and scripts directory
export PATH="$HOME/.local/bin:$PATH"
export PATH="$dotfiles/scripts:$PATH"

# Change directory by just typing in name
shopt -s autocd

# Use Vi bindings to move around and edit in terminal
set -o vi

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:ignoredups:erasedups
HISTIGNORE="ls:exit:pwd:clear"

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=2000

# Colored GCC warnings and errors
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# fzf config
export FZF_CTRL_T_OPTS="
  --style full
  --walker-skip .git,node_modules,target
  --preview 'fzf-preview.sh {}'
  --bind 'focus:transform-header:file --brief {}'"
export FZF_ALT_C_OPTS="
  --style full
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
export FZF_CTRL_R_OPTS="
  --reverse
"

export FZF_DEFAULT_OPTS="--margin 1 --padding 1 --border"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"
