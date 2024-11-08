#!/bin/bash

export LC_ALL="C"
rofi -show run 2>&1 -normal-window | tee /tmp/rofi-run.log
exit 0 
