#!/bin/bash

kubernetes_version="1.31.1"
prefix="kubernetes-json-schema\/master\/v"

sed -i \
  "s/$prefix"'[[:digit:]].[[:digit:]]\+\.[[:digit:]]\+/'"$prefix$kubernetes_version"'/g' \
  "$XDG_CONFIG_HOME/coc/extensions/node_modules/coc-yaml/dist/languageserver.js"
