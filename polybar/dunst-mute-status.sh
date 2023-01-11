# don't remove the brackets or it'll use the exit status rather than the "true" or "false" that the command prints
# to decide what to print
$(dunstctl is-paused) && echo "Dunst muted" || echo
