#!/bin/sh

if [ -f ./README.md ]
then
    vim ./README.md
else
    echo "./README.md does not exist!"
    exit 1
fi
