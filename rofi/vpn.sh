#!/bin/bash

# thanks to afwlehmann for the original version!
# https://github.com/afwlehmann/rofi-modes/blob/baed066363521cd394a0adb9524df3a14bec0e3b/rofi-vpn
#
# adapted by SIMULATAN
# Changes:
# - standalone script instead of a mode
# - add notifications
# - switch to bash instead of zsh (for portability reasons)
# - use "Disconnect" instead of "Shutdown"

function shutdown_active_vpns {
	readarray -t ACTIVE_VPNS <<<$(nmcli --get type,name connection show --active | grep '^vpn' | cut -d : -f 2)
	local VPN
	for VPN in ${ACTIVE_VPNS[@]}; do
		nmcli connection down $VPN >/dev/null || true
	done
	if [[ "$1" == "true" ]]; then
		notify "Disconnected"
	fi
}

function notify() {
	notify-send.sh -i network-error -t 3000 --replace=450 "[VPN] $1" "$2"
}

NETWORKS="$(nmcli --get type,name connection show | grep '^vpn' | cut -d : -f 2)"
RESULT="$(printf "$NETWORKS\nDisconnect" | rofi -dmenu -i -p '')"

(
	[[ "$RESULT" == "Disconnect" ]] \
		&& shutdown_active_vpns true \
		|| (shutdown_active_vpns && notify "Connecting..." && nmcli connection up "$RESULT" >/dev/null 2>"$HOME/.local/share/rofi-vpn.log" && notify "Connected." || notify "Connection error - check '~/.local/share/rofi-vpn.log' for more information")
) &

# vim:set noexpandtab:
