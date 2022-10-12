alias cya="exit"
# average windows user
alias cls="clear"

# same as OMZ's "gdca", but with one char less
# prime efficiency!
alias gdc="git diff --cached"

alias o="xdg-open"

# v because of "vim"
alias v="$EDITOR"
alias e="$EDITOR"

# for some reason, zsh-autosuggestions doesn't recognize this as an alias
function fuck() {
  sudo $(fc -ln -1)
}
