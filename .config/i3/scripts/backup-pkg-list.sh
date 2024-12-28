#!/bin/bash


# Get currently installed packages via pacman
PACKAGELIST_PACMAN=$(pacman -Q)
PACKAGE_FILE_PACMAN_NAME="pacman-pkgs.txt"
PACKAGELIST_FOREIGN=$(pacman -Qm)
PACKAGE_FILE_FOREIGN_NAME="foreign-pkgs.txt"

# Get currently installed packages via yay


# Define package list directory for the location of the txt file
PACKAGE_FILE_DIRECTORY="/home/tom/Documents/pgk-backup/"

# Create package file directory
mkdir -p "$PACKAGE_FILE_DIRECTORY"

# Create file and dump
echo "Dumping pacman package list..."
echo "$PACKAGELIST_PACMAN" > "$PACKAGE_FILE_DIRECTORY/$PACKAGE_FILE_PACMAN_NAME"
echo "Dumping foreign package list..."
echo "$PACKAGELIST_FOREIGN" > "$PACKAGE_FILE_DIRECTORY/$PACKAGE_FILE_FOREIGN_NAME"

# Changing owner to none root
echo "Changing owner and group to tom..."
chown tom:tom "$PACKAGE_FILE_DIRECTORY/$PACKAGE_FILE_FOREIGN_NAME"
chown tom:tom "$PACKAGE_FILE_DIRECTORY/$PACKAGE_FILE_PACMAN_NAME"
