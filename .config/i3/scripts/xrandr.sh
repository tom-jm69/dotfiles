#!/bin/bash

echo "External display is connected" >> /tmp/xrandr.log
displays=$(xrandr | grep " connected" | awk '{print $1}')
eth_connected=$(ip link show | grep "state UP" | grep -c "enx")
wlan_connected=$(ip link show | grep "state UP" | grep -c "wlp0s")
# check if the external display is connected
xset r rate 250 80
#if [ "$eth_connected" -eq 1 ]; then
#    nmcli radio wifi off
#else
#    nmcli radio wifi on
#fi
#
#
EXTERNAL_PRIMARY="00ffffffffffff0010acfbd04c47503006200104a53c22783a9325a9544d9e250c5054a54b008100b300d100714fa9408180d1c00101565e00a0a0a029503020350055502100001a000000ff00344e47564d4b330a2020202020000000fc0044454c4c20503237323044430a000000fd00314b1d711c010a2020202020200108020314b14f90050403020716010611121513141f023a801871382d40582c450055502100001e011d8018711c1620582c250055502100009e7e3900a080381f4030203a0055502100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b2"
EXTERNAL_LEFT="00ffffffffffff0010ac9c4157563041181e0104a53c22783eee95a3544c99260f5054a54b00714f8180a940d1c00101010101010101565e00a0a0a029503020350055502100001a000000ff0033374d475931330a2020202020000000fc0044454c4c20553237313944430a000000fd00384c1e5a19010a202020202020014602031cf14f90050403020716010611121513141f23097f0783010000023a801871382d40582c450055502100001e7e3900a080381f4030203a0055502100001a011d007251d01e206e28550055502100001ebf1600a08038134030203a0055502100001a00000000000000000000000000000000000000000000000000000012"
INTERNAL="00ffffffffffff004d101515000000000d1f0104a52215780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360050d210000018203080a070b023403020360050d210000018000000fe00445737584e814c513135364e31000000000002410332001200000a010a202000d1"

if [ $(echo "$displays" | wc -w) -eq 1 ]; then
    echo "Internal display"

elif [ $(echo "$displays" | wc -w) -eq 2 ]; then
    echo "1 External display"

elif [ $(echo "$displays" | wc -w) -eq 3 ]; then
    echo "2 External display"
else
    echo "External display"
fi
#if type "xrandr"; then
#  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar --reload example &
#  done
#else
#  polybar --reload example &
#fi
#    internal_display=$(echo $displays | awk '{print $1}')
#    external_display=$(echo $displays | awk '{print $2}')
#    second_external_display=$(echo $displays | awk '{print $3}')
#    xrandr --output "$external_display" --auto --primary --left-of "$internal_display"
#    xrandr --output "$internal_display" --off
#    xrandr --output "$second_external_display" --auto --right-of "$external_display"
#    notify-send "External display is connected" --icon=dialog-information
#elif [ $(echo "$displays" | wc -w) -eq 2 ]; then
#    internal_display=$(echo $displays | awk '{print $1}')
#    external_display=$(echo $displays | awk '{print $2}')
#    second_external_display=$(echo $displays | awk '{print $3}')
#    xrandr --output "$external_display" --auto --primary --left-of "$internal_display"
#    xrandr --output "$internal_display" --auto --right-of "$external_display"
#    xrandr --output "$second_external_display" --auto --right-of "$external_display"
#    notify-send "External display is connected" --icon=dialog-information
#elif [ $(echo "$displays" | wc -w) -eq 3 ]; then
#    internal_display=$(echo $displays | awk '{print $1}')
#    external_display=$(echo $displays | awk '{print $2}')
#    second_external_display=$(echo $displays | awk '{print $3}')
#    third_external_display=$(echo $displays | awk '{print $4}')
#    xrandr --output "$external_display" --auto --primary --left-of "$internal_display"
#    xrandr --output "$second_external_display" --auto --right-of "$external_display"
#    xrandr --output "$third_external_display" --auto --right-of "$second_external_display"
#    notify-send "External display is connected" --icon=dialog-information
#else
#    internal_display=$(echo $displays | awk '{print $1}')
#    xrandr --output "$internal_display" --auto --primary
#    notify-send "External display is disconnected" --icon=dialog-information
#fi
#
#if [ "$eth_connected" -eq 1 ]; then
#    notify-send "Ethernet is connected" --icon=dialog-information
#    nmcli radio wifi off
#fi
