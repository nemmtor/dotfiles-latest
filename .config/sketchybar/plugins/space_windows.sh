#!/bin/sh

# $INFO: {"space": N, "apps": {"<app name>": <window count>}}
# icon_map.json is from https://github.com/kvndrsslr/sketchybar-app-font releases
if [ "$SENDER" = "space_windows_change" ]; then
  SPACE="$(echo "$INFO" | jq -r '.space')"
  ICONS="$(echo "$INFO" | jq -r --slurpfile map "$CONFIG_DIR/icon_map.json" '
    [.apps | keys[] as $app
      | first($map[0][] | select(.appNames | index($app)) | .iconName) // ":default:"]
    | join(" ")')"

  if [ -n "$ICONS" ]; then
    sketchybar --set space."$SPACE" label="$ICONS" label.drawing=on
  else
    sketchybar --set space."$SPACE" label.drawing=off
  fi
fi
