#!/bin/bash

# Get active window's class and lowercase it
window_class=$(hyprctl activewindow -j | jq -r '.class' | tr '[:upper:]' '[:lower:]')

dont_kill=("minecraft" "cs2" "steam")

# Check if the window class is in the dont_kill array
for app in "${dont_kill[@]}"; do
    if [[ "$window_class" == "$app"* ]]; then
        # Do nothing if it's in the dont_kill list
        exit 0
    fi
done

# Kill the active window if it's not in the dont_kill list
hyprctl dispatch killactive ""
