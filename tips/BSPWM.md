## Troubleshooting
### Workspaces in wrong order
Sometimes, for some reason, `super + 0` sends you to workspace 11 and similar.
When running `bspc query -D --names` returns workspaces in the wrong order, try `bspc monitor $(xrandr | grep primary | cut -d ' ' -f 1) -d {1..10} {a..j}`.
This will re-create the workspaces and therefore fix the ordering.
