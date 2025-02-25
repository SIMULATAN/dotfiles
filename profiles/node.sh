command -v npm &>/dev/null || return 0
export NODE_PATH="$(npm root -g)"
