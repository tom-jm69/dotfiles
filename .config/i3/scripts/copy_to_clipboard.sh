#!/bin/bash

# Check if a file name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file-path>"
    exit 1
fi

# Assign the file path to a variable
FILE_PATH="$1"

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' does not exist."
    exit 1
fi

# Read the content of the file
CONTENT=$(cat "$FILE_PATH")

# Copy the content to the clipboard using clipmenud
echo -n "$CONTENT" | xclip -selection clipboard

# Notify the user
echo "File content copied to clipboard successfully!"
