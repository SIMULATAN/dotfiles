notify-send "Dotter deployed!" -u low -t 2000 -a "Dotter" -c "transfer.complete"
{{#if (and (bool dotter.packages.i3) (bool auto_restart_i3))}}
  # reloads i3
  i3-msg restart
{{/if}}
