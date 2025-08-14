#!/bin/bash

# Print all terminal colors with their codes
echo -e "\nTerminal Colors:"
echo -e "----------------\n"

# Standard colors (0-7)
for i in {0..7}; do
    echo -en "\e[48;5;${i}m  \e[0m "
done
echo -e "\n"

# Bright colors (8-15)
for i in {8..15}; do
    echo -en "\e[48;5;${i}m  \e[0m "
done
echo -e "\n"

# 256-color mode samples (optional)
echo -e "\n256-color Mode Samples:"
echo -e "-----------------------\n"
for i in {16..231..36}; do
    for j in {0..35}; do
        code=$((i+j))
        echo -en "\e[48;5;${code}m  \e[0m"
    done
    echo
done

echo -e "\nGrayscale:"
echo -e "----------\n"
for i in {232..255}; do
    echo -en "\e[48;5;${i}m  \e[0m"
done
echo -e "\n"

