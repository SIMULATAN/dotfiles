monitors_file="{{dotter.current_dir}}/hyprland/monitors.conf"

available_configs="$(cat "$monitors_file" | grep 'source = mon-' | cut -d ' ' -f 3 | cut -d '.' -f 1)"

prefix="mon-"
selected="$(echo "$available_configs" | sed "s/$prefix//" | rofi -dmenu -p 'Monitor Setup:' -a 0 -no-custom)"
if [ -z "$selected" ]; then
  echo "No selection was made."
  exit
fi
selected="$prefix$selected"

echo "Selected $selected"

# exit if something related to sed fails
set +e

# separate step to avoid cat pipe and tee modifying at the same time
monitor_content="$(cat "$monitors_file")"
echo "$monitor_content" \
  | sed "s/[#]\{0,1\}\(source = $prefix\)/#\1/" \
  | sed "s/#\(source = $selected\)/\1/" \
  | tee "$monitors_file"

