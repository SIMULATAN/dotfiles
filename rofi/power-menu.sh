#! /bin/sh
# made by eric murphy
# https://github.com/ericmurphyxyz/archrice/blob/c7f0981545bf23a867d940ef719087185db07d8d/.local/bin/powermenu
POWEROFF="⏻  Power Off"
RESTART="  Restart"
# TODO: find better glyph - this one is too big and not consistent with the other ones
SUSPEND="󰤄  Suspend"
LOCK="  Lock"

chosen=$(printf "$POWEROFF\n$RESTART\n$SUSPEND\n$LOCK" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
	$POWEROFF) poweroff ;;
	$RESTART) reboot ;;
	$SUSPEND) suspend.sh ;;
	$LOCK) lock.sh ;;
	*) exit 1 ;;
esac
