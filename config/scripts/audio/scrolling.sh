#!/bin/bash

scroll_text() {
    local text="$1"
    local width="$2"
    local delay="$3"
    local length=${#text}
    
    while true; do
        for (( i=0; i<length; i++ )); do
            output="${text:i:width}"
            if (( ${#output} < width )); then
                output="${output}$(echo "$text" | cut -c 1-$((width - ${#output})))"
            fi
            echo "$output"
            sleep "$delay"
        done
    done
}

TEXT=$(python ~/Repos/dotfiles/config/scripts/audio/currently_playing.py)
WIDTH=30
DELAY=0.5

scroll_text "$TEXT | " "$WIDTH" "$DELAY"
