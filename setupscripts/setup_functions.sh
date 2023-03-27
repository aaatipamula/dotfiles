#!/bin/sh

# Install commonly used apps
install_apps()
{
    # Check if root
    if [ $(whoami) != "root" ]
    then
        echo Please run this script as root!
        exit 1
    fi

    if [ $1 = "apt" ]
    then
        sudo add-apt-repository ppa:neovim-ppa/stable
    fi

    # update and upgrade
    sudo $1 update && sudo $1 upgrade

    if [ $? -ne "0" ]
    then
        echo "Something went wrong updating and upgrading the package manager."
        echo "Please run: "
        printf "\n\tsudo $1 update && sudo $1 upgrade"
    fi

    # install commonly used programs
    sudo $1 install htop vim tmux docker python3 curl

    if [ $? -ne "0" ]
    then
        echo "Something went wrong installing programs."
        echo "Please run: "
        printf "\n\tsudo $1 install htop vim tmux docker python3 curl"
    fi

    # Install nvm for node version control etc.
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

    if [ $? -ne "0" ]
    then
        echo "Something went wrong installing nvm."
        echo "Please run: "
        printf "\n\tcurl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
    fi
}

# Valid package managers
validate_package_manager()
{
    case $1 in
        apt)
            return 0
            ;;
        dnf)
            return 0
            ;;
        brew)
            return 0
            ;;
        *)
            return 1
    esac
}

# Dracula Install
dracula_vim_install()
{
    if [ ! -d ~/.vim/pack/themes/start ]
    then
        mkdir -p ~/.vim/pack/themes/start
        cd ~/.vim/pack/themes/start
        git clone https://github.com/dracula/vim.git dracula
        return 0
    else
        if [ -d ~/.vim/pack/themes/start/dracula ]
        then
            echo "Dracula Vim already installed"
            return 2
        else
            cd ~/.vim/pack/themes/start
            git clone https://github.com/dracula/vim.git dracula
            return 0
        fi
    fi
}

# Make local bin folder and link bashrc
setup_bash()
{
    if  [ ! -d ~/.local/bin ]
    then
        mkdir -p ~/.local/bin
    fi

    if [ -f ~/.bashrc ]
    then

        if cmp -s ~/.bashrc ./config_files/.bashrc
        then
            echo "Bash already setup."
            return 2
        else
            rm ~/.bashrc
            ln ./config_files/.bashrc ~
            return 0
        fi

    else
        ln ./config_files/.bashrc ~
        return 0
    fi

    if [ ! -f ~/.bash_aliases ]
    then 
        echo "machine_name=\"name\"" > ~/.bash_aliases
    fi
}

# Link gitconfig file
setup_git()
{
    if [ -f ~/.gitconfig ]
    then

        if cmp -s  ~/.gitconfig ./config_files/.gitconfig
        then
            echo "Git already setup."
            return 2
        else
            rm ~/.gitconfig
            ln ./config_files/.gitconfig ~
            return 0
        fi

    else
        ln ./config_files/.gitconfig ~
        return 0
    fi
}

# Make vim directories and copy over vimrc
vim_basic_setup()
{
    if [ ! -d ~/.vim ]
    then
        mkdir ~/.vim
    fi

    if [ -f ~/.vim/vimrc ]
    then

        if cmp -s  ~/.vim/vimrc ./vim/basic.vim
        then
            echo "Basic Vim already setup."
            return 2
        else
            rm ~/.vim/vimrc
            cp ./vim/basic.vim ~/.vim/vimrc
            return 0
        fi

    else
        cp ./vim/basic.vim ~/.vim/vimrc
        return 0
    fi
}

# Install vim-plug
setup_vim_plug()
{
    echo "Installing vim-plug."

    if [ ! -f ~/.vim/autoload/plug.vim ]
    then
        # Install vim-plug
        curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        # Check if vim-plug install failed
        if [ $? -ne "0" ]
        then
            echo "Failed to install Vim-Plug."
            echo "Please enter the following lines into your terminal: "
            echo "curl -fLo \\$HOME/.vim/autoload/plug.vim --create-dirs \\"
            echo "    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
            return 1
        fi

        return 0

    else
        echo "Vim-Plug already installed."
        return 2
    fi
}

# Link vimrc
setup_vimrc(){
    # Remove dracula theme
    if [ -d ~/.vim/pack/themes/start/dracula ]
    then
        rm -rf ~/.vim/pack/themes/start/dracula
    fi

    # Link vimrc
    if [ -f ~/.vim/vimrc ]
    then

        if cmp -s  ~/.vim/vimrc ./vim/vimrc
        then
            echo "Vim already setup."
            return 2
        else
            rm ~/.vim/vimrc
            ln ./vim/vimrc ~/.vim/vimrc
            return 0
        fi

    else
        ln ./vim/vimrc ~/.vim/vimrc
        return 0
    fi
}

