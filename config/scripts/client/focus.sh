#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: focus.sh <window_class>"
    exit 1
fi

window_class=$1

window_id=$(bspc query -N -n .window | while read -r node; do
    if xprop -id $node WM_CLASS | grep -i "$window_class" &>/dev/null; then
        echo $node
        break
    fi
done)

if [ -z "$window_id" ]; then
    echo "No window found with class: $window_class"
    exit 1
fi

bspc node $window_id -f
