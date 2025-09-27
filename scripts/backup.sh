#!/bin/bash

echo "Creating backup at /backup.tar.gz"

sudo tar czf /backup.tar.gz \
    --exclude=/backup.tar.gz \
    --exclude=/dev \
    --exclude=/mnt \
    --exclude=/proc \
    --exclude=/sys \
    --exclude=/tmp \
    --exclude=/media \
    --exclude=/lost+found \
    --exclude=/swapfile \
    /

