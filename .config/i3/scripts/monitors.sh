#!/bin/bash

LAPTOP_SCREEN="eDP"
ALL_CONNECTED=$(xrandr | grep -v "disconnected" | grep "connected")
EXCEPT_LAPTOP_CONNECTED=$(echo "$ALL_CONNECTED" | grep -v "$LAPTOP_SCREEN")
NUM_EXTERNAL_MONITORS=$(echo "$EXCEPT_LAPTOP_CONNECTED" | wc -l)
LAPTOP_SCREEN_IS_CONNECTED=$(echo "$ALL_CONNECTED" | grep "$LAPTOP_SCREEN")

if [ "$NUM_EXTERNAL_MONITORS" -gt 1 ]; then
    # More then one external monitor is connected
    while IFS= read -r monitor; do
        MONITOR=$(echo "$monitor" | awk '{print $1}')
        xrandr --output "$MONITOR" --auto
    done <<< "$EXCEPT_LAPTOP_CONNECTED"
    xrandr --output "$(echo "$LAPTOP_SCREEN_IS_CONNECTED" | awk '{print $1}')" --off
elif [ "$NUM_EXTERNAL_MONITORS" -lt 2 ]; then
    xrandr --output "$EXCEPT_LAPTOP_CONNECTED" --auto
    xrandr --output "$LAPTOP_SCREEN" --auto
fi
