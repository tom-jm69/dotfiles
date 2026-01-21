pragma Singleton
import Quickshell
import QtQuick

Singleton {
    // Match your waybar CSS variables conceptually:
    // background/foreground + color7/color9 etc.
    readonly property color background: "#111111"
    readonly property color foreground: "#eeeeee"

    readonly property color color7:  "#cfcfcf"  // like @color7
    readonly property color color9:  "#ff6a88"  // like @color9 (hover accent)

    // You can add more (color0..color15) if you want.
}
