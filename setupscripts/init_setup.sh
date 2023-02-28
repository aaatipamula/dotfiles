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

            # update and upgrade
            sudo $1 update && sudo $1 upgrade

            # install commonly used programs
            sudo $1 install htop vim tmux docker python3 curl

            # Install nvm for node version control etc.
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
            ;;

        *)
            # update and upgrade
            sudo $1 update && sudo $1 upgrade

            # install commonly used programs
            sudo $1 install htop vim tmux docker python3 curl

            # Install nvm for node version control etc.
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
            ;;
    esac

}

# Valid package managers
get_package_manager()
{

    case $1 in

        ubuntu)
            package_manager="apt"
            ;;
        fedora)
            package_manager="dnf"
            ;;
        mac)
            package_manager="brew"
            ;;
        *)
            return 1
    esac

}

setup_shell()
{
    echo "Setting up Bash."

    # Make and remove files/directories
    if  [ ! -d ~/.local/bin ]
    then
        mkdir -p ~/.local/bin
    fi

    if [ -f ~/.bashrc ]
    then
        rm ~/.bashrc
    fi

    if [ ! -f ~/.bash_aliases ]
    then 
        echo "machine_name=\"name\"" > ~/.bash_aliases
    fi


    # Link bashrc and gitconfig and copy scripts
    ln ./config_files/.bashrc ~/.bashrc

    ln ./config_files/.gitconfig ~
    cp ./config_files/readme.sh ~/.local/bin

    echo "Finished setting up Bash!"

    # Setup basic vim config
    if [ ! -d ~/.vim ]
    then
        mkdir ~/.vim
    fi

    cp ./vim/basic.vim ~/.vim/vimrc

    ./dracula_install.sh

}

setup_vim()
{

    echo "Installing vim-plug."

    # Install vim-plug
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Check if vim-plug install failed
    if [ $? -eq "1" ]
    then
        echo "Failed to install Vim-Plug."
        echo "Please enter the following lines into your terminal: "
        echo "curl -fLo \\$HOME/.vim/autoload/plug.vim --create-dirs \\"
        echo "    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        exit 1
    fi

    echo "Setting up vimrc"

    # Remove dracula theme
    if [ -d ~/.vim/pack/themes/start/dracula ]
    then
        rm -rf ~/.vim/pack/themes/start/dracula
    fi

    # Link vimrc
    rm ~/.vim/vimrc
    ln ./vim/vimrc ~/.vim/vimrc
}

if [ $0 != ./setupscripts/init_setup.sh ]
then
    echo "Please run script in root directory"
    exit 1
fi

setup_shell

package_manager=""

case $1 in
    -s)
        get_package_manager $2

        if [ $? -eq "1" ]
        then
            echo "Could not match package manager skipping application install..."
            exit 1

        else
            install_apps $package_manager
        fi

        ;;

    -v)
        setup_vim
        ;;

    -sv)
        get_package_manager $2

        if [ $? -eq "1" ]
        then
            echo "Could not match package manager skipping application install..."
            exit 1

        else
            install_apps $package_manager
        fi

        setup_vim
        ;;

    *)
        echo "No valid options were selected skipping application installs..."
        ;;
esac

echo "Setup done! Run 'source ~/.bashrc' to load shell configuration."
