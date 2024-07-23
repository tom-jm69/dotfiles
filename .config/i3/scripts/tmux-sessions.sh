#!/bin/bash
# Maximum number of sessions to keep
MAX_SESSIONS=5
# Function to check if nvim is running in a session
nvim_running() {
    local session_name=$1
    # Check if nvim process exists in the session
    tmux list-windows -t $session_name -F "#{window_name}" 2>/dev/null | grep -q nvim
}
# Get list of all tmux sessions
sessions=$(tmux ls -F "#{session_name}")
# Count the number of current tmux sessions
num_sessions=$(echo "$sessions" | wc -l)
# Calculate sessions to delete
sessions_to_delete=$((num_sessions - MAX_SESSIONS))
# Check if there are more than MAX_SESSIONS sessions
if [ $num_sessions -gt $MAX_SESSIONS ]; then
    # Iterate through each session
    for session_name in $sessions; do
        # Check if nvim is running in the session
        if ! nvim_running $session_name; then
            # Kill the session if nvim is not running and we still need to delete sessions
            if [ $sessions_to_delete -gt 0 ]; then
                tmux kill-session -t $session_name
                sessions_to_delete=$((sessions_to_delete - 1))
            fi
        fi
    done
fi
