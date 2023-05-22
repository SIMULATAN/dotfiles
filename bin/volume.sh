#!/bin/bash
# Thanks to dastorm for the original code!
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh

# Thanks to the faba icons theme for the volume icons!
# https://github.com/snwh/faba-icon-theme/tree/master/Faba/48x48/notifications

# Thanks to the arch wiki for the dunstify command!
# https://wiki.archlinux.org/title/Dunst#Using_dunstify_as_volume/brightness_level_indicator

# Adapted, expanded & completed by SIMULATAN
# https://github.com/SIMULATAN/dotfiles/blob/main/i3/volume.sh

function parse_volume() {
    echo "$1" | cut -d % -f $2 | rev | cut -s -d ' ' -f 1 | rev | head -1
}

function get_volume {
    VOLUME_LINE="$(pactl get-sink-volume @DEFAULT_SINK@)"

    VOLUME_LEFT=$(parse_volume "$VOLUME_LINE" 1)
    VOLUME_RIGHT=$(parse_volume "$VOLUME_LINE" 2)
    echo "$(( ($VOLUME_LEFT + $VOLUME_RIGHT) / 2 ))"
}

# returns code 1 if muted, 0 if not muted
function is_mute {
    (pactl get-sink-mute @DEFAULT_SINK@ | cut -d ' ' -f 2 | grep yes) &>/dev/null && return 1 || return 0
}

if playerctl --version &>/dev/null; then
    playerctl_installed=true
fi

function send_notification {
    DIR=`dirname "$0"`
    if [ "$DIR" == "." ]; then DIR="$PWD"; fi
    volume=`get_volume`
    if ! is_mute; then
        icon_name="$DIR/notification-audio-volume-muted.svg"
    elif [ "$volume" -eq "0" ]; then
        icon_name="$DIR/notification-audio-volume-silent.svg"
    elif [ "$volume" -lt "30" ]; then
        icon_name="$DIR/notification-audio-volume-low.svg"
    elif [ "$volume" -lt "70" ]; then
        icon_name="$DIR/notification-audio-volume-medium.svg"
    else
        icon_name="$DIR/notification-audio-volume-high.svg"
    fi

    if [ "$playerctl_installed" = true ] && playerctl status &>/dev/null; then
        art_url="$(playerctl metadata mpris:artUrl)"
        track_url="${art_url#file://}"
        if [[ "$track_url" =~ ^http ]] && [[ ! "$(cat /tmp/last_album_art.url 2>/dev/null)" == "$track_url" ]]; then
            echo 'URL starts with "http", downloading to "/tmp/album_art_dl.png"...'
            wget -O /tmp/album_art_dl.png "$track_url"
            # only copy after download to prevent corruption
            cp /tmp/album_art_dl.png /tmp/album_art.png
            echo "$track_url" > /tmp/last_album_art.url
        fi

        if [ -f /tmp/album_art.sum -a -f /tmp/album_art.png ] && sha="$(sha1sum --quiet -c /tmp/album_art.sum)"; then
            echo Cache up to date.
        else
            echo Updating cache...
            if ! magick convert "$track_url" -gravity center -crop 1:1 +repage /tmp/album_art.png; then
                echo "Magick convert didn\'t work, copying..."
                cp "$track_url" /tmp/album_art.png
            fi
            sha1sum "/tmp/album_art.png" > /tmp/album_art.sum
        fi
        icon_name="/tmp/album_art.png"
        song_name="$(playerctl metadata xesam:artist) - $(playerctl metadata xesam:title)"
    fi

    [[ -z $song_name ]] && name="Volume:" || name="$song_name"
    dunstify -a "volumenotification" -u low -i "$icon_name" -h string:x-dunst-stack-tag:$stacktag -h int:value:$volume "$name" --replace 555 -t 3000
}

send_notification
