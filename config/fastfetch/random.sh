#!/bin/bash

ASCII_DIR="$XDG_CONFIG_HOME/fastfetch/ascii"

if [[  ! -d $ASCII_DIR ]]; then
  exit 0
fi

ls $ASCII_DIR | sort -R | tail -$N | while read file; do
  # Something involving $file, or you can leave
  # off the while to just get the filenames
  cat "$ASCII_DIR/$file" | fastfetch --file-raw -
  exit 0
done

