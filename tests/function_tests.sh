#!/bin/sh

if [ -f ./setupscripts/setup_functions.sh ]
then
    . ./setupscripts/setup_functions.sh
fi

check()
{
    if [ $1 -ne "$2" ]
    then
        echo "Failed."
        exit 1
    else
        echo "Pass."
        return 0
    fi
}

# Try install
install_apps apt

# Check package manager validator
validate_package_manager apt
check $? "0"

validate_package_manager dnf
check $? "0"

validate_package_manager brew
check $? "0"

validate_package_manager fail
check $? "1"

# Check dracula vim install
dracula_vim_install
check $? "0"

dracula_vim_install
check $? "2"


# Check bash setup
setup_bash
check $? "0"

setup_bash
check $? "2"


# Check git setup
setup_git
check $? "0"

setup_git
check $? "2"


# Check vim basic setup
vim_basic_setup
check $? "0"

vim_basic_setup
check $? "2"


# Check vim plug install
setup_vim_plug
check $? "0"

setup_vim_plug
check $? "2"


# Check vim plug install
setup_vim_plug
check $? "0"

setup_vim_plug
check $? "2"


# Check vim plug install
setup_vimrc
check $? "0"

setup_vimrc
check $? "2"
