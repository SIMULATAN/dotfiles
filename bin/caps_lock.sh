DIR=`dirname "$0"`
if xset -version &>/dev/null; then
  $DIR/notify-send.sh "Caps Lock Status: `xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p'`" -t 1500 --replace=666
  echo `xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p'`
else
  $DIR/notify-send.sh "Can't read Caps Lock Status" "Please install the 'xset' package" --replace=666
fi
