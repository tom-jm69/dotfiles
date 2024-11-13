#!/bin/bash

# Find the first active Ethernet interface that matches "eth*" or "enp*"
INTERFACE=$(ip addr show | awk '/inet.*brd/{print $NF}' | egrep -v "(br-*)|(docker)" | head -1)

# Check if an interface was found
if [ -z "$INTERFACE" ]; then
    echo "<span color=\"#91d7e3\"></span> No Interface"
    exit 0
fi

# Check if the interface is connected by verifying it has an IP address
ip_address=$(ip addr show "$INTERFACE" | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1)

if [ -n "$ip_address" ]; then
    # If connected, display IP address
    echo "<span color=\"#91d7e3\"></span>"
else
    # If not connected, display disconnected status
    echo "<span color=\"#91d7e3\">󰌙</span> Disconnected"
fi
if [ "$BLOCK_BUTTON" == "1" ]; then
    # Display the alternate format
    nm-connection-editor

fi
