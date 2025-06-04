#!/usr/bin/env bash

ICON_MOUSE="󰍽"
ICON_HEADSET="🎧"
ICON_BATTERY="🔋"
ICON_UNKNOWN="❓"

# Ganze Ausgabe von solaar
solaar_output=$(solaar show)

# Device-Blöcke extrahieren
# Jedes Device beginnt mit "Device: "
IFS=$'\n\n' read -d '' -r -a devices <<< "$(echo "$solaar_output" | awk 'BEGIN{RS="Device: "} NR>1{print "Device: "$0}')"

for dev in "${devices[@]}"; do
    # Art des Geräts finden
    kind=$(echo "$dev" | grep "^  Kind" | awk -F': ' '{print $2}' | tr '[:upper:]' '[:lower:]')
    
    # Batterie % finden
    percentage=$(echo "$dev" | grep -oP 'Battery: \K[0-9]+')
    
    # Icon zuordnen
    case "$kind" in
        mouse) icon=$ICON_MOUSE ;;
        headset) icon=$ICON_HEADSET ;;
        *) icon=$ICON_BATTERY ;;
    esac

    if [[ -n "$percentage" ]]; then
        # Farbe je nach Prozent
        if (( percentage <= 10 )); then
            color="#FF0000" # rot
        elif (( percentage <= 30 )); then
            color="#FFFF00" # gelb
        else
            color="#00FF00" # grün
        fi

        text="<span color='$color'><b>$icon $percentage%</b></span>"
        echo "{\"text\": \"$text\", \"percentage\": $percentage}"
        exit 0
    fi
done

# Falls nichts gefunden
echo "{\"text\": \"<span color='#aaaaaa'><b>$ICON_UNKNOWN --</b></span>\", \"percentage\": 0}"
exit 0
