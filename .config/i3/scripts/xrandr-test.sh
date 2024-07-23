#!/bin/bash

echo "External display is connected" >> /tmp/xrandr.log
displays=$(xrandr | grep " connected" | awk '{print $1}')
eth_connected=$(ip link show | grep "state UP" | grep -c "enx")
wlan_connected=$(ip link show | grep "state UP" | grep -c "wlp0s")

# Set keyboard repeat rate
xset r rate 250 80

EXTERNAL_PRIMARY="00ffffffffffff0010acfbd04c47503006200104a53c22783a9325a9544d9e250c5054a54b008100b300d100714fa9408180d1c00101565e00a0a0a029503020350055502100001a000000ff00344e47564d4b330a2020202020000000fc0044454c4c20503237323044430a000000fd00314b1d711c010a2020202020200108020314b14f90050403020716010611121513141f023a801871382d40582c450055502100001e011d8018711c1620582c250055502100009e7e3900a080381f4030203a0055502100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b2"
EXTERNAL_LEFT="00ffffffffffff0010ac9c4157563041181e0104a53c22783eee95a3544c99260f5054a54b00714f8180a940d1c00101010101010101565e00a0a0a029503020350055502100001a000000ff0033374d475931330a2020202020000000fc0044454c4c20553237313944430a000000fd00384c1e5a19010a202020202020014602031cf14f90050403020716010611121513141f23097f0783010000023a801871382d40582c450055502100001e7e3900a080381f4030203a0055502100001a011d007251d01e206e28550055502100001ebf1600a08038134030203a0055502100001a00000000000000000000000000000000000000000000000000000012"
INTERNAL="00ffffffffffff004d101515000000000d1f0104a52215780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360050d210000018203080a070b023403020360050d210000018000000fe00445737584e814c513135364e31000000000002410332001200000a010a202000d1"

get_display_mode() {
    echo "$1" | edid-decode | grep -A1 "Detailed mode" | tail -n1 | awk '{print $1"x"$3}'
}

primary_display=$(xrandr | grep " connected primary" | awk '{print $1}')

if [ $(echo "$displays" | wc -w) -eq 1 ]; then
    echo "Internal display"
    xrandr --output $(echo "$displays" | head -n 1) --mode $(get_display_mode "$INTERNAL")

elif [ $(echo "$displays" | wc -w) -eq 2 ]; then
    echo "1 External display"
    external_display=$(echo "$displays" | grep -v "$primary_display")
    if [ -z "$primary_display" ]; then
        primary_display=$(echo "$displays" | head -n 1)
        xrandr --output $primary_display --primary
    fi
    xrandr --output $external_display --mode $(get_display_mode "$EXTERNAL_PRIMARY") --primary --left-of $primary_display

elif [ $(echo "$displays" | wc -w) -eq 3 ]; then
    echo "2 External displays"
    external_displays=($(echo "$displays" | grep -v "$primary_display"))
    if [ -z "$primary_display" ]; then
        primary_display=$(echo "$displays" | head -n 1)
        xrandr --output $primary_display --primary
    fi
    xrandr --output ${external_displays[0]} --mode $(get_display_mode "$EXTERNAL_PRIMARY") --primary
    xrandr --output ${external_displays[1]} --mode $(get_display_mode "$EXTERNAL_LEFT") --left-of ${external_displays[0]}

else
    echo "External display"
fi
