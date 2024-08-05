#!/bin/bash


CONNECT=$(headsetcontrol | grep "G935")

if [ "$CONNECT" != "" ]; then
    headsetcontrol -l 0
    dunstify "G935 turned off the lights"
fi
