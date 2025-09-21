command -v hcloud &>/dev/null \
  && HCLOUD_TOKEN="$(grep 'token' "$XDG_CONFIG_HOME/hcloud/cli.toml" | cut -d '=' -f 2 | cut -d '"' -f 2)" \
  || true
