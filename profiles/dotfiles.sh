function dotfiles() {
  if [ "$1" != "" ]; then
    INPUT=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    if [ "$INPUT" = "github" ] || [ "$INPUT" = "repo" ]; then
      # run in subshell to prevent current shell from cd'ing into the dotfiles repo
      # do in subshell to prevent CDing in current session
      (
        cd {{dotter.current_dir}} \ && export REPO="$(git config --get remote.origin.url)" \
        && [[ ! "$REPO" =~ "^http" ]] && REPO="$(echo $REPO | sed 's/:/\//' | sed 's/git@/https:\/\//g')" || : \
        && [ "$REPO" != "" ] \
          && ((xdg-open "$REPO" &) && echo "Opened '$REPO' in your Browser.") \
          || echo "No git repo found."
      )
      return 0
    elif [ -d "{{dotter.current_dir}}/$1" ]; then
      cd {{dotter.current_dir}}/$1
      pwd
    else
      echo Directory \'$1\' not found.
      return 1
    fi
  else
    cd {{dotter.current_dir}}
  fi
  # show all files, except for "." and ".." (current / upper directory)
  ls -a -I "." -I ".."
}


