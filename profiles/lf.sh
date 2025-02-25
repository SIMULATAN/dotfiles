if ! lf --version &>/dev/null; then
  return 0
fi

lfcd_location="$HOME/.local/bin/lfcd"
[ -f "$lfcd_location" ] || (echo "lfcd not found, downloading..." && curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfcd.sh -o "$lfcd_location")

source "$lfcd_location"

alias lf="lfcd"
