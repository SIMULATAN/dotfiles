#!/bin/bash
# Adapted from Brodie Robertson
# https://gist.github.com/BrodieRobertson/dd7e3d793a501066c50086ed795c0357

# Usage:
# tabc.sh <command>
# Commands:
#    add <direction-of-tabbed> <window-id> - Add window to tabbed
#    remove <window-id> - Remove window from tabbed
#    list <tabbed-id> - List all clients of tabbed

#
# Functions
#

# Get wid of root window
function get_root_wid {
	xwininfo -root | awk '/Window id:/{print $4}'
}

# Get children of tabbed
function get_clients {
	id=$1
	xwininfo -id $id -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p'
}

# Get class of a wid
function get_class {
	id=$1
  if [ -z $id ]; then
    echo ""
  else
	  xprop -id $id | sed -n '/WM_CLASS/s/.*, "\(.*\)"/\1/p'
  fi
}

#
# Main Program
#

cmd=$1
if [ $cmd = "add" ]; then
  tabbedid=$(bspc query -N -n $2)
  if [ -z $tabbedid ]; then
    tabbedid=$(tabbed -c -d)
  fi
fi

case $cmd in
	add)
		wid=$3
		xdotool windowreparent $wid $tabbedid
		;;
	remove)
		wid=$2
		xdotool windowreparent $wid $(get_root_wid)
		;;
	list)
		tabbed=$2
		get_clients $tabbed
		;;
esac
