function dotfiles() {
  if [ -z "$1" ]; then
    cd "{{dotter.current_dir}}" || exit 1
  fi

  INPUT=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  if [ "$INPUT" = "git" ] || [ "$INPUT" = "github" ] || [ "$INPUT" = "repo" ]; then
    function open_github() {
      cd "{{dotter.current_dir}}" || exit
      REPO="$(git config --get remote.origin.url)"

      # git over SSH
      # replace `github.com:username` with `github.com/username` and `git@` with `https`
      [[ ! "$REPO" =~ "^http" ]] && REPO="$(echo "$REPO" | sed 's/:/\//' | sed 's/git@/https:\/\//g')"

      if [ "$REPO" != "" ]; then
        xdg-open "$REPO" &
        echo "Opened '$REPO' in your Browser."
      else
        echo "No git repo found."
      fi
    }

    # run in subshell to prevent current shell from cd'ing into the dotfiles repo
    (open_github)
    return 0
  elif [ -d "{{dotter.current_dir}}/$1" ]; then
    cd "{{dotter.current_dir}}/$1" || exit 1
    pwd
    # show all files, except for "." and ".." (current / upper directory)
    ls -A
  else
    echo "Directory '$1' not found."
    return 1
  fi
}

