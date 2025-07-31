#!/usr/bin/env bash

set -euo pipefail

# Customize your theme path
dir="$HOME/.config/rofi/launchers/type-1"
theme='style-5'
export GTK_THEME=Adwaita:dark

# Optional: Unlock vault if locked
if ! rbw unlocked >/dev/null; then
    rbw unlock || {
        notify-send "Bitwarden" "Failed to unlock vault"
        exit 1
    }
fi

# Fetch all entries and search with wofi
entries=$(rbw list | jq -r '.name' | sort)

# Show wofi prompt
selected=$(printf '%s\n' "$entries" | wofi --dmenu --theme "$dir/$theme.rasi" -p "Search Bitwarden")

# If nothing selected, exit
[[ -z "$selected" ]] && exit

# Get password and copy to clipboard
rbw get "$selected" | wl-copy

# Notify user
notify-send "Bitwarden" "Password for '$selected' copied to clipboard"
