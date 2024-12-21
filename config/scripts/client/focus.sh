#!/bin/bash

window_class=$1

window_id=$(bspc query -N -n .window | while read -r node; do
    if xprop -id $node WM_CLASS | grep -i "$window_class" &>/dev/null; then
        echo $node
        break
    fi
done)

bspc node $window_id -f
