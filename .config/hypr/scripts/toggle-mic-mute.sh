#!/bin/bash

SOURCE=$(pactl get-default-source)
MONITOR_SCRIPT=~/dotfiles/.config/hypr/scripts/mic-monitor.sh
PIDFILE="/tmp/mic_monitor.pid"
ICON_MIC_ON="microphone-sensitivity-high-symbolic"
ICON_MIC_OFF="microphone-sensitivity-muted-symbolic"
APP_NAME="Mic Toggle"

MUTE_STATE=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')

if [[ "$MUTE_STATE" == "yes" ]]; then
    pactl set-source-mute "$SOURCE" 0
    notify-send \
        -a "$APP_NAME" \
        -i "$ICON_MIC_ON" \
        -u normal \
        -t 2500 \
        -e \
        "🎤 Mic is ON" \
        "You are live, talk away!"
    
    # Kill background monitor if running
    if [[ -f "$PIDFILE" ]]; then
        kill "$(cat "$PIDFILE")" 2>/dev/null
        rm "$PIDFILE"
    fi
else
    pactl set-source-mute "$SOURCE" 1
    notify-send \
        -a "$APP_NAME" \
        -i "$ICON_MIC_OFF" \
        -u normal \
        -t 2500 \
        -e \
        "🔇 Mic is OFF" \
        "You are muted now. Shhh..."
    
    # Start background monitoring
    bash "$MONITOR_SCRIPT" "$SOURCE" &
    echo $! > "$PIDFILE"
fi
