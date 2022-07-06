#!/bin/bash
# Thanks to dastorm for the original code!
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh

# Thanks to the faba icons theme for the volume icons!
# https://github.com/snwh/faba-icon-theme/tree/master/Faba/48x48/notifications

# Adapted, expanded & completed by SIMULATAN
# https://github.com/SIMULATAN/dotfiles/blob/main/i3/volume.sh

function get_volume {
    pactl list sinks | tr ' ' '\n' | grep -m1 '%' | tr -d '%'
}

function is_mute {
    # hacky solution but it works
    amixer get Master | tail -2 | grep -c '\[on\]'
}

function send_notification {
    DIR=`dirname "$0"`
    volume=`get_volume`
    if [ "$(is_mute)" = "0" ]; then
        icon_name="{{dotter.current_dir}}/i3/notification-audio-volume-muted.svg"
    elif [ "$volume" -eq "0" ]; then
	icon_name="{{dotter.current_dir}}/i3/notification-audio-volume-silent.svg"
    elif [ "$volume" -lt "30" ]; then
        icon_name="{{dotter.current_dir}}/i3/notification-audio-volume-low.svg"
    elif [ "$volume" -lt "70" ]; then
        icon_name="{{dotter.current_dir}}/i3/notification-audio-volume-medium.svg"
    else
        icon_name="{{dotter.current_dir}}/i3/notification-audio-volume-high.svg"
    fi
    # Make the bar with the special character ─ (it's not a normal dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    # Example (at 60%): ━━━━━━━━━━━───────
    # Use the "Monospace" font for best results
    bar=$(echo `seq -s "━" $(($volume/5))``seq -s "─" $(((100-$volume)/5))` | sed 's/[0-9]//g')
    # outsourced to be replaced by the >= 100% fix later
    spacing="     "
    if [ "$volume" = "0" ]; then
        # add a space (because we have 1 char less)
        volume=" ${volume}"
        # for some reason, the bar contains one block too much
        # if anyone knows a better solution, please send a PR! Thanks :)
        bar=${bar:0:-1}
    elif [ "$volume" -ge "100" ]; then
        # fix bar for values >= 100
        bar="━━━━━━━━━━━━━━━━━"
        # remove spacing
        spacing=${spacing:0:-1}
    fi
    $DIR/notify-send.sh "$volume""     ""$bar" -i "$icon_name" -t 2000 -h string:synchronous:"$bar" --replace=555
}

send_notification
