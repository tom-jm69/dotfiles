#!/bin/bash

# Check the OS information
if [ -f /etc/os-release ]; then
    . /etc/os-release

    if [[ "$ID" == "arch" ]]; then
        PACKAGE_COUNT=$(pacman -Q | wc -l)
        echo "<span color='#a6da95'>󰣇 $PACKAGE_COUNT</span>"
    elif [[ "$ID" == "ubuntu" ]]; then
        PACKAGE_COUNT=$(apt list --installed 2>/dev/null | wc -l)
        echo "<span color='#a6da95'> $PACKAGE_COUNT</span>"
    else
        echo "The system is not Arch Linux or Ubuntu. Detected OS: $ID"
    fi
else
    echo "Cannot determine OS: /etc/os-release file not found."
fi
