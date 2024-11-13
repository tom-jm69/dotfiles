#!/bin/bash

# Check if the sink is muted
is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "true" || echo "false")

# Get the current volume percentage
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)

# Display the appropriate icon based on the mute status with the specified color
if [ "$is_muted" == "true" ]; then
    icon="<span color=\"#91d7e3\"> </span>"  # Muted icon
else
    icon="<span color=\"#91d7e3\"> </span>"  # Unmuted icon
fi

# Output the icon and volume
echo "$icon $volume%"

# Handle click actions
case $BLOCK_BUTTON in
    1) # Left click - toggle mute
       pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
    3) # Right click - open pavucontrol (if installed)
       pavucontrol ;;
    4) # Scroll up - increase volume
       pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    5) # Scroll down - decrease volume
       pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
esac
