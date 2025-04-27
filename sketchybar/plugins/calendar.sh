#!/bin/bash

# i am the time 24h format
LABEL="$(date +'%a %d %b %H:%M')"

sketchybar --set "$NAME" label="$LABEL"

