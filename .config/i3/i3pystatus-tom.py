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


status.register(
    "openvpn",
    vpn_name=" VPN",
    on_leftclick="gnome-control-center",
    # status_command="bash -c 'nmcli co show id Home | grep connected && echo ActiveState=active | grep ActiveState=active'",)
    status_command="bash -c 'nmcli co show id Home | grep GENERAL.STATE && echo ActiveState=active | grep ActiveState=active'",
)
#apiurl= https://api.openweathermap.org/data/2.5/weather?q=Rosenheim&appid=e9257f0320526df457428b6c5c4b502f

status.register(
    "weather",
    format=" {current_temp}°C {humidity}% {icon}",
    color=purple,
    backend=openweathermap.Openweathermap(
        city="Rosenheim",
        appid="e9257f0320526df457428b6c5c4b502f",
    ),
)
# Note: the network module requires PyPI package netifaces
status.register(
    "network",
    interface="enx000ec6c61fbb",
    color_down=red,
    format_up=" 🌤 eth0: {v4cidr}",
)

# Note: requires both netifaces and basiciw (for essid and quality)

status.register(
    "network",
    interface="wlp0s20f3",
    color_down=red,
    format_up=" wlan: {v4cidr} {quality:03.0f} %)",
)


# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)

status.register(
    "load",
    color=white,
    on_leftclick="alacritty -e=htop",
    format=" 🖥 load: {avg1} | {avg5} | {avg15}",
)

status.register(
    "mem",
    color=white,
    warn_color="#E5E500",
    alert_color="#FF1919",
    on_leftclick="alacritty -e=htop",
    format=" {avail_mem}/{total_mem} GB",
    divisor=1073741824,
)

status.register(
    "disk",
    color=white,
    path="/home",
    on_leftclick="pcmanfm",
    format=" {avail} GB",
)

status.register(
    "backlight",
    interval=5,
    format="  {percentage:.0f}% ",
    backlight="intel_backlight",
)

status.register(
    "battery",
    battery_ident="BAT0",
    interval=5,
    format="{status} {percentage:.0f}%",
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
    format=" Updates: {count}",
    format_working=" In progress ",
    format_no_updates=" No updates ",
    backends=[aptget.AptGet()],
)

status.register(
    "pulseaudio",
    color_unmuted="#98C379",
    color_muted="#E06C75",
    format_muted=" [muted]",
    format="  {volume}% ",
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
