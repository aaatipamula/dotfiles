#!/bin/bash

ASCII_DIR="$XDG_CONFIG_HOME/fastfetch/ascii"

if [[  ! -d $ASCII_DIR ]]; then
  exit 0
fi

ls $ASCII_DIR | sort -R | tail -$N | while read file; do
  cmd=$(command -v fastfetch) # Check if fastfetch is executable

  if [[ -z cmd ]]; then
    cat "$ASCII_DIR/$file" # Just display the pokemon
  else
    cat "$ASCII_DIR/$file" | fastfetch --file-raw -
  fi
  exit 0
done

