#!/bin/bash
# faster keyboardl
# xset r rate 190 50; # speed up ubuntu keyboard repeat keys: better
#xset r rate 250 80; # speed up ubuntu keyboard repeat keys: nice
xset r rate 250 80
# set disable lock screen
echo "Set common settings"
echo "Disable lock screen"
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
xset s off
xset -dpms
xset s noblank
# Default Editor
#sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 100
#sudo update-alternatives --set editor /usr/local/bin/nvim
export VISUAL=vim
export EDITOR="$VISUAL"
# keyboard
# Get the current day of the week
day=$(date +%u)
browser=google-chrome-stable
browsermeet=google-chrome-stable
# Check if the current day is a weekend day (6 or 7)
if [ "$day" -ge 8 ]; then
    # It's a weekend, do nothing
    echo "Today is a weekend, skipping startup."
else
    # It's a weekday, start the GUI application
    echo "Today is a weekday, starting the GUI application."
    /usr/bin/nagstamon &
    #  /snap/bin/slack
    sleep 2
    i3-msg "workspace 1:tmux"
    alacritty &
    sleep 1
    i3-msg "workspace 2:tmux"
    alacritty -c tmux
    i3-msg "workspace 3:browser"
    "$browser" --new-window 'https://projekte.in2code.de/projects/in2code/agile/board?query_id=254' \
        --new-tab 'https://mail.google.com/mail/u/0/#inbox' \
        --new-tab 'https://calendar.google.com/calendar/u/0/r' \
        --new-tab 'https://tool.timetape.de/' \
        --new-tab 'https://in2code.mite.de/' &
    sleep 1
    i3-msg "workspace 8:bitwarden"
    bitwarden &
    sleep 3
    i3-msg "workspace 9:meet"
    "$browsermeet" --new-tab 'https://meet.google.com/nfh-ncqa-nqn' &
    sleep 1
    i3-msg "workspace 10:slack"
    slack >/dev/null
    if xrandr | grep -q 'DP-4 connected'; then
        i3-msg "workspace number 1; move workspace to output DP-4-1"
        i3-msg "workspace number 2; move workspace to output DP-4-1"
        i3-msg "workspace number 3; move workspace to output DP-4-1"
        i3-msg "workspace number 4; move workspace to output DP-4-1"
        i3-msg "workspace number 5; move workspace to output DP-4-1"
        i3-msg "workspace number 6; move workspace to output DP-4-1"
        i3-msg "workspace number 7; move workspace to output DP-4-1"
        i3-msg "workspace number 8; move workspace to output DP-4-2"
        i3-msg "workspace number 9; move workspace to output DP-4-2"
        i3-msg "workspace number 10; move workspace to output DP-4-2"
    fi
fi
