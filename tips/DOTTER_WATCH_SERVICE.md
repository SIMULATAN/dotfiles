Here's a systemd service file to automatically deploy configuration changes.
Deploy to `/etc/systemd/user/dotter.service` and don't forget to `systemctl enable --now --user dotter` to start the service and enable autostart.

```toml
[Unit]
Description=Dotter Watch
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
Environment="DISPLAY=:0"
ExecStart=/usr/bin/env bash -c 'echo "Starting watch..." &&  cd /home/"'$USER'"/dotfiles && ./dotter watch'

[Install]
WantedBy=default.target
```
