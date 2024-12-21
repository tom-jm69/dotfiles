#!/bin/bash

# Define the default and alternate date formats
default_format="LC_ALL=\"de_DE.UTF-8\" date '+%A %d %B %Y' | awk '{ printf \"<span color=\\\"#ed8796\\\">%s</span> %s <span color=\\\"#ed8796\\\">%s %s</span>\n\", substr(\$1, 1, 2), \$2, \$3, \$4 }'"
alternate_format="date '+%V. KW %d.%m.%Y'"

# Check if the left button was clicked
if [ "$BLOCK_BUTTON" == "1" ]; then
    # Display the alternate format
    eval "$alternate_format"
else
    # Display the default format
    eval "$default_format"
fi
