#!/bin/bash
if ! unzip &>/dev/null; then
  echo ERROR: unzip has to be installed! >/dev/stderr
  exit 1
fi
if [ ! -d fonts ]; then
  mkdir fonts
fi
cd fonts

function install-jetbrains-mono-nerd() {
  wget -qnc https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
  unzip -qu JetBrainsMono.zip -d JetBrainsMono
  cp JetBrainsMono $(get-location JetBrainsMono) -r
}

function install-fontawesome() {
  wget -qnc https://use.fontawesome.com/releases/v6.1.1/fontawesome-free-6.1.1-desktop.zip
  unzip -qu fontawesome-free-6.1.1-desktop.zip
  cp fontawesome-free-6.1.1-desktop/otfs $(get-location fontawesome) -r
}

function get-location() {
  if [ "$EUID" -ne 0 ]; then
    LOCATION="$HOME/.local/share/fonts/$1"
  else
    LOCATION="/usr/share/fonts/$1"
  fi
  mkdir -p $LOCATION
  echo $LOCATION
}
echo Installed to $(get-location)

{ install-fontawesome; install-jetbrains-mono-nerd; } &
