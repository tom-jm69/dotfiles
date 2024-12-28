#!/bin/bash
#
# Script Name    : sshs.sh
# Description    : Simplifies SSH host selection and connection.
# Author         : Johannes Gründl
# Date           : 2024-01-11
# Version        : 1.0.1
# Usage          : ./sshs.sh [-a] [-h] [HOST_NAME]
#


display_help() {
    echo "Simplifies SSH host selection and connection"
    echo "This script uses 'fzf' for interactive host selection"
    echo "https://github.com/junegunn/fzf"
    echo ""
    echo "SSH configuration files are expected in"
    echo "~/.ssh/config"
    echo ""
    echo "Usage: ./sshs.sh [-a] [-h] [HOST_NAME]"
    echo ""
    echo "Options:"
    echo "  -a            : Display the content of SSH configuration files."
    echo "  -h            : Display this help message."
    echo "  HOST_NAME     : Specify the name of the SSH host to connect to interactively."
    echo ""
    exit 0
}

export alias ssh='TERM=xterm-256color ssh'
display_host_content() {
    find "$@" -type f -exec sh -c 'echo "Path: $0"; cat "$0"' {} \;
}

select_host() {
    if [ -n "$1" ]; then
        selected_host=$(echo "$host_list" | fzf --ansi --query "$1")
    else
        selected_host=$(echo "$host_list" | fzf --ansi)
    fi
}

display_config_and_ssh() {
    echo "$preview_hosts" | awk -v pattern="$1" '
        BEGIN { RS="\n\n" }
    $0 ~ pattern { print $0 "\n" }'
    ssh "$1"
    exit 0
}

# Handle the help option
if [ "$1" == "-h" ]; then
    display_help
fi

# Collect and display the list of available hosts
if [ "$1" = "-a" ]; then
    display_host_content ~/.ssh/config
    exit
fi

# Read the list of hosts
preview_hosts=$(display_host_content ~/.ssh/config)

# Extract the list of hosts (Host and HostName in parentheses)
host_list=$(echo "$preview_hosts" | grep -E '^Host |^HostName ' | \
        while read -r line; do
        if [[ "$line" =~ ^Host\ (.*) ]]; then
            host="${BASH_REMATCH[1]}"
            echo $host
        elif [[ "$line" =~ ^HostName\ (.*) ]]; then
            hostname="${BASH_REMATCH[1]}"
            echo "$host ($hostname)"
        fi
done)
host_list=$(echo "$preview_hosts" | grep 'Host ' | cut -d ' ' -f2 | tr ' ' '\n')

# If a specific host is provided as an argument, display its configuration and SSH into it
if [ -n "$1" ]; then
    for current_host in $host_list; do
        if [[ "$current_host" == "$1"* ]]; then
            display_config_and_ssh "$1"
        fi
    done
fi

# If a specific host was not provided as an argument, prompt the user to select one
select_host "$1"

# Extract only the Host name (without parentheses) for SSH connection
if [ -n "$selected_host" ]; then
    # Remove everything after the first space (to remove the HostName in parentheses)
    clean_host=$(echo "$selected_host" | awk '{print $1}')
    display_config_and_ssh "$clean_host"
else
    echo "No host selected. Exiting..."
    exit 1
fi
