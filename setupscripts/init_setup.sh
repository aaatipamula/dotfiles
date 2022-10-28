#!/bin/sh

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
            # Add repo for neovim and python 3.10
            sudo add-apt-repository ppa:neovim-ppa/stable

            # update and upgrade
            sudo $1 update && sudo $1 upgrade

            # install commonly used programs
            sudo $1 install htop vim tmux docker python3 

            # Install nvm for node version control etc.
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

            # Load nvm without restarting shell/terminal
            export NVM_DIR="/home/runner/.nvm"
            [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
            [ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

            # Install node 14.10.0
            nvm install 14.10.0
            ;;

        *)
            # update and upgrade
            sudo $1 update && sudo $1 upgrade

            # install commonly used programs
            sudo $1 install htop vim tmux docker python3 nodejs
            ;;
    esac

}

get_package_manager()
{

    case $1 in 

        ubuntu) 
            package_manager = "apt"
            ;;
        fedora)
            package_manager = "dnf"
            ;;
        mac)
            package_manager = "brew"
            ;;
        *)
            echo "Could not match package manager."
            exit 1
    esac

}

setup_shell()
{

    cat ./config_files/.bash_profile >> "$HOME/.bashrc"

    cp ./config_files/.gitconfig "$HOME"

}

setup_vim()
{

	# Install vim-plug
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
}

if [ $0 != "./setupscripts/init_setup.sh" ] 
then 
    echo "Please run script in root directory"
    exit 1
fi

setup_shell

package_manager=""

case $1 in
    -s)
        get_package_manager $2
        install_apps $package_manager
        ;;

    -v)
        setup_vim
        ;;

    -sv)
        get_package_manager $2
        install_apps $package_manager
        setup_vim
        ;;

    *)
        exit 1
        ;;
esac
