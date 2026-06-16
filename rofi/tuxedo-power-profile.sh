#!/usr/bin/env bash
set -euo pipefail

DBUS_DEST="com.tuxedocomputers.tccd"
DBUS_PATH="/com/tuxedocomputers/tccd"
DBUS_GET="com.tuxedocomputers.tccd.GetProfilesJSON"
DBUS_SET="com.tuxedocomputers.tccd.SetTempProfileById"

json="$(
  gdbus call --system \
    --dest "$DBUS_DEST" \
    --object-path "$DBUS_PATH" \
    --method "$DBUS_GET" \
  | cut -d"'" -f2
)"

mapfile -t profiles < <(
  jq -r '
    (if type == "array" then . elif has("profiles") then .profiles else [] end)[]
    | select(.id != null)
    | @base64
  ' <<< "$json"
)

[ "${#profiles[@]}" -gt 0 ] || exit 1

display_names=()
selected_id=""
selected_name=""

for row in "${profiles[@]}"; do
  obj="$(printf '%s' "$row" | base64 -d)"
  name="$(jq -r '.name // .display_name // .title // .id' <<< "$obj")"
  display_names+=("$name")
done

choice="$(
  printf '%s\n' "${display_names[@]}" \
  | rofi -dmenu -i -p "TCC profile"
)"

[ -n "${choice:-}" ] || exit 0

for row in "${profiles[@]}"; do
  obj="$(printf '%s' "$row" | base64 -d)"
  name="$(jq -r '.name // .display_name // .title // .id' <<< "$obj")"
  if [ "$name" = "$choice" ]; then
    selected_id="$(jq -r '.id' <<< "$obj")"
    selected_name="$name"
    break
  fi
done

[ -n "${selected_id:-}" ] || exit 1

gdbus call --system \
  --dest "$DBUS_DEST" \
  --object-path "$DBUS_PATH" \
  --method "$DBUS_SET" \
  "$selected_id" >/dev/null

notify-send "TUXEDO profile" "Switched to: $selected_name"
