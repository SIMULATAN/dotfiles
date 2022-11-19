#!/bin/bash

internal_monitor="$(xrandr | grep primary | cut -d ' ' -f 1)"
external_monitor="$(xrandr | grep ' connected ' | grep --invert primary | cut -d ' ' -f 1 | head -1)"

function monitor_added() {
  for desktop_name in {1..10}; do
    bspc desktop $(bspc query -D -d "$desktop_name") --to-monitor $internal_monitor
  done

  for desktop_name in {a..j}; do
    bspc desktop $(bspc query -D -d "$desktop_name") --to-monitor $external_monitor
  done

  bspc desktop Desktop --remove 2>/dev/null
  bspc monitor $internal_monitor -o {a..j}
  bspc monitor $external_monitor -o {1..10}
}

function monitor_removed() {
	bspc monitor $external_monitor -a Desktop # Temp desktop because one desktop required per monitor

  for desktop_name in {1..10} {a..j}; do
    bspc desktop $(bspc query -D -d "$desktop_name") --to-monitor $internal_monitor
  done

  bspc monitor $internal_monitor -o {1..10} {a..j}
	bspc desktop Desktop --remove 2>/dev/null
}

case "$1" in
  ADD)
    monitor_added
    ;;
  REMOVE)
    monitor_removed
    ;;
  *)
    echo "No Subcommand given, attempting to auto configure..."
    (($(xrandr -q | grep ' connected' | wc -l) > 1)) && monitor_added || monitor_removed
    ;;
esac
