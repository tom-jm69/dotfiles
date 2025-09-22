#!/usr/bin/env bash
set -euo pipefail

# --- Config ---
KEY_FILE="$HOME/.humorapikey"
API_URL_BASE="https://api.humorapi.com/memes/random"
ASSETS_DIR="$HOME/.config/hypr/assets"
LOCK_IMG="$ASSETS_DIR/lock-image.png"   # always overwritten here

TMP_DIR="$(mktemp -d)"
JSON_PATH="$TMP_DIR/meme.json"
MEME_ORIG="$TMP_DIR/meme_original"

# --- Requirements ---
for bin in curl jq convert; do
  command -v "$bin" >/dev/null 2>&1 || { echo "Error: $bin is required"; exit 1; }
done

[[ -f "$KEY_FILE" ]] || { echo "API key file not found: $KEY_FILE"; exit 1; }
API_KEY="$(head -n1 "$KEY_FILE" | tr -d '[:space:]')"
[[ -n "$API_KEY" ]] || { echo "API key file is empty"; exit 1; }

# --- Fetch meme JSON ---
curl -sSL "${API_URL_BASE}?api-key=${API_KEY}" -o "$JSON_PATH"

# --- Extract URL ---
IMG_URL="$(jq -r '.url' "$JSON_PATH")"
if [[ -z "$IMG_URL" || "$IMG_URL" == "null" ]]; then
  echo "Could not extract image URL from HumorAPI response:"
  cat "$JSON_PATH"
  exit 1
fi

# --- Download meme into temp file ---
mkdir -p "$ASSETS_DIR"
curl -sSL "$IMG_URL" -o "$MEME_ORIG"
[[ -s "$MEME_ORIG" ]] || { echo "Failed to download meme image: $IMG_URL"; exit 1; }

# --- Composite onto fixed 5120x2160 background, overwrite lock-image.png ---
convert "$MEME_ORIG[0]" -auto-orient -resize "5120x2160>" \
        -background black -gravity center -extent 5120x2160 \
        "$LOCK_IMG"

# --- Start hyprlock ---
hyprlock --immediate-render
