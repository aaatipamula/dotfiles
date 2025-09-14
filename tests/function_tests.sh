#!/bin/bash

set -e # fail on command fail

# Import module
if [ -f ./setupscripts/setup_functions.sh ]; then
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

# Check package manager validator
validate_package_manager apt
check_return $? "0"

validate_package_manager dnf
check_return $? "0"

validate_package_manager brew
check_return $? "0"

validate_package_manager fail
check_return $? "1"

for app in ${CONFIG_PROGRAMS[@]}; do
  eval "setup_$app"
  check_return $? "0"
done

