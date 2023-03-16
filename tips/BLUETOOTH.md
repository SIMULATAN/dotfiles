I use `bluez` for bluetooth. As a frontend for it, [bluetuith](https://github.com/darkhz/bluetuith) works well.

### Systemd Service
Normally, you'd have to run `/lib/bluetooth/bluetoothd` and leave the terminal open, but as an alternative to that, you can also create a systemd service for it.

```toml
[Unit]
Description=Bluetooth Daemon
After=multi-user.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=/lib/bluetooth/bluetoothd

[Install]
WantedBy=default.target
```

Copy the contents of this file to `/etc/systemd/system/bluetooth.service`.
