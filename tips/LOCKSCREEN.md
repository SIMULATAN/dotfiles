Currently, I use `i3lock-color` as my lockscreen, however, if you want privacy, you should rather use `betterlockscreen`

## betterlockscreen
### Installation
```
paru -S betterlockscreen
```

### Lockscreen after sleep/suspend
_taken from the [official readme](https://github.com/betterlockscreen/betterlockscreen#systemd-service-lockscreen-after-sleepsuspend)_

```
# move service file to proper dir (the aur package does this for you)
cp betterlockscreen@.service /usr/lib/systemd/system/

# enable systemd service
systemctl enable betterlockscreen@$USER

# disable systemd service
systemctl disable betterlockscreen@$USER

# Note: Now you can call systemctl suspend to suspend your system
# and betterlockscreen service will be activated
# so when your system wakes your screen will be locked.
```
