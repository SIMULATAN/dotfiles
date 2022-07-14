#!/bin/bash
echo Testing for go...
if ! go version; then
  echo ERROR: go not installed.
  exit 1
fi

if [ "$1" != "--headless" ]; then
  printf "Opening nvim and installing plugins in 10 seconds...\nTo quit vim after the installation has finished, enter ':q' twice\n"
  read -n 1 -t 10 -r -p "Press any key to skip the countdown..."
fi
# runs 'PlugInstall'
nvim +PlugInstall
