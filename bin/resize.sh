#!/bin/sh

case $1 in
  expandx)
    bspc node -z right +20 0
    bspc node -z left -20 0
    ;;
  expandy)
    bspc node -z top 0 -20
    bspc node -z bottom 0 +20
    ;;
  shrinkx)
    bspc node -z right -20 0
    bspc node -z left +20 0
    ;;
  shrinky)
    bspc node -z top 0 +20
    bspc node -z bottom 0 -20
    ;;
  *)
    echo "Mode $1 not supported. Please use 'expandx', 'expandy', 'shrinkx' or 'shrinky'."
    ;;
esac
