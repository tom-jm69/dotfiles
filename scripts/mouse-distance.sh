#!/bin/bash

# Mouse DPI (adjust this to match your mouse's DPI setting)
MOUSE_DPI=800  # Adjust if necessary

# Conversion factors
INCHES_PER_CM=0.393701  # 1 cm = 1/2.54 inches
PIXELS_PER_CM=$(echo "scale=6; $MOUSE_DPI * $INCHES_PER_CM" | bc)

# Log file
LOG_FILE="mouse_distance.log"
echo "Mouse Movement Log - $(date)" > "$LOG_FILE"

# Initial mouse position
eval $(xdotool getmouselocation --shell)
LAST_X=$X
LAST_Y=$Y

TOTAL_DISTANCE=0

echo "Tracking mouse movement... Press Ctrl+C to stop."

while true; do
    sleep 0.1  # Adjust the polling interval if needed
    eval $(xdotool getmouselocation --shell)
    
    # Calculate movement delta
    DX=$(($X - $LAST_X))
    DY=$(($Y - $LAST_Y))
    
    # Calculate Euclidean distance in pixels
    DISTANCE_PIXELS=$(echo "scale=6; sqrt($DX^2 + $DY^2)" | bc)
    
    # Convert to cm
    DISTANCE_CM=$(echo "scale=6; $DISTANCE_PIXELS / $PIXELS_PER_CM" | bc)
    
    # Update total distance
    TOTAL_DISTANCE=$(echo "scale=6; $TOTAL_DISTANCE + $DISTANCE_CM" | bc)
    
    # Log and print
    LOG_ENTRY="$(date '+%Y-%m-%d %H:%M:%S') - Moved: ${DISTANCE_CM} cm | Total: ${TOTAL_DISTANCE} cm"
    echo "$LOG_ENTRY"
    echo "$LOG_ENTRY" >> "$LOG_FILE"
    
    # Update last position
    LAST_X=$X
    LAST_Y=$Y
done
