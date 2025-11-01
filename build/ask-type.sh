#!/usr/bin/env bash

echo "Do you want to set up dotfiles for:"
echo "1) Work"
echo "2) Home"
read -rp "Enter your choice (1 or 2): " choice

MACHINE_TYPE=""

case "$choice" in
    1)
        MACHINE_TYPE="work"
        ;;
    2)
        MACHINE_TYPE="home"
        ;;
    *)
        echo "Invalid choice. Please run the script again and select 1 or 2."
        exit 1
        ;;
esac

# Confirmation output
echo "You selected: $MACHINE_TYPE"
export MACHINE_TYPE

