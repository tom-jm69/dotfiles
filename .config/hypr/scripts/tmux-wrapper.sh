#!/usr/bin/env bash

tmux () {
    if [ -n "$TMUX" ]
    then
        command tmux "$@"
        return
    fi
    if [ $# -gt 0 ]
    then
        command tmux "$@"
        return
    fi
    if tmux ls > /dev/null 2>&1
    then
        command tmux attach -t "$(tmux ls -F '#S' | head -n1)"
    else
        command tmux new
    fi
}

tmux
