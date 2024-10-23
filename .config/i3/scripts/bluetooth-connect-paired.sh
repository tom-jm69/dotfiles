#!/bin/bash

# Define the device's MAC address
DEVICE_MAC="24:11:53:8C:1E:55"

# Scan for the device using bluetoothctl for 10 seconds
bluetoothctl --timeout 10 scan le | grep "$DEVICE_MAC" > /dev/null
BLUETOOTH_EXIT_CODE="$?"

# Check if the device was found
if [ "$BLUETOOTH_EXIT_CODE" -eq 0 ]; then
    echo "Device $DEVICE_MAC found, attempting to connect..."

    # Try to connect to the device
    bluetoothctl connect "$DEVICE_MAC"
    BLUETOOTH_CONNECTION_EXIT_CODE="$?"


    # Check if the connection was successful
    if [ "$BLUETOOTH_CONNECTION_EXIT_CODE" -eq 0 ]; then
        echo "Successfully connected to $DEVICE_MAC."
    else
        echo "Failed to connect to $DEVICE_MAC."
    fi
else
    echo "Device $DEVICE_MAC not found."
fi
