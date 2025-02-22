#!/bin/bash

xterm -fa "JetBrainsMono Nerd Font" -fs 11 -fullscreen -bg black -e asciiquarium &
export XTERMPID=$!
i3lock -n -c 00000000
kill $XTERMPID
