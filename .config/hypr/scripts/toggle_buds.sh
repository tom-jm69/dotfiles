
#!/bin/bash

STATE_FILE="$HOME/.buds_mode"

if [ ! -f "$STATE_FILE" ]; then
  echo "ambient" > "$STATE_FILE"
fi

MODE=$(cat "$STATE_FILE")

case "$MODE" in
  "ambient")
    echo "anc" > "$STATE_FILE"
    galaxybudsclient action -e AncToggle
    sleep 1
    galaxybudsclient action -e TogglePlayPause
    ;;
  "anc")
    echo "pause" > "$STATE_FILE"
    galaxybudsclient action -e TogglePlayPause
    ;;
  "pause")
    echo "ambient" > "$STATE_FILE"
    galaxybudsclient action -e AmbientToggle
    sleep 1
    galaxybudsclient action -e TogglePlayPause
    ;;
esac
