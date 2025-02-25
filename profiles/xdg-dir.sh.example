# pretty useless in ~/.profiles - source in `/etc/profile.d` instead!

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
export HISTFILE="$XDG_STATE_HOME"/.shell_history
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

source "$CARGO_HOME/env"
PATH="$PWD/.local/bin:$PATH"

export KUBECACHEDIR="$XDG_CACHE_HOME/kube/cache"

export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
