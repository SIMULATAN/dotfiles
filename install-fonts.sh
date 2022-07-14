#!/bin/bash
if ! unzip &>/dev/null; then
  echo ERROR: unzip has to be installed! >/dev/stderr
  exit 1
fi

set -e

if [ ! -d fonts ]; then
  mkdir fonts
fi
cd fonts

function install-jetbrains-mono-nerd() {
  # only do a clone if the local folder doesn't exist and is a git repo with the right url
  if ! { [ -d nerd-fonts ] && [ "$(cd nerd-fonts && git remote get-url origin)" == "https://github.com/ryanoasis/nerd-fonts" ]; }; then
    echo Nerd Fonts Repo doesn\'t exist, doing a sparse clone...
    git clone --depth 1 --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts
  fi

  cd nerd-fonts
  echo Sparse checking out the right Nerd Fonts folder...
  git sparse-checkout set patched-fonts/JetBrainsMono

  echo Searching for JetBrains Nerd Fonts...
  find_command="find "./patched-fonts/JetBrainsMono" \( \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -and -name '*Complete*' -and \! -name '*Font Awesome*' -and \! -name '*Font Linux *' -and \! -name '*Octicons *' -and \! -name '*Pomicons *' -and \! -name '*Nerd Font*Mono *' -and \! -name '*Windows Compatible*' \) -type f -print0"

  files=()
  while IFS=  read -r -d $'\0'; do
    files+=("$REPLY")
  done < <(eval "$find_command")

  echo Found ${#files[@]} JetBrains Nerd Fonts, copying now...
  cp -f "${files[@]}" $(get-location JetBrainsMono)
  echo Installed JetBrains Mono!
}

function install-fontawesome() {
  echo Downloading FontAwesome...
  wget -qnc https://use.fontawesome.com/releases/v6.1.1/fontawesome-free-6.1.1-desktop.zip
  echo Downloaded FontAwesome, unzipping...
  unzip -qu fontawesome-free-6.1.1-desktop.zip
  echo Unzipped FontAwesome, copying...
  cp fontawesome-free-6.1.1-desktop/otfs $(get-location fontawesome) -r
  echo Installed FontAwesome!
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

install-fontawesome &
install-jetbrains-mono-nerd

echo Installed to $(get-location)
