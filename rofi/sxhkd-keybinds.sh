#!/bin/bash
# thank you so much to 'my take on tech' for this script!
# https://my-take-on.tech/2020/07/03/some-tricks-for-sxhkd-and-bspwm/

# TODO: also include rows that don't have a corresponding comment
awk '/^[a-z~@]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0; sub(/# ?/,"",last)}' ~/.config/sxhkd/sxhkdrc |
    column -t -s $'\t' |
    rofi -dmenu -i -theme-str '@import "sxhkd.rasi"' -markup-rows -no-show-icons -lines 15 -yoffset 40
