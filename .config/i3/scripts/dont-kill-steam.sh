#!/bin/bash
if xprop -id "$(xdotool getwindowfocus)" WM_CLASS | grep -q "steam_app_"; then
    # Do nothing if it's a Steam game
    exit 0
else
    # Kill the window if it's not a Steam game
    i3-msg kill
fi
