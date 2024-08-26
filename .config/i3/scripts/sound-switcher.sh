#!/bin/bash

# List available sinks (output devices)
devices=$(wpctl status | grep -A 20 'Audio' | grep 'alsa.output' | awk '{print $1, $2}')

# Show devices in rofi menu
chosen_device=$(echo "$devices" | rofi -dmenu -p "Select Sound Device")

if [ -n "$chosen_device" ]; then
    # Extract the ID of the chosen device
    device_id=$(echo "$chosen_device" | awk '{print $1}')
    
    # Set the chosen device as the default sink
    wpctl set-default "$device_id"
fi
