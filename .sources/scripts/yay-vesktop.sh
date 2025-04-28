#!/bin/bash

vesktop_path="/usr/share/applications/vesktop.desktop"
discord_path="/usr/share/applications/discord.desktop"

if ! [ -f "$vesktop_path" ]; then
    echo "Error: vesktop is not installed or has a different .desktop file location."
    exit 1
fi


if ! [ -f "$discord_path" ]; then
    echo "Error: discord is not installed or has a different .desktop file location."
    exit 1
fi

if ! command -v /usr/bin/yay >/dev/null; then
    echo "Error: yay is not installed."
    exit 1
fi

if yay "$@"; then
    sudo sed -i 's/Icon=vesktop/Icon=discord/' "$vesktop_path"
fi
