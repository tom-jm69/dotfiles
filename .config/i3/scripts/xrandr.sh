#!/bin/bash

echo "External display is connected" >> /tmp/xrandr.log
displays=$(xrandr | grep " connected" | awk '{print $1}')
eth_connected=$(ip link show | grep "state UP" | grep -c "enx")
wlan_connected=$(ip link show | grep "state UP" | grep -c "wlp0s")
# check if the external display is connected
xset r rate 250 80
echo $displays
if [ $(echo "$displays" | wc -w) -eq 1 ]; then
    internal_display=$(echo $displays | awk '{print $1}')
    external_display=$(echo $displays | awk '{print $2}')
    second_external_display=$(echo $displays | awk '{print $3}')
    xrandr --output "$external_display" --auto --primary --left-of "$internal_display"
    xrandr --output "$internal_display" --off
    xrandr --output "$second_external_display" --auto --right-of "$external_display"
    notify-send "External display is connected" --icon=dialog-information
elif [ $(echo "$displays" | wc -w) -eq 2 ]; then
    internal_display=$(echo $displays | awk '{print $1}')
    external_display=$(echo $displays | awk '{print $2}')
    second_external_display=$(echo $displays | awk '{print $3}')
    xrandr --output "$external_display" --auto --primary --left-of "$internal_display"
    xrandr --output "$internal_display" --auto --right-of "$external_display"
    xrandr --output "$second_external_display" --auto --right-of "$external_display"
    notify-send "External display is connected" --icon=dialog-information
elif [ $(echo "$displays" | wc -w) -eq 3 ]; then
    internal_display=$(echo $displays | awk '{print $1}')
    external_display=$(echo $displays | awk '{print $2}')
    second_external_display=$(echo $displays | awk '{print $3}')
    third_external_display=$(echo $displays | awk '{print $4}')
    xrandr --output "$external_display" --auto --primary --left-of "$internal_display"
    xrandr --output "$second_external_display" --auto --right-of "$external_display"
    xrandr --output "$third_external_display" --auto --right-of "$second_external_display"
    notify-send "External display is connected" --icon=dialog-information
else
    internal_display=$(echo $displays | awk '{print $1}')
    xrandr --output "$internal_display" --auto --primary
    notify-send "External display is disconnected" --icon=dialog-information
fi

if [ "$eth_connected" -eq 1 ]; then
    notify-send "Ethernet is connected" --icon=dialog-information
    nmcli radio wifi off
fi
