#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 30 \
        --delay 0.1 \
        --scroll-padding " | " \
        --match-command "python .config/dotfiles/config/scripts/audio/currently_playing.py" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "python .config/dotfiles/config/scripts/audio/currently_playing.py" &

wait
