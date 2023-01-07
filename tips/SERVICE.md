Here's a systemd service file to automatically deploy configuration changes.
Deploy to `/etc/systemd/system/dotter.service` and don't forget to `systemctl enable --now dotter` to start the service and enable autostart.

```toml
[Unit]
Description=Dotter Watch
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=<myuser>
Environment="DISPLAY=:0"
ExecStart=/usr/bin/env bash -c 'echo "Starting watch..." &&  cd /path/to/dotfiles && ./dotter watch'

[Install]
WantedBy=multi-user.target
```
