#!/usr/bin/env bash

# Session config
SESSIONS="$HOME/Documents/rdp/rdp-sessions.txt"
RDP_CMD="xfreerdp3"
RDP_OPTS="/dynamic-resolution /network:modem +auto-reconnect +clipboard +compression /compression-level:2 +toggle-fullscreen"

# Rofi theming (from launcher.sh)
dir="$HOME/.config/rofi/launchers/type-1"
theme='style-5'
export GTK_THEME=Adwaita:dark

# Choose session via themed rofi
CHOSEN=$(awk -F'|' '{print $1}' "$SESSIONS" | wofi -dmenu -theme "$dir/$theme.rasi" -p "RDP Session")

# Exit if nothing chosen
[ -z "$CHOSEN" ] && exit

# Extract session details
LINE=$(grep "^$CHOSEN|" "$SESSIONS")
HOST=$(echo "$LINE" | cut -d'|' -f2)
USER=$(echo "$LINE" | cut -d'|' -f3)
PASS=$(echo "$LINE" | cut -d'|' -f4)

# Launch RDP
exec $RDP_CMD /u:"$USER" /p:"$PASS" /v:"$HOST" $RDP_OPTS
