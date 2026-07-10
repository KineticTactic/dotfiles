#!/usr/bin/env zsh

LEFT_BATTERY=$(system_profiler SPBluetoothDataType 2>/dev/null | grep -o "Left Battery Level: [0-9]*%" | grep -o "[0-9]*")
RIGHT_BATTERY=$(system_profiler SPBluetoothDataType 2>/dev/null | grep -o "Right Battery Level: [0-9]*%" | grep -o "[0-9]*")

if [[ -n "$LEFT_BATTERY" && -n "$RIGHT_BATTERY" ]]; then
    LABEL="󱡏 ${LEFT_BATTERY} ${RIGHT_BATTERY}"
    DRAWING=on
else
    LABEL=""
    DRAWING=off
fi

sketchybar --set "$NAME" label="$LABEL" label.drawing="$DRAWING"
