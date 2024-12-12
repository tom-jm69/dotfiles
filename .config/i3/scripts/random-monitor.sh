#!/bin/bash 

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
   echo $m
done
