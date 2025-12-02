#!/bin/bash

SOURCE=$1
THRESHOLD_DB=-50
BEEP_CMD='ffplay -nodisp -autoexit -loglevel quiet -f lavfi -i "sine=frequency=1000:duration=0.4"'

while true; do
    MUTE_STATE=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')
    if [[ "$MUTE_STATE" == "no" ]]; then
        break
    fi

    PEAK_DB=$(ffmpeg -f pulse -i "$SOURCE" -t 2 -filter:a volumedetect -f null - 2>&1 \
        | grep max_volume | awk '{print $5}' | sed 's/dB//' | awk '{print $1 + 0}')

    if (( $(echo "$PEAK_DB > $THRESHOLD_DB" | bc -l) )); then
        eval "$BEEP_CMD"
    fi

    sleep 2
done
