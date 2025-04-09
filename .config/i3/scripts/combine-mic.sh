#!/bin/bash

WIRELESS="alsa_input.usb-Generic_Blue_Microphones_2036BAB0PTQ8-00.analog-stereo"
YETI="alsa_input.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.mono-fallback"

YETI_CONNECTED=0
WIRELESS_CONNECTED=0

if [ "$1" == "-u" ]; then
  pactl unload-module module-loopback
  pactl unload-module module-null-sink
  pactl unload-module module-remap-source
  exit 0
fi

if pactl list sources | grep -q "$YETI"; then
    YETI_CONNECTED=1
fi

if pactl list sources | grep -q "$WIRELESS"; then
    WIRELESS_CONNECTED=1
fi

NULL_SINK_EXISTS=$(pactl list sinks short | grep -q "combined" && echo 1 || echo 0)
LOOPBACK_EXISTS=$(pactl list modules short | grep -q "module-loopback" && echo 1 || echo 0)
REMAP_SOURCE_EXISTS=$(pactl list sources short | grep -q "combined_mic" && echo 1 || echo 0)

if [[ "$YETI_CONNECTED" == 1 ]]; then
    echo "Yeti is connected"
    if [[ "$WIRELESS_CONNECTED" == 1 ]]; then
        echo "Wireless is also connected."

        if [[ "$NULL_SINK_EXISTS" == 0 ]]; then
            pactl load-module module-null-sink sink_name=combined sink_properties=device.description="Combined"
        fi

        if [[ "$LOOPBACK_EXISTS" == 0 ]]; then
            pactl load-module module-loopback source=$WIRELESS sink=combined
            pactl load-module module-loopback source=$YETI sink=combined
        fi

        if [[ "$REMAP_SOURCE_EXISTS" == 0 ]]; then
            pactl load-module module-remap-source master=combined.monitor source_name=combined_mic source_properties=device.description="Combined Microphone"
        fi

        pactl set-default-source combined_mic
    else
        echo "Wireless is not connected."
        pactl set-default-source $YETI
    fi
fi
