#!/usr/bin/env bash

# exit on error
set -e

if currl --version &>/dev/null
then
  echo Using curl for HTTP Requests.
  HTTP_PROGRAM="curl"
elif wget --version &>/dev/null
then
  echo Using wget for HTTP requests.
  HTTP_PROGRAM="wget"
else
  >&2 echo ERROR: Neither Curl nor Wget is installed!
fi

function download() {
  case $HTTP_PROGRAM in
    "curl")
      # -L = follow redirects
      # for some reason github lets you bypass ratelimiting by just sending an authorization header...
      curl -qL $1 -H "Authorization: no"  2>/dev/null
      ;;
    "wget")
      # q = silent, O = write output, '-' = to stdout
      wget -qO - --header="Authorization: no" $1
      ;;
  esac
}

function download_things() {
  download https://api.github.com/repos/SuperCuber/dotter/releases/latest | jq --raw-output ".assets | map(.browser_download_url) | .[]" | while read line;
  do
    FILENAME=$(echo ${line} | rev | cut -d / -f 1 | rev)
    echo Downloading \"$FILENAME\"...
    # overwrite dotter installation
    download ${line} > $FILENAME
    echo FINISHED downloading \"$FILENAME\"
    if [[ $FILENAME != *.exe ]]
    then
      echo Adding EXECUTE permissions to ./$FILENAME
      chmod +x ./$FILENAME
    fi
  done

  # Example value: 'Dotter 1.0.0'
  DOTTER_VERSION=$(./dotter --version 2>/dev/null)
  if [[ $DOTTER_VERSION != "" ]]
  then
    echo Successfully downloaded $DOTTER_VERSION
  else
    >&2 echo ERROR: Couldn\'t download the dotter update!
  fi
}

# print stderr in red and stdout in green
download_things 2> >(while read line; do echo -e "\e[01;31m$line\e[0m" >&2; done) 1> >(while read line; do echo -e "\e[01;32m$line\e[0m" >&2; done)
