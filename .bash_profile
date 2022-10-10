# Include bashrc if present if [ -f "$HOME/.bashrc" ];
if [ -f "$HOME/.bashrc" ];
    . "$HOME/.bashrc";
fi

# Name of the Machine
export machine_name="machine_name"

# VIM export
export VISUAL="vim"

# File locations
export bashrc="$HOME/.bashrc"
export bashpr="$HOME/.bash_profile"
export vimrc="$HOME/.vim/vimrc"

# Useful aliases and shortcuts
alias ls='ls -lh --color=auto'
alias svim="sudo vim"
alias p3='python3'
alias q='exit'

# Easy access/edit config files
alias vimrc="vim $vimrc"
alias bashrc="vim $bashrc"
alias bashpr="vim $bashpr"
alias loadbash="source $bashpr"

# Command Prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 6)\][\[$(tput setaf 5)\]\u\[$(tput setaf 6)\]@\[$(tput setaf 5)\]$machine_name \[$(tput setaf 3)\]\w\[$(tput setaf 6)\]]\n> \[$(tput sgr0)\]"

# Make sure path includes my local /bin directory
export PATH=/home/aaatipamula/.local/bin:$PATH

# Change directory by just typing in name
shopt -s autocd

# Use Vi bindings to move around and edit in terminal
set -o vi

