
# Name of the Machine
export machine_name="machine_name"

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

cd_git() {
    if [ -d .git ]
    then
        printf "Sync with remote?: "
        read input

        case $input in
            y)
                git pull origin master
                ;;

            yes)
                git pull origin master
                ;;

            *)
                echo "Skipping..."
        esac
    fi
}

custom_cd() { 
    cd $1; cd_git
}

sync_dotfiles() {
    if [ -d $dotfiles ]
    then
        cd $dotfiles
        git pull origin master > /dev/null/ 2>&1
    fi
    cd
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
alias readme='readme.sh'
alias cl='clear'
alias size="du -sh"
alias cdg='custom_cd'

# Machine specific config
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Uncomment below if python 3.10 isn't default
#alias python3='python3.10'
#alias p3='python3.10'

# Easy access/edit config files
alias vimrc="vim $vimrc"
alias bashrc="vim $bashrc"
alias bashpr="vim $bashpr"
alias gitconf="vim $gitconf"
alias bashal="vim $bashal"
alias loadbash="source $bashrc"
alias dotfiles="cd $dotfiles"

# Command Prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]$machine_name \[$(tput setaf 3)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\]\$(parse_git_branch)\[$(tput setaf 6)\]\n-> \[$(tput sgr0)\]"

sync_dotfiles

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
