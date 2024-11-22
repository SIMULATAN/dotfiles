#!/bin/sh

[ -f ~/.local/state/disable_playerstatus ] && echo && exit 0

player_status="$(playerctl status 2>/dev/null)"

if echo "$player_status" | grep -ixP "^(playing)|(paused)$" >/dev/null 2>&1; then
    artist="$(playerctl metadata artist 2>/dev/null)"
    title="$(playerctl metadata title 2>/dev/null || echo 'Unknown')"

    [ "$player_status" = "Paused" ] && printf "⏸ "

    echo -n "$artist"
    [ -n "$artist" ] && [ -n "$title" ] && printf " - "
    echo -n "$title"
fi
