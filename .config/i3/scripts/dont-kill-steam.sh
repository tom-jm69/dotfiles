#!/bin/bash

# Function for X11
handle_x11() {
    focused_win_id=$(xdotool getwindowfocus)
    wm_class=$(xprop -id "$focused_win_id" WM_CLASS 2>/dev/null)
    if echo "$wm_class" | grep -q "steam_app_"; then
        exit 0
    else
        i3-msg kill
    fi
}

# Function for Wayland (Hyprland)
handle_wayland_hyprland() {
    app_class=$(hyprctl activewindow -j | jq -r '.class')

    if [[ "$app_class" == steam_app_* ]]; then
        exit 0
    else
        hyprctl dispatch killactive ""
    fi
}

# Detect session type and compositor
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    handle_x11
elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if pgrep -x Hyprland > /dev/null; then
        handle_wayland_hyprland
    else
        echo "Wayland detected, but unsupported compositor (only Hyprland is supported in this script)"
        exit 1
    fi
else
    echo "Unknown session type: $XDG_SESSION_TYPE"
    exit 1
fi
