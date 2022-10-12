alias mip="wmip"
alias wmip="whatsmyip"

function whatsmyip() {
  AWS="$(curl checkip.amazonaws.com 2>/dev/null)"
  echo "$AWS"
  if [[ ! "$1" == "--short" ]]; then
    IPINFO="$(curl ipinfo.io/ip 2>/dev/null)"
    [[ ! "$AWS" == "$IPINFO" ]] && echo $IPINFO
  fi
}
