#!/bin/sh

TYPE="$(yabai -m query --spaces --space | jq -r '.type')"

# click toggles bsp/float on the current space; going back to bsp also rebuilds the tree,
# so two clicks fix windows tiling around an empty slot
if [ "$SENDER" = "mouse.clicked" ]; then
  if [ "$TYPE" = "bsp" ]; then TYPE=float; else TYPE=bsp; fi
  yabai -m space --layout "$TYPE"
fi

case "$TYPE" in
  bsp) ICON=󰕰 ;;
  *) ICON=󰖲 ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="$TYPE"
