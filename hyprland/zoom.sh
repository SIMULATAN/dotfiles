#!/bin/bash

case "$1" in
  "+") operator=+;;
  "-") operator=-;;
  *) echo 'Please use either "+" or "-"'; exit 1;;
esac

factor="${2:-0.5}"

max_func="define max(a,b){
  if(a>b)
  {
   return(a)
  }else{
   return(b)
  }
}"

current_value="$(hyprctl getoption misc:cursor_zoom_factor -j | jq .float)"
new_value="$(echo "$max_func"'; max('"$current_value" "$operator" "$factor"',1)' | bc)"

hyprctl keyword misc:cursor_zoom_factor "$new_value"
