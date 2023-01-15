To clean up your home directory, follow the steps described [here](https://wiki.archlinux.org/title/XDG_Base_Directory#Supported).

Here's the config that I use on my devices:
```
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.local/cache"

export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export LESSHISTFILE="/dev/null"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
# overriden by zsh
export HISTFILE="$XDG_STATE_HOME"/.shell_history
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export WINEPREFIX="$XDG_DATA_HOME"/wine

# adds the bin folder to the PATH
source "$CARGO_HOME/env"

alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
alias wget=wget --hsts-file="/dev/null"
```
You can just copy these lines into for ex. `/etc/profile.d/xdg-dir.sh`.
