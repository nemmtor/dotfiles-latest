#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

# TZ and FORMAT can be set per item in sketchybarrc
sketchybar --set "$NAME" label="$(date "+${FORMAT:-%d/%m %H:%M}")"

