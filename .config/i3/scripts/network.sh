#!/bin/bash


WIFI="wlp0s20f3"
ETHERNET="eth0"

interfaces=$(ip link show | grep -oP '\d+: \K[^:]+')
if [ "echo $interfaces | grep -q $ETHERNET" ]; then
    if [ "ip link show $ETHERNET | grep -q UP" ]; then
        echo "Ethernet is connected"
        echo "ip link set $WIFI down"
    else
        echo "ip link set $WIFI up"
    fi
fi

