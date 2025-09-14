#!/bin/bash

set -e

#############################
### INSTANTIATE VARIABLES ###
#############################

XDG_CONFIG_HOME="$HOME/.config"
BACKUPS_DIR="$HOME/.backups"
DOTFILES_DIR="$HOME/dotfiles"
HOME_CONFIG_DIR="$DOTFILES_DIR/config"

DEV_PROGRAMS=(
  "tmux"
  "neovim"
  "vim"
  "tree"
  "python3"
  "docker"
  "go"
  "curl"
)

CONFIG_PROGRAMS=(
  "zsh"
  "bash"
  "git"
  "vim"
  "nvim"
  "tmux"
  "hypr"
  "waybar"
  "kitty"
  "wezterm"
  "wofi"
  "electron"
  "ghostty"
  "fastfetch"
  "wsl"
)

###############
### LOGGING ###
###############

# Terminal colors
bold=$(tput bold)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
red=$(tput setaf 9)
norm=$(tput sgr0)

info()
{
  echo "[${blue}INFO${norm}]: $1"
}

warn()
{
  echo "[${yellow}WARN${norm}]: $1"
}

error()
{
  echo "[${red}ERROR${norm}]: $1"
}

#########################
### SETUP ENVIRONMENT ###
#########################

# Check for dotfiles directory in the correct place
if ! [ -d "$DOTFILES_DIR" ]
then
  # check for github workspace
  if [ -d "$GITHUB_WORKSPACE" ]
  then
    dotfiles=$GITHUB_WORKSPACE
  else
    error "Dotfiles not found in $DOTFILES_DIR"
    info  "Exiting setup"
    exit 1
  fi
fi

if ! [ -d "$BACKUPS_DIR" ]; then
  mkdir -p $BACKUPS_DIR
fi

########################
### HELPER FUNCTIONS ###
########################

# Valid package managers for install script
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

# Install commonly used apps
install_apps()
{
  # update and upgrade
  sudo $1 update && sudo $1 upgrade

  # check for errors updating package manager
  if [ $? -ne "0" ]
  then
    error "Something went wrong updating and or upgrading!"
    echo  "Please run:"
    printf "\n\tsudo $1 update && sudo $1 upgrade\n"
  fi

  # install commonly used developer programs
  sudo "$1" install ${DEV_PROGRAMS[*]}

  # check for errors installing programs
  if [ $? -ne "0" ]
  then
    error "Something went wrong installing programs."
    echo  "Please run: "
    printf "\n\tsudo $1 install ${DEV_PROGRAMS[*]}\n"
  fi
}

# Symlink a file to a location
link_file()
{
  file_name=$(basename $1)
  file_path="$2/$file_name"

  if [ -f "$file_path" ]; then
    warn "File ($file_path) already exists!"
    info "Creating a backup in $BACKUPS_DIR/$file_name and removing old."

    # info "Running: cp -rf $file_path $BACKUPS_DIR/$file_path"
    cp -f $file_path "$BACKUPS_DIR/$file_name"
    # info "Running: rm -rf $file_path"
    rm -f $file_path
  fi

  # info "Running: ln -sf $1 $file_path"
  ln -sf $1 $file_path
}

# Symlink a directory to a location
link_directory()
{
  directory_name=$(basename "$1")
  directory_path="$2/$directory_name"

  # Third positional arg indicates if the path specified by the second arg should be used
  if [ "$3" = "true" ]; then
    directory_path=$2
  fi

  if [ -d "$directory_path" ]; then
    warn "Directory ($directory_path) already exists!"
    info "Creating a backup in $BACKUPS_DIR/$directory_name and removing old."

    # info "Running: cp -rf $directory_path $BACKUPS_DIR/$directory_name"
    cp -rf $directory_path "$BACKUPS_DIR/$directory_name"
    # info "Running: rm -rf $directory_path"
    rm -rf $directory_path

    # Remove nvim plugins too
    if [ "$directory_name" = "nvim" ]; then
      rm -rf $HOME/.local/share/nvim
    fi
  fi

  # info "Running: ln -sf $1 $directory_path"
  ln -sf $1 $directory_path
  info "Created config at $directory_path"
}

