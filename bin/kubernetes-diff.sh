#!/bin/bash

# Thanks to https://www.reddit.com/r/kubernetes/comments/i0zbcl/comment/fzzjnjt/

deletes=(
  '.metadata.annotations."deprecated.daemonset.template.generation"'
  '.metadata.annotations."argocd.argoproj.io/tracking-id"'
  '.metadata.annotations."kubectl.kubernetes.io/last-applied-configuration"'
  '.metadata.annotations | select(length==0)'
  '.metadata.labels."argocd.argoproj.io/instance"'
  '.metadata.labels."kubectl.kubernetes.io/last-applied-configuration"'
  '.metadata.labels | select(length==0)'
)
deletes=("${deletes[@]/#/del(}")
deletes=("${deletes[@]/%/)}")

function join_by { local IFS="$1"; shift; echo "$*"; } # https://stackoverflow.com/a/17841619/21038281
delete="$(join_by '|' "${deletes[@]}")"

for file in "$1"/* "$2"/*; do
  yq -Y -i "$delete" "$file" # clean up LIVE and MERGED files
done |& grep -v '/*: no such file or directory' # https://stackoverflow.com/a/16321435/21038281

diff_args=(
  "--minimal"
  "--width=120"
  "-u"
  "-N"
)
if [[ ! $ANSIBLE_MODE = YES ]]; then
  diff_args+=("--color=always")
fi

diff "${diff_args[@]}" "$@" | awk '!/^diff/ {if ($1 ~ /(---|\+\+\+)/) {print $1, $2} else {print $0}}'
