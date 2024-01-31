#!/bin/sh

# Import module
if [ -f ./setupscripts/setup_functions.sh ]
then
  ./setupscripts/setup_functions.sh "gh_test"
  . ./setupscripts/setup_functions.sh
fi

# Check return status
check_return()
{
  if [ $1 -ne "$2" ]
  then
    echo "Failed."
    echo "Returned unexpected code of $1."
    exit 1
  else
    echo "Pass."
    return 0
  fi
}

check_dir()
{
  if [ ! -d $1 ]
  then
    echo "Failed"
    echo "Directory \"$1\" does not exist."
    exit 1
  else
    echo "Pass."
    return 0
  fi
}

# Special check for nvchad install 
check_return_dir()
{
  check_dir $1
  check_return $2 $3
}

# Try install
install_apps apt

# Check package manager validator
validate_package_manager apt
check_return $? "0"

validate_package_manager dnf
check_return $? "0"

validate_package_manager brew
check_return $? "0"

validate_package_manager fail
check_return $? "1"


# Check dracula vim install
dracula_vim_install
check_return $? "0"

dracula_vim_install
check_return $? "2"


# Check bash setup
setup_bash
check_return $? "0"

setup_bash
check_return $? "2"


# Check git setup
setup_git
check_return $? "0"

setup_git
check_return $? "2"


# Check vim basic setup
vim_basic_setup
check_return $? "0"

vim_basic_setup
check_return $? "2"


# Check vim plug install
# Deprecated function
setup_vim_plug
check_return $? "0"

setup_vim_plug
check_return $? "2"


# Check vimrc setup
# Deprecated function
setup_vimrc
check_return $? "0"

setup_vimrc
check_return $? "2"


mkdir -p ~/.config/nvim/ # Make any missing directories
touch ~/.config/nvim/init.lua   # Backup indicator for nvchad install

# Check nvchad install
install_nvchad
check_return_dir ~/.backups/nvim $? "0"

install_nvchad
check_return $? "2"


# Check nvchad setup
setup_nvchad
check_return $? "0"

setup_nvchad
check_return_dir ~/.backups/nvchad $? "2"

