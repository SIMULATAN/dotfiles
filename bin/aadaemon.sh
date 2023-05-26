#!/bin/bash

while read art_url; do
  if [ -z "$art_url" ]; then
    rm /tmp/album_art*
    exit
  fi

  track_url="${art_url#file://}"
  if [[ "$track_url" =~ ^http ]] && [[ ! "$(cat /tmp/last_album_art.url 2>/dev/null)" == "$track_url" ]]; then
      echo 'URL starts with "http", downloading to "/tmp/album_art_dl.png"...'
      wget -O /tmp/album_art_dl.png "$track_url"
      # only copy after download to prevent corruption
      cp /tmp/album_art_dl.png /tmp/album_art.png
      echo "$track_url" > /tmp/last_album_art.url
  fi

  if [ -f /tmp/album_art.sum -a -f /tmp/album_art.png ] && sha="$(sha1sum --quiet -c /tmp/album_art.sum)"; then
      echo Cache up to date.
  else
      echo Updating cache...
      if ! magick convert "$track_url" -gravity center -crop 1:1 +repage /tmp/album_art.png; then
          echo "Magick convert didn\'t work, copying..."
          cp "$track_url" /tmp/album_art.png
      fi
      sha1sum "/tmp/album_art.png" > /tmp/album_art.sum
  fi
  icon_name="/tmp/album_art.png"
  song_name="$(playerctl metadata xesam:artist) - $(playerctl metadata xesam:title)"
done < <(playerctl metadata mpris:artUrl -F)
