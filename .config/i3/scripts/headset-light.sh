#!/bin/bash


CONNECT=$(headsetcontrol | grep "G935")

if [ "$CONNECT" != "" ]; then
    headsetcontrol -l 0
    dunstify "G935" "turned off the lights" --raw_icon=/usr/share/icons/Adwaita/16x16/devices/audio-headset.png
fi
