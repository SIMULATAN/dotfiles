#!/bin/bash

if [[ "$#" -lt 1 ]]; then
  echo "Please provide a file!"
fi

input_file="$1"
file_name="${input_file/.local/}"
output_file="$file_name"
secret_name="${file_name/.yml/}"
secret_name="${secret_name/.yaml/}"

if [[ -n "$2" ]]; then
  namespace_arg=(-n "$2")
fi

secret="$(kubectl create secret generic "$secret_name" --dry-run=client --from-env-file="$input_file" -o json "${namespace_arg[@]}")"

if echo "$secret" | kubeseal -w "$output_file"; then
  echo "Successfully wrote secret to '$output_file'"
else
  echo "Failed writing!"
fi
