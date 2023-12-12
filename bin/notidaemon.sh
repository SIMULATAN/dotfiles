#!/bin/bash

# not working in systemd unit files
# github_key="$(secret-tool lookup server github key password)"
github_key="$(cat "$HOME"/.local/share/github_key)"
user_id="$(curl 'https://api.github.com/user' -H "Authorization: Bearer $github_key" | jq '.id')"

function notify() {
  dunstify -a Notidaemon -t 10000 -i github "$@"
}

function notify_url() {
  notify "$@" --action 'default,Open in Browser'
}

function extract() {
  echo "$current_json" | jq -r ".$1"
}

function url_callback() {
  if [[ "$2" == "default" ]]; then
    # TODO: add referrer id
    xdg-open "$url"
    echo "opening $url"
  fi
}

function release() {
  repo="$(extract 'repository.full_name')"
  release="$(extract 'subject.title')"
  url="https://github.com/$repo/releases/tag/$(extract 'subject.title')"
  url_callback "$url" "$(notify_url "$repo: New release" "$release was just released!")" &
}

function pullrequest() {
  repo="$(extract 'repository.full_name')"
  title="$(extract 'subject.title')"
  url=$("https://github.com/$repo/pull/$(extract 'subject.url' | rev | cut -d '/' -f 1 | rev)")
  url_callback "$url" "$(notify_url "$repo: PR Activity" "$title")" &
}

function discussion() {
  repo="$(extract 'repository.full_name')"
  title="$(extract 'subject.title')"
  # TODO: somehow figure out URL
  notify "$repo: Discussion activity" "$title"
}

function issue() {
  repo="$(extract 'repository.full_name')"
  title="$(extract 'subject.title')"
  url="https://github.com/$repo/issues/$(extract 'subject.url' | rev | cut -d '/' -f 1 | rev)"
  url_callback "$url" "$(notify_url "$repo: Issue activity" "$title")" &
}

STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
SENT_FILE="$STATE_HOME/sent-github-notifications.list"

function run_cycle() {
  curl https://api.github.com/notifications -H "Authorization: Bearer $github_key" | jq -c '.[]' | while read -r element; do
    notification_id="$(echo "$element" | jq -r '.id')"

    # skip notifications that were sent previously
    grep "$notification_id" "$SENT_FILE" >/dev/null && continue

    func="$(echo "$element" | jq -r '.subject.type' | tr '[:upper:]' '[:lower:]')"
    if [[ ! $(type -t "$func") == function ]]; then
      echo "Sender for type $func not found!" >&2
      continue
    fi

    export current_json="$element"
    if $func; then
      echo "Executing sender for '$func' worked!"
      # save ID to avoid re-sending
      echo "$notification_id" >> "$SENT_FILE"
    else
      echo "Error executing sender for '$func'!" >&2
    fi
  done
}

while true; do
  run_cycle
  sleep 10
done
