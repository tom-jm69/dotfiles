#!/usr/bin/env bash


source "$HOME/dotfiles/scripts/.env"

: "${HA_TOKEN:?}"

curl -s \
  -H "Authorization: Bearer $HA_TOKEN" \
  "$HA_URL/api/states/$ENTITY" \
| jq -r '.state'
