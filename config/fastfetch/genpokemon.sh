#!/bin/bash

ASCII_DIR="$XDG_CONFIG_HOME/fastfetch/ascii"

pokemon=(
  "turtwig"
  "piplup"
  "chimchar"
  "torchic"
  "mudkip"
  "treecko"
  "charmander"
  "bulbasaur"
  "squirtle"
)

read -r -p "Delete all pokemon in $ASCII_DIR? [Y/N]: " opt

if [[ "$opt" =~ [yY] ]]; then
  echo "Deleting all pokemon."
  for file in $(ls $ASCII_DIR); do
    rm "$ASCII_DIR/$file"
  done
elif [[ "$opt" =~ [nN] ]]; then
  echo "Skipping deletion of current pokemon."
else
  echo "Invalid option, exiting."
  exit 0
fi

echo "Adding the following pokemon: ${pokemon[*]}"
for pkmn in ${pokemon[@]}; do
  pokeget $pkmn --hide-name > "$ASCII_DIR/$pkmn.txt"
done
