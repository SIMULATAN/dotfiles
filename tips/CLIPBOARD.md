// WIP

X per default doesn't persist clipboard contents after the application quit.
To circumvent this, you have to use a clipboard manager like `clipmenu`.
Note however that while clipmenu is running you can't copy images.

To setup said `clipmenu`:
- `pacman -S clipmenu`
- `systemctl --user import-environment DISPLAY`
