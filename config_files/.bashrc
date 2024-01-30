# VIM export
export VISUAL="vim"

# File locations
export bashrc="$HOME/.bashrc"
export bashpr="$HOME/.bash_profile"
export vimrc="$HOME/.vim/vimrc"
export gitconf="$HOME/.gitconfig"
export bashal="$HOME/.bash_aliases"
export dotfiles="$HOME/dotfiles"

parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

custom_cd() { 
  cd $1; git pull origin master
}

sync_dotfiles() {
  curr_dir=$(pwd)

  if [[ ! -d $dotfiles ]]
  then
    echo "No dotfiles present"
    return 1
  fi

  cd $dotfiles

  if [[ -z "$(git status --porcelain)" ]]
  then
    git pull origin master
  else
    git status -s
    read -p "Modified or untracked files found, commit them? [y/n]: " commit
  fi

  if [[ $commit = 'y' || $commit = "yes" ]]
  then
    git stash
    git pull origin master
    git stash apply
    git add .
    git commit -m "Automatic sync $(date)"
    git push origin master
  elif [[ $commit = 'n' || $commit = "no" ]]
  then
    echo "Skipping commit"
    git stash
    git pull origin master
    git stash apply
  else
    echo "Invalid option, please commit files or skip."
    cd $cur_dir
    return 1
  fi

  rm $bashrc
  ln -s $dotfiles/config_files/.bashrc ~
 
  if cmp -s $vimrc $dotfiles/vim/vimrc
  then
    rm $vimrc
    ln -s $dotfiles/vim/basic.vim ~/.vim/vimrc
  else
    rm $vimrc
    ln -s $dotfiles/vim/vimrc ~/.vim/
  fi

  source ~/.bashrc
  cd $cur_dir
}

check_readme() {
  if [[ -f ./README.md ]]
  then
    $VISUAL ./README.md
  else
    echo "./README.md does not exist!"
    return 1
  fi
}

# Useful aliases and shortcuts
alias ls='ls -lh --color=auto'
alias l.='ls -d .*'         # Only hidden directory
alias ll='ls -rt'           # Organize by date modified
alias ld='ls -Ud */'        # Only directories
alias la='ls -a'            # Everything including hidden files
alias svim="sudo vim"
alias p3='python3'
alias q='exit'
alias hist='history'
alias mkdirs='mkdir -p'
alias readme='check_readme'
alias cl='clear'
alias size="du -sh"
alias cdg='custom_cd'
alias sync='sync_dotfiles'
alias gd='git diff'
alias gs='git status'
alias gl='git log'
alias httpserve="python3 -m http.server 8000"
alias qc="quick_compile_c"
alias qcp="quick_compile_cpp"

# Easy access/edit config files
alias vimrc="vim $vimrc"
alias bashrc="vim $bashrc"
alias bashpr="vim $bashpr"
alias gitconf="vim $gitconf"
alias bashal="vim $bashal"
alias loadbash="source $bashrc"
alias dotfiles="cd $dotfiles"

# Machine specific config
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ $machine_name ]; then
  NAME=$machine_name
else
  NAME="\h"
fi

# Command Prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]$NAME \[$(tput setaf 3)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\]\$(parse_git_branch)\[$(tput setaf 6)\]\n-> \[$(tput sgr0)\]"

# Make sure path includes my local bin directory
export PATH=/home/aaatipamula/.local/bin:$PATH

# Change directory by just typing in name
shopt -s autocd

# Use Vi bindings to move around and edit in terminal
set -o vi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

