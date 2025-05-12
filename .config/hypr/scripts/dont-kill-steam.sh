#!/bin/bash

# Get active window's class
window_class=$(hyprctl activewindow -j | jq -r '.class')

# Check if it's a Steam game
if [[ "$window_class" == steam_app_* ]]; then
    # Do nothing if it's a Steam game
    exit 0
else
    # Kill the active window
    hyprctl dispatch killactive ""
fi
