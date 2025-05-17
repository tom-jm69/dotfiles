#!/usr/bin/env bash

INSTALLED=("solaar" "kaki" "waybar" "wl-paste" "cliphist" "gsettings" "dex" "dunst" "alacritty" "flameshot" "wofi" "dmenu" "rofi" "zsh" "adw-gtk-theme" "adw-gtk3" "adwaita-fonts" "alsa-plugins" "ansible" "ansible-core" "binwalk" "bitwarden" "spotify" "docker" "ffmpeg" "firefox" "git")

missing=()

for program in "${INSTALLED[@]}"
do
    if ! command -v "$program" &> /dev/null; then
        missing+=("$program")
        notify-send -w "Missing program" "Program '$program' is not installed or not in PATH."
    fi
done

if [ ${#missing[@]} -eq 0 ]; then
    exit 0
fi
