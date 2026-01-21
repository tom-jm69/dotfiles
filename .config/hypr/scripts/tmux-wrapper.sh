#!/usr/bin/env bash
set -euo pipefail

# If we're already inside tmux, just delegate.
if [[ -n "${TMUX:-}" ]]; then
  exec tmux "$@"
fi

# If user passed any args, just delegate.
if (( $# > 0 )); then
  exec tmux "$@"
fi

# Try to get existing sessions
sessions="$(tmux list-sessions -F '#S' 2>/dev/null || true)"

if [[ -n "$sessions" ]]; then
  first_session="$(printf '%s\n' "$sessions" | head -n1)"
  exec tmux attach -t "$first_session"
else
  exec tmux new-session
fi
