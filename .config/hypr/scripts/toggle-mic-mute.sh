#!/bin/bash

SOURCE=$(pactl get-default-source)
MONITOR_SCRIPT=~/dotfiles/.config/hypr/scripts/mic-monitor.sh
PIDFILE="/tmp/mic_monitor.pid"

MUTE_STATE=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')

if [[ "$MUTE_STATE" == "yes" ]]; then
    pactl set-source-mute "$SOURCE" 0
    notify-send "🎤 Mic unmuted"

    # Kill background monitor if running
    if [[ -f "$PIDFILE" ]]; then
        kill "$(cat "$PIDFILE")" 2>/dev/null
        rm "$PIDFILE"
    fi
else
    pactl set-source-mute "$SOURCE" 1
    notify-send "🔇 Mic muted"

    # Start background monitoring
    bash "$MONITOR_SCRIPT" "$SOURCE" &
    echo $! > "$PIDFILE"
fi
