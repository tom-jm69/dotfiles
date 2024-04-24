#!/bin/bash

echo "External display is connected" >> /tmp/xrandr.log
displays=$(xrandr | grep " connected" | awk '{print $1}')
# check if the external display is connected
xset r rate 250 80
if [ $(echo $displays | wc -w) -eq 2 ]; then
    internal_display=$(echo $displays | awk '{print $1}')
    external_display=$(echo $displays | awk '{print $2}')
    xrandr --output "$external_display" --auto --primary --left-of "$internal_display"
    xrandr --output "$internal_display" --off
else
    internal_display=$(echo $displays | awk '{print $1}')
    xrandr --output "$internal_display" --auto --primary
fi
