#!/bin/bash

if [[ "$#" -lt 1 ]]; then
  echo "Please provide a file!"
fi

input_file="$1"
file_name="${input_file/.local/}"
secret_name="${file_name/.env/}"
secret_name="${secret_name/.env/}"
secret_name="${secret_name/.yml/}"
output_file="$secret_name.yml"

if [[ -n "$2" ]]; then
  namespace_arg=(-n "$2")
fi

secret="$(kubectl create secret generic "$secret_name" --dry-run=client --from-env-file="$input_file" -o json "${namespace_arg[@]}")"

if ! echo "$secret" | kubeseal -w "$output_file"; then
  echo "Failed writing!"
  exit 1
fi

echo "Successfully wrote secret to '$output_file'"

if command -v yq &>/dev/null; then
  secret="$(yq -P 'del(.metadata.creationTimestamp, .spec.template.metadata.creationTimestamp)' "$output_file")"
  echo "$secret" | tail -n +2 > "$output_file"
fi
