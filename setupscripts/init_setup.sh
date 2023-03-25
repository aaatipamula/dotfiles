#!/bin/sh

# General purpose setup script for ubuntu and some other distros

# Valid flags:
# -s: Install apps (requires sudo access)
# -v: Install vim config with plugins

# Install commonly used apps
install_apps()
{
    # Check if root
    if [ $(whoami) != "root" ]
    then
        echo Please run this script as root!
        exit 1
    fi

    case $1 in
        apt)
            # Add repo for neovim
            sudo add-apt-repository ppa:neovim-ppa/stable
            ;;
    esac

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
            ;;
        dnf)
            ;;
        brew)
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
    fi

    cd ~/.vim/pack/themes/start
    git clone https://github.com/dracula/vim.git dracula
}

setup_shell()
{
    echo "Setting up Bash."

    # Make and remove files/directories
    if  [ ! -d ~/.local/bin ]
    then
        mkdir -p ~/.local/bin
    fi

    # Setup bashrc
    if [ -f ~/.bashrc ]
    then

        if cmp -s ~/.bashrc ./config_files/.bashc
        then
            echo "Bash already set up."
            return

        else
            rm ~/.bashrc
            ln ./config_files/.bashrc ~
        fi

    else
        ln ./config_files/.bashrc ~
    fi

    if [ ! -f ~/.bash_aliases ]
    then 
        echo "machine_name=\"name\"" > ~/.bash_aliases
    fi

    # Setup gitconfig
    if [ -f ~/.gitconfig ]
    then

        if cmp -s  ~/.gitconfig ./config_files/.gitconfig
        then
            echo "Git already set up."
            return

        else
            rm ~/.gitconfig
            ln ./config_files/.gitconfig ~

        fi

    else
        ln ./config_files/.gitconfig ~
    fi

    echo "Finished setting up Bash!"

    # Setup basic vim config
    if [ ! -d ~/.vim ]
    then
        mkdir ~/.vim
    fi

    cp ./vim/basic.vim ~/.vim/vimrc
    dracula_vim_install

}

setup_vim()
{
    echo "Installing vim-plug."

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
    fi

    echo "Setting up vimrc"

    # Remove dracula theme
    if [ -d ~/.vim/pack/themes/start/dracula ]
    then
        rm -rf ~/.vim/pack/themes/start/dracula
    fi

    # Link vimrc
    rm ~/.vim/vimrc
    ln ./vim/vimrc ~/.vim/
}

# Parent
main()
{
    # Begin script
    if [ $0 != ./setupscripts/init_setup.sh ]
    then
        echo "Please run script in root directory"
        exit 1
    fi

    setup_shell

    case $1 in
        -s)
            validate_package_manager $2

            if [ $? -eq "1" ]
            then
                echo "Could not match package manager skipping application install..."
            else
                install_apps $2
            fi
            ;;

        -v)
            setup_vim
            ;;

        -sv)
            validate_package_manager $2

            if [ $? -ne "0" ]
            then
                echo "Could not match package manager skipping application install..."
            else
                install_apps $package_manager
            fi

            setup_vim
            ;;

        *)
            echo "No valid options were selected, skipping application installs and vim setup..."
            ;;
    esac

    echo "Setup done! Run 'source ~/.bashrc' to load shell configuration."
}

# Start script
main $1 $2
