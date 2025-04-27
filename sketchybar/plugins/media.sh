#!/bin/bash

STATE="$(echo "$INFO" | jq -r '.state')"
MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
if [ "$STATE" = "playing" ]; then
    ICON=""
elif [ "$STATE" = "paused" ]; then
    ICON=""
else
    sketchybar --set $NAME drawing=off
fi

sketchybar --set $NAME  label="$MEDIA" \
                        icon="$ICON" \
                        drawing=on \
