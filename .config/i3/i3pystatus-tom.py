from i3pystatus import Status
from i3pystatus.updates import aptget
from i3pystatus.weather import openweathermap

status = Status(logfile="/home/tom/i3pystatus.log")

green = "#1A8C01"
white = "#FFFFFF"
purple = "#D175FF"
red = "#ff5555"
blue = "#4581DD"
yellow = "#DDDD11"

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week

# # Displays whether a DHCP client is running
# status.register("runwatch",
#     name="DHCP",
#     path="/var/run/dhclient*.pid",)

# # OpenVPN status
# status.register("runwatch",
#     name="VPN",
#     path="/var/run/openvpn.pid"￼,)


#status.register(
#    "openvpn",
#    vpn_name=" VPN",
#    on_leftclick="gnome-control-center",
#    status_command="bash -c 'nmcli co show id Home | grep GENERAL.STATE && echo ActiveState=active | grep ActiveState=active'",
#)

status.register(
    "weather",
    format="{current_temp}°C {icon} {humidity}% ",
    color=white,
    backend=openweathermap.Openweathermap(
        city="Rosenheim",
        appid="e9257f0320526df457428b6c5c4b502f",
    ),
)

status.register(
    "network",
    interface="wlp0s20f3",
    color_down=red,
    format_up=" 󰖩  ",
    format_down=" 󰖪 ",
    on_leftclick="nmcli radio wifi `nmcli r wifi | grep enabled -c | sed -e 's/1/off/' | sed -e 's/0/on/'`",
    interval=2,
)

status.register(
    "network",
    interface="enx000ec6c61fbb",
    color_down=red,
    format_up=" 󱊪 ",
    format_down=" 󰌙 ",
    on_leftclick="nm-connection-editor",
    interval=2,
)
# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)

status.register(
    "load",
    color=blue,
    on_leftclick="alacritty -e=htop",
    format=" 󰝲 load: {avg1} | {avg5} | {avg15} ",
)

status.register(
    "mem",
    color=white,
    warn_color="#E5E500",
    alert_color="#FF1919",
    on_leftclick="alacritty -e=htop",
    format="   {avail_mem}/{total_mem} GB ",
    divisor=1073741824,
)

status.register(
    "disk",
    color=green,
    path="/home",
    on_leftclick="pcmanfm",
    format=" {avail} GB / {total} GB ",
    critical_color=red,
)

status.register(
    "backlight",
    interval=5,
    format="   {percentage:.0f}% ",
    backlight="intel_backlight",
    on_leftclick="xbacklight -inc 5",
    on_rightclick="xbacklight -dec 5",
)

status.register(
    "battery",
    battery_ident="BAT0",
    interval=5,
    format="{status}   {percentage:.0f}% ",
    alert=True,
    alert_percentage=15,
    color="#FFFFFF",
    critical_color="#FF1919",
    charging_color="#E5E500",
    full_color=green,
    status={
        "DIS": "  ",
        "CHR": "   ",
        "FULL": " ",
    },
)

status.register(
    "updates",
    color=yellow,
    format=" Updates: {count} ",
    format_working=" In progress ",
    format_no_updates=" No updates ",
    backends=[aptget.AptGet()],
)

status.register(
    "pulseaudio",
    color_unmuted="#98C379",
    color_muted="#E06C75",
    format_muted=" 󰓄 ",
    format=" 󰜟  {volume}% ",
    on_leftclick="pactl set-sink-mute 0 toggle",
    on_rightclick="pavucontrol",
    on_upscroll="pactl set-sink-volume 0 +5%",
    on_downscroll="pactl set-sink-volume 0 -5%",
)

status.register(
    "clock",
    format=(" %A %d %B %H:%M:%S - KW: %V ", "Europe/Berlin"),
    color=blue,
)

status.register(
    "keyboard_locks",
    format=" {caps}",
    caps_on="🛑 Caps Lock ",
    caps_off="",
    color="#e60053",
)

status.run()
