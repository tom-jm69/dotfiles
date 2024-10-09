#!/bin/bash
# shellcheck disable=2034

NUM_PASSWORDS=20
PASSWORD_LENGTH=7

special_chars=("~" "!" "@" "#" "$" "%" "^" "&" "*" "(" ")" "_" "-" "+" "=" "{" "[" "}" "]" "|" "\\" ":" ";" "<" ">" "," "." "?" "/")

for i in $(seq 1 $NUM_PASSWORDS); do
    words=$(shuf --random-source=/dev/urandom -n$PASSWORD_LENGTH /usr/share/dict/words)
    password=""

    # Insert a number at the beginning of the password
    password+="$(shuf -i 0-9 -n 1)-"

    for word in $words; do
        if [ $((RANDOM % 2)) -eq 0 ]; then
            random_char=${special_chars[RANDOM % ${#special_chars[@]}]}
            password+="$word$random_char-"
        else
            random_case=$((RANDOM % 2))
            if [ $random_case -eq 0 ]; then
                password+="${word,,}-" # Convert word to lowercase and add it to the password
            else
                password+="${word^^}-" # Convert word to uppercase and add it to the password
            fi
        fi
  done

    # Insert a number at the end of the password
    password+="$(shuf -i 0-9 -n 1)"

    password=$(echo "$password" | tr -d "'" | tr -d '"') # Remove single and double quotes
	echo "$password"
done
