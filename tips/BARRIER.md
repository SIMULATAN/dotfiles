When installing barrier, you might encounter the issue that the keyboard map is wrong.
For example: you use QWERTZ on your devices but when typing over barrier QWERTY is in use.

To fix this, run this script:
```bash
setxkbmap -device "$(xinput list --id-only 'Virtual core XTEST keyboard')" de
```
This will set they keymap to `de` for the virtual keyboard that barrier makes.
