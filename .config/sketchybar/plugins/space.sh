#!/bin/sh

# $SELECTED and $SID are set by sketchybar for space items
if [ "$SENDER" = "mouse.clicked" ]; then
  # presses ctrl+N: needs Keyboard Shortcuts > Mission Control > "Switch to Desktop N" on,
  # and Accessibility access for sketchybar
  KEYCODE="$(echo "18 19 20 21 23 22 26 28 25 29" | cut -d' ' -f"$SID")"
  osascript -e "tell application \"System Events\" to key code $KEYCODE using control down"
  exit 0
fi

sketchybar --set "$NAME" background.drawing="$SELECTED" icon.highlight="$SELECTED" label.highlight="$SELECTED"
