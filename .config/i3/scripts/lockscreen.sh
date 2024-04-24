#!/bin/bash

# Open alacritty in fullscreen, run your command, then close alacritty
#!/bin/bash
# Open alacritty in fullscreen, run your command
alacritty -e sh -c 'cowsay $(fortune) | dvdts -a; read -n1 -s'

# Lock the screen immediately after alacritty closes

# Lock the screen immediately after
