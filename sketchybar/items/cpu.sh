#!/bin/bash

sketchybar  --add item cpu right \
            --set cpu       icon="􀧓" \
                            script="$PLUGIN_DIR/cpu.sh" \
                            update_freq=2 \
            --subscribe battery system_woke power_source_change \
