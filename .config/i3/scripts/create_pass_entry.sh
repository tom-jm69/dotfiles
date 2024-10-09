#!/bin/bash

# Vorgabepfad aus pass fzf -s
default_entry_path=$(pass fzf -s $@)

# Überprüfen, ob ein Pfad ausgewählt wurde
if [ -z "$default_entry_path" ]; then
  echo "No path selected."
  exit 1
fi

# Benutzereingabe mit vorausgefülltem Pfad
# Die -e Option erlaubt die Verwendung von readline, und -i setzt den initialen Text
read -e -i "$default_entry_path" -p "Enter path and url: " entry_path
entry_path=${entry_path:-$default_entry_path}

default_password=$(~/.config/i3/scripts/password.sh | head -1)
read -e -i "$default_password" -p "Enter password: " password
password=${password:-$default_password}

read -p "Enter username: " username

# Eintrag in pass erstellen
pass_entry="user: $username
pass: $password"

echo "$password" | pass insert -m "$entry_path"
echo "$pass_entry" | pass insert -m "$entry_path"

echo "$password" | tr -d '\n' | xclip