# Install vim-plug
install_vim_plug()
{
  info "Installing Vim-Plug."

  if ! [ -f "$HOME/.vim/autoload/plug.vim" ]; then
    # Install vim-plug
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Check if vim-plug install failed
    if [ $? -ne "0" ]; then
      error "Failed to install Vim-Plug."
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

# Display help command for users
help_command()
{
  echo "${bold}${yellow}Script to help setup Linux machines.${norm}"

  echo   "Use:"
  echo   "  setup preset [${red}PRESETS${norm}] [${red}PACKAGE_MANAGER${norm}]"
  echo   "  setup [${red}FUNCTION${norm}]"
  printf "  setup help -- This message\n\n"

  echo   "[${red}PACKAGE_MANAGER${norm}]"
  echo   "  - brew"
  echo   "  - apt"
  printf "  - dnf\n\n"

  echo   "[${red}PRESETS${norm}]"
  echo   "  - main:  Configures all programs, installs all common applications."
  echo   "  - progs: Configures all programs."
  printf "  - bare:  Configure just bash, git, basic vim.\n\n"

  echo   "[${red}FUNCTION${norm}]"
  echo   "  - apps [${red}PACKAGE_MANAGER${norm}]"
  for app in ${CONFIG_PROGRAMS[@]}; do
    echo   "  - $app"
  done
  echo ""
}

#######################
### SETUP FUNCTIONS ###
#######################

setup_apps()
{
  info "Setting up apps."

  validate_package_manager $1

  if [ $? -ne "0" ]; then
    error "Could not match package manager skipping application install."
    sleep 2
  else
    install_apps $1
  fi

  return 0
}

setup_zsh()
{
  info "Setting up zsh."

  # Create directories I use often
  for dir in "$HOME/.local/bin" "$HOME/.backups" "$HOME/.config"; do
    if ! [ -d $dir ]; then
      mkdir -p $dir
    else
      warn "$dir already exists!"
    fi
  done

  # Link Bash config file
  link_file $HOME_CONFIG_DIR/.zshrc $HOME

  # Create a bash_aliases if not exists
  if ! [ -f "$HOME/.zsh_aliases" ]; then
    touch $HOME/.zsh_aliases
  fi

  info "Source bash zsh with: ${bold}source ~/.zshrc${norm}"

  return 0
}

setup_bash()
{
  info "Setting up bash."

  # Create directories I use often
  for dir in "$HOME/.local/bin" "$HOME/.backups" "$HOME/.config"; do
    if ! [ -d $dir ]; then
      mkdir -p $dir
    else
      warn "$dir already exists!"
    fi
  done

  # Link Bash config file
  link_file $HOME_CONFIG_DIR/.bashrc $HOME
 
  # Create a bash_aliases if not exists
  if ! [ -f "$HOME/.bash_aliases" ]; then 
    touch $HOME/.bash_aliases
  fi

  info "Source bash config with: ${bold}source ~/.bashrc${norm}"

  return 0
}

setup_git()
{
  info "Setting up git."

  # Legacy single file config
  # link_file $HOME_CONFIG_DIR/.gitconfig $HOME

  link_directory $HOME_CONFIG_DIR/git $XDG_CONFIG_HOME

  return 0
}

setup_vim()
{
  info "Setting up vimrc."

  # Make vim directory if not exists
  if ! [ -d "$HOME/.vim" ]; then
    mkdir $HOME/.vim
  fi

  # Link vim directory
  link_directory $HOME_CONFIG_DIR/.vim $HOME

  # Install Vim Plug after in order to persist it
  install_vim_plug

  return 0
}

setup_nvim()
{
  info "Installing nvim config."

  # Link nvim directory
  link_directory $HOME_CONFIG_DIR/nvim $XDG_CONFIG_HOME

  return 0
}

setup_tmux()
{
  if [ -d $HOME/.tmux/plugins/tpm ]; then
    info "TPM already installed."
  else
    info "Installing TPM."
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  fi

  info "Setting up Tmux config."

  link_directory $HOME_CONFIG_DIR/tmux $XDG_CONFIG_HOME

  return 0
}

setup_hypr()
{
  info "Setting up hypr config"

  # Link hypr directory
  link_directory $HOME_CONFIG_DIR/hypr $XDG_CONFIG_HOME

  return 0
}

setup_waybar()
{
  info "Installing waybar config"

  # Link hypr directory
  link_directory $HOME_CONFIG_DIR/waybar $XDG_CONFIG_HOME

  return 0
}

setup_kitty()
{
  info "Setting up kitty config"

  # Link hypr directory
  link_directory $HOME_CONFIG_DIR/kitty $XDG_CONFIG_HOME

  return 0
}

setup_wezterm()
{
  info "Setting up wezterm."

  # Link Git config file
  link_file $HOME_CONFIG_DIR/.wezterm.lua $HOME

  return 0
}

setup_wofi()
{
  info "Setting up kitty config"

  # Link hypr directory
  link_directory $HOME_CONFIG_DIR/wofi $XDG_CONFIG_HOME

  return 0
}

setup_electron()
{
  info "Setting up electron flags"

  # Link into both .config/electron-flags.conf and .config/Electron
  link_file $HOME_CONFIG_DIR/electron/electron-flags.conf $XDG_CONFIG_HOME
  link_directory $HOME_CONFIG_DIR/electron $XDG_CONFIG_HOME/Electron true

  return 0
}

setup_ghostty()
{
  info "Installing Ghostty config"

  link_directory $HOME_CONFIG_DIR/ghostty $XDG_CONFIG_HOME

  return 0
}

setup_fastfetch()
{
  info "Setting up fastfetch config"

  link_directory $HOME_CONFIG_DIR/fastfetch $XDG_CONFIG_HOME

  return 0
}

setup_wsl()
{
  info "Setting up WSL"

  link_file $HOME_CONFIG_DIR/wsl/wsl.conf /

  return 0
}
