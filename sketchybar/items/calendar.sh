#!/bin/bash

sketchybar  --add item calendar right \
            --set calendar   script="$PLUGIN_DIR/calendar.sh" \
                            update_freq=30 \
                            icon.padding_left=0 \
                            icon.padding_right=0 \
            --subscribe calendar system_woke

