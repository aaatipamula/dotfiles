#!/bin/sh

dotfiles=$HOME/dotfiles

# check for dotfiles directory
if [ ! -d $dotfiles ]
then
  # check for github workspace
  if [ -d $GITHUB_WORKSPACE ]
  then
    dotfiles=$GITHUB_WORKSPACE
  else
    echo "Dotfiles not found exiting setup"
    exit 1
  fi
fi

# Install commonly used apps
install_apps()
{

  if [ "$1" = "apt" ]
  then
    sudo add-apt-repository ppa:neovim-ppa/stable
  fi

  # update and upgrade
  sudo $1 update && sudo $1 upgrade

  # check for errors updating package manager
  if [ $? -ne "0" ]
  then
    echo "Something went wrong updating and upgrading the package manager."
    echo "Please run: "
    printf "\n\tsudo $1 update && sudo $1 upgrade"
  fi

  # install commonly used programs
  sudo $1 install htop vim tmux docker python3 curl

  # check for errors installing programs
  if [ $? -ne "0" ]
  then
    echo "Something went wrong installing programs."
    echo "Please run: "
    printf "\n\tsudo $1 install htop vim tmux docker python3 curl"
  fi

  # Install nvm for node version control etc.
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

  # check for nvm install errors
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
  echo "Installing Dracula Vim."

  # check if proper directory exists
  # make it if not
  # check for dracula install
  if ! [ -d $HOME/.vim/pack/themes/start ]
  then
    mkdir -p $HOME/.vim/pack/themes/start
    git clone https://github.com/dracula/vim.git $HOME/.vim/pack/themes/start/dracula
    return 0

  else
    if [ -d $HOME/.vim/pack/themes/start/dracula ]
    then
      echo "Dracula Vim already installed"
      return 2

    else
      git clone https://github.com/dracula/vim.git $HOME/.vim/pack/themes/start/dracula
      return 0
    fi
  fi
}

# Make local bin folder and link bashrc
setup_bash()
{
  echo "Setting up bash."

  for dir in $HOME/.local/bin $HOME/.backups $HOME/.config
  do
    if ! [ -d $dir ]
    then
      mkdir -p $dir
    else
      echo "$dir already exists!"
    fi
  done

  if [ -f $HOME/.bashrc ]
  then
    if cmp -s $HOME/.bashrc $dotfiles/config_files/.bashrc
    then
      echo "Bash already setup."
      return 2
    else
      rm $HOME/.bashrc
    fi
  fi

  ln -s $dotfiles/config_files/.bashrc $HOME
  return 0
    

  if [ ! -f $HOME/.bash_aliases ]
  then 
    echo "export machine_name=\"machine_name\"" > $HOME/.bash_aliases
  fi
}

# Link gitconfig file
setup_git()
{
  echo "Setting up git."

  if [ -f $HOME/.gitconfig ]
  then

    if cmp -s $HOME/.gitconfig $dotfiles/config_files/.gitconfig
    then
      echo "Git already setup."
      return 2
    else
      rm $HOME/.gitconfig
    fi

  fi

  ln -s $dotfiles/config_files/.gitconfig $HOME
  return 0
}

# Make vim directories and copy over vimrc
vim_basic_setup()
{
  echo "Installing basic vimrc."

  if ! [ -d $HOME/.vim ]
  then
    mkdir $HOME/.vim
  fi

  if [ -f $HOME/.vim/vimrc ]
  then

    if cmp -s  $HOME/.vim/vimrc $dotfiles/vim/basic.vim
    then
      echo "Basic Vim already setup."
      return 2
    else
      rm $HOME/.vim/vimrc
    fi
  fi

  ln -s $dotfiles/vim/basic.vim $HOME/.vim/vimrc
  return 0
}

# Install vim-plug
setup_vim_plug()
{
  echo "Installing vim-plug."

  if ! [ -f $HOME/.vim/autoload/plug.vim ]
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
setup_vimrc()
{
  echo "Setting up vimrc."

  # Remove dracula theme
  if [ -d $HOME/.vim/pack/themes/start/dracula ]
  then
      rm -rf $HOME/.vim/pack/themes/start/dracula
  fi

  # Make vim directory if not exists
  if ! [ -d $HOME/.vim ]
  then
      mkdir $HOME/.vim
  fi

  # Link vimrc
  if [ -f $HOME/.vim/vimrc ]
  then

    if cmp -s  $HOME/.vim/vimrc $dotfiles/vim/vimrc
    then
      echo "Vim already setup."
      return 2
    else
      rm $HOME/.vim/vimrc
    fi
  fi

  ln -s $dotfiles/vim/vimrc $HOME/.vim/
  return 0
}

# Set up my neovim config
setup_nvim()
{
  if [ -d $HOME/.config/nvim/ ]
  then
    echo "Making directory $HOME/.config/nvim"
    mkdir $HOME/.config/nvim
  fi

  if [ -f $HOME/.config/nvim/init.lua ]
  then
    echo "WARNING nvim config already exists, backing up config to $HOME/.backups/nvim"
    cp -rf $HOME/.config/nvim $HOME/.backups/
  fi

  echo "Removing previous nvim config"
  rm -rf $HOME/.config/nvim
  rm -rf $HOME/.local/share/nvim

  echo "Installing nvim config"

  cp -r $dotfiles/nvim $HOME/.config/

  if [ $? -ne "0" ]
  then
    return $?
  fi

  return 0
}

help_command()
{
  echo "Script to help setup Linux machines.\n"

  echo "Use:"
  echo "  setup preset [PRESETS]"
  echo "  setup [INDEPENDENT FUNCS]"
  echo "  setup help -- This page\n"

  echo "[PRESETS]"
  echo "  - main: Configures bash, git and full functionality vim, installs all common applications."
  echo "  - server: Configure bash, git, basic vim setup, and installs docker"
  echo "  - bare: Configure bash, git, basic vim\n"

  echo "[INDEPENDENT FUNCS]"
  echo "  - apps <package-manager>: Installs commonly used apps, requires package manager specification"
  echo "  - bash: Configure bash with bashrc"
  echo "  - git: Configure git with global gitconfig"
  echo "  - vim: Configure vim with full vimrc"
  echo "  - vim-plug: Install vim-plug for plugins"
  echo "  - dracula-vim: Installs basic dracula theme for vim"
  echo "  - vimb: Configure vimrc with basic bindings"
  echo "  - nvim: Install and setup nvchad for neovim\n"
}

