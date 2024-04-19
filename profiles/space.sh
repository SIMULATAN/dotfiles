function space() {
  function warn() {
    printf "\x1b[1;33m[WARNING] %s\n" "$*"
  }

  # user will be warned if permissions aren't given
  function hasPerms() {
    test -r . || { warn "No permissions for this folder"; return 1; }
    for file in ./*; do
      test -r "$file" || { warn "No permissions for folder / file $file"; return 1; }
    done
    return 0
  }

  if ! hasPerms; then
    warn "You don't have read permissions for some files in this folder!"
  fi
  # du with human output | filter empty | sort human output, reversed
  du -h . --max-depth="${1:-1}" 2>/dev/null | grep -v '^0\s' | sort -hr
}
