#!/bin/bash

# Define the default and alternate date formats
default_format="LC_ALL=\"de_DE.UTF-8\" date '+%Y %B %d %A ' | awk '{ printf \"%s <span color=\\\"#ed8796\\\">%s %s</span> %s <span color=\\\"#ed8796\\\">%s%s</span>\n\", \$1, \$2, \$3, \$4, \$5, \$6 }'"
alternate_format="date '+%V. KW %d.%m.%Y'"

# Check if the left button was clicked
if [ "$BLOCK_BUTTON" == "1" ]; then
    # Display the alternate format
    eval "$alternate_format"
    # sleep 5
    eval "$default_format"

    # Wait for 5 seconds
else
    # Display the default format
    eval "$default_format"
fi
