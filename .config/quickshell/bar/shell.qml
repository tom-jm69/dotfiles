// ~/.config/quickshell/bar/shell.qml

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC

import "."

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 52
    exclusiveZone: implicitHeight

    color: "transparent"

    property string fontFamily: "CodeNewRoman Nerd Font Propo"
    property int fontSize: 30

    property color panelBg: Qt.rgba(Theme.background.r, Theme.background.g, Theme.background.b, 0.6)
    property color fg: Theme.color7
    property color hover: Theme.color9

    property color battCharging: "#26a65b"
    property color battWarning: "#ffbe61"
    property color battCritical: "#f53c3c"

    PersistentProperties {
        id: persist
        property bool expanded: false
        property bool calOpen: false
    }

    // =========================================================
    // Components
    // =========================================================

    component Pill: Rectangle {
        radius: 10
        color: root.panelBg
        implicitHeight: 38

        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.06)

        property int pad: 7
        property int spacing: 6
    }

    component HoverText: Item {
        id: ht
        property alias text: t.text
        property color normalColor: root.fg
        property color hoverColor: root.hover
        property bool hovered: ma.containsMouse

        signal clicked(var mouse)
        signal rightClicked(var mouse)

        implicitWidth: t.implicitWidth
        implicitHeight: t.implicitHeight

        Text {
            id: t
            anchors.centerIn: parent
            color: ht.hovered ? ht.hoverColor : ht.normalColor
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onClicked: (mouse) => {
                if (mouse.button === Qt.RightButton) ht.rightClicked(mouse)
                else ht.clicked(mouse)
            }
        }
    }

    // =========================================================
    // Stats / processes for drawer modules
    // =========================================================

    property int cpuUsage: 0
    property int memUsage: 0
    property string tempText: "?"

    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var p = data.trim().split(/\s+/)
                if (p.length < 8) return
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = 0
                for (var i = 1; i <= 7; i++) total += parseInt(p[i])
                if (root.lastCpuTotal > 0 && (total - root.lastCpuTotal) > 0) {
                    root.cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)))
                }
                root.lastCpuTotal = total
                root.lastCpuIdle = idle
            }
        }
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | awk '/Mem:/ {printf(\"%d\\n\", ($3/$2)*100)}'"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                root.memUsage = parseInt(data.trim()) || 0
            }
        }
    }

    Process {
        id: tempProc
        command: ["sh", "-c", "sensors 2>/dev/null | awk '/Package id 0:|Tctl:|temp1:/ {print $4; exit}' | tr -d '+°C'"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var t = data.trim()
                root.tempText = t.length ? t : "?"
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
            tempProc.running = true
        }
        Component.onCompleted: {
            cpuProc.running = true
            memProc.running = true
            tempProc.running = true
        }
    }

    // =========================================================
    // Network (nmcli)
    // =========================================================

    property string netIcon: " "
    property string netTooltip: "Error"

    Process {
        id: netProc
        command: ["sh", "-c",
            "if nmcli -t -f DEVICE,TYPE,STATE dev status | grep -q ':wifi:connected'; then " +
              "ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1==\"yes\"{print $2; exit}'); " +
              "sig=$(nmcli -t -f active,signal dev wifi | awk -F: '$1==\"yes\"{print $2; exit}'); " +
              "echo \"WIFI|$ssid|$sig\"; " +
            "elif nmcli -t -f DEVICE,TYPE,STATE dev status | grep -q ':ethernet:connected'; then " +
              "dev=$(nmcli -t -f DEVICE,TYPE,STATE dev status | awk -F: '$2==\"ethernet\" && $3==\"connected\"{print $1; exit}'); " +
              "echo \"ETH|$dev|\"; " +
            "else " +
              "echo \"DOWN||\"; " +
            "fi"
        ]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split("|")
                var kind = parts[0]
                if (kind === "WIFI") {
                    root.netIcon = " "
                    root.netTooltip = `${parts[1]} (${parts[2]}%)  `
                } else if (kind === "ETH") {
                    root.netIcon = " "
                    root.netTooltip = `${parts[1]} 🖧 `
                } else {
                    root.netIcon = " "
                    root.netTooltip = "Error"
                }
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: netProc.running = true
        Component.onCompleted: netProc.running = true
    }

    // =========================================================
    // Bluetooth (bluetoothctl)
    // =========================================================

    property string btIcon: "󰂲"
    property string btTooltip: "Bluetooth"

    Process {
        id: btProc
        command: ["sh", "-c",
            "pow=$(bluetoothctl show 2>/dev/null | awk -F': ' '/Powered:/ {print $2}'); " +
            "if [ \"$pow\" = \"yes\" ]; then " +
              "dev=$(bluetoothctl info 2>/dev/null | awk -F': ' '/Name:/ {print $2; exit}'); " +
              "if [ -n \"$dev\" ]; then echo \"ON|$dev\"; else echo \"ON|\"; fi; " +
            "else " +
              "echo \"OFF|\"; " +
            "fi"
        ]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split("|")
                var kind = parts[0]
                var name = parts[1] || ""
                if (kind === "ON") {
                    root.btIcon = "󰂯"
                    root.btTooltip = name.length ? `${name} 󰂯` : "Bluetooth on"
                } else {
                    root.btIcon = "󰂲"
                    root.btTooltip = "Bluetooth off/disabled"
                }
            }
        }
    }

    Timer {
        interval: 4000
        running: true
        repeat: true
        onTriggered: btProc.running = true
        Component.onCompleted: btProc.running = true
    }

    // =========================================================
    // Layout
    // =========================================================

    RowLayout {
        anchors.fill: parent
        spacing: 10

        // ---------------- LEFT ----------------
        Pill {
            Layout.leftMargin: 10
            Layout.topMargin: 10
            Layout.bottomMargin: 5
            implicitWidth: leftRow.implicitWidth + pad * 2

            Row {
                id: leftRow
                anchors.verticalCenter: parent.verticalCenter
                x: parent.pad
                spacing: parent.spacing

                HoverText {
                    text: ""
                    onClicked: (_) => Quickshell.execDetached(["sh", "-lc", "swaync-client -t -sw"])
                }

                HoverText {
                    id: clock
                    text: Qt.formatDateTime(new Date(), "HH:mm") + "  "
                    onClicked: (_) => persist.calOpen = !persist.calOpen

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm") + "  "
                    }
                }

                Row {
                    spacing: 10
                    Repeater {
                        model: SystemTray.items
                        delegate: Item {
                            width: 24
                            height: 24

                            Image {
                                anchors.centerIn: parent
                                width: 20
                                height: 20
                                source: modelData.icon
                                fillMode: Image.PreserveAspectFit
                                smooth: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                                onClicked: (mouse) => {
                                    if (mouse.button === Qt.LeftButton) modelData.activate()
                                    else if (mouse.button === Qt.RightButton) modelData.secondaryActivate()
                                    else modelData.activate()
                                }
                                onWheel: wheel => modelData.scroll(wheel.angleDelta.y)
                            }
                        }
                    }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // ---------------- CENTER ----------------
        Pill {
            Layout.topMargin: 10
            Layout.bottomMargin: 5
            implicitWidth: wsRow.implicitWidth + pad * 2

            Row {
                id: wsRow
                anchors.verticalCenter: parent.verticalCenter
                x: parent.pad
                spacing: 2

                Repeater {
                    model: 5
                    delegate: Text {
                        property int wsId: index + 1
                        property var wsObj: Hyprland.workspaces.values.find(w => w.id === wsId)
                        property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wsId

                        text: ""
                        font.family: root.fontFamily
                        font.pixelSize: root.fontSize
                        verticalAlignment: Text.AlignVCenter

                        color: isActive
                               ? root.hover
                               : (wsObj ? Qt.rgba(root.hover.r, root.hover.g, root.hover.b, 0.4) : Qt.rgba(0, 0, 0, 0))

                        style: Text.Outline
                        styleColor: wsObj ? Qt.rgba(0,0,0,0) : Qt.rgba(0,0,0,0.35)

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Hyprland.dispatch("workspace " + wsId)
                        }
                    }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // ---------------- RIGHT ----------------
        Pill {
            Layout.rightMargin: 10
            Layout.topMargin: 10
            Layout.bottomMargin: 5
            implicitWidth: rightRow.implicitWidth + pad * 2

            Row {
                id: rightRow
                anchors.verticalCenter: parent.verticalCenter
                x: parent.pad
                spacing: parent.spacing

                // drawer
                Row {
                    spacing: 6

                    HoverText {
                        text: ""
                        normalColor: Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.2)
                        hoverColor: Qt.rgba(1, 1, 1, 0.2)
                        onClicked: (_) => persist.expanded = !persist.expanded
                    }

                    Item {
                        width: persist.expanded ? drawerRow.implicitWidth : 0
                        height: drawerRow.implicitHeight
                        clip: true
                        Behavior on width { NumberAnimation { duration: 600 } }

                        Row {
                            id: drawerRow
                            spacing: 6

                            HoverText {
                                id: cp
                                text: "{}"
                                onClicked: (_) => Quickshell.execDetached(["sh", "-lc", "~/.config/waybar/scripts/colorpicker.sh"])
                                QQC.ToolTip.visible: hovered
                                QQC.ToolTip.text: "Colorpicker"
                            }

                            HoverText {
                                id: mem
                                text: " "
                                QQC.ToolTip.visible: hovered
                                QQC.ToolTip.text: `Memory: ${root.memUsage}%`
                            }

                            HoverText {
                                id: cpu
                                text: "󰻠"
                                QQC.ToolTip.visible: hovered
                                QQC.ToolTip.text: `CPU: ${root.cpuUsage}%`
                            }

                            HoverText {
                                id: tmp
                                text: ""
                                QQC.ToolTip.visible: hovered
                                QQC.ToolTip.text: `Temp: ${root.tempText}°C`
                            }

                            Text {
                                text: "|"
                                font.family: root.fontFamily
                                font.pixelSize: root.fontSize
                                color: "transparent"
                                style: Text.Outline
                                styleColor: Qt.rgba(0, 0, 0, 0.9)
                            }
                        }
                    }
                }

                HoverText {
                    id: bt
                    text: root.btIcon
                    onRightClicked: (_) => Quickshell.execDetached(["sh", "-lc", "blueman-manager"])
                    QQC.ToolTip.visible: hovered
                    QQC.ToolTip.text: root.btTooltip
                }

                HoverText {
                    id: net
                    text: root.netIcon
                    onClicked: (_) => Quickshell.execDetached(["sh", "-lc", "nm-connection-editor"])
                    QQC.ToolTip.visible: hovered
                    QQC.ToolTip.text: root.netTooltip
                }

                Text {
                    id: batt
                    font.family: root.fontFamily
                    font.pixelSize: root.fontSize
                    verticalAlignment: Text.AlignVCenter

                    property var dev: UPower.displayDevice
                    property int cap: dev ? Math.round(dev.percentage * 100) : 0
                    property bool charging: dev && (dev.state === UPowerDeviceState.Charging || dev.state === UPowerDeviceState.PendingCharge)

                    text: charging ? `${cap}% 󰂄` : `${cap}% ${batteryIcon(cap)}`
                    color: batteryColor(cap, charging)

                    function batteryIcon(p) {
                        if (p >= 90) return "󰁹"
                        if (p >= 70) return "󰂂"
                        if (p >= 50) return "󰂀"
                        if (p >= 30) return "󰁾"
                        if (p >= 15) return "󰁼"
                        return "󰁻"
                    }

                    function batteryColor(p, isCharging) {
                        if (isCharging) return root.battCharging
                        if (p <= 20) return root.battCritical
                        if (p <= 30) return root.battWarning
                        return root.fg
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: batt.color = root.hover
                        onExited: batt.color = batt.batteryColor(batt.cap, batt.charging)
                    }
                }
            }
        }
    }

    // =========================================================
    // Calendar popup
    // =========================================================

    PopupWindow {
        id: calPopup
        parentWindow: root
        visible: persist.calOpen

        relativeX: 10
        relativeY: root.implicitHeight + 6

        width: 360
        height: 320

        Rectangle {
            anchors.fill: parent
            radius: 12
            color: Theme.background
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.08)

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 8

                Text {
                    text: Qt.formatDateTime(new Date(), "dddd, MMMM dd, yyyy")
                    color: Theme.color7
                    font.family: root.fontFamily
                    font.pixelSize: 18
                }

                QQC.Control {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    property date currentMonth: new Date()

                    contentItem: ColumnLayout {
                        spacing: 6

                        RowLayout {
                            Layout.fillWidth: true

                            QQC.ToolButton {
                                text: "‹"
                                onClicked: currentMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth() - 1, 1)
                            }

                            QQC.Label {
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignHCenter
                                text: Qt.formatDateTime(currentMonth, "MMMM yyyy")
                            }

                            QQC.ToolButton {
                                text: "›"
                                onClicked: currentMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth() + 1, 1)
                            }
                        }

                        QQC.DayOfWeekRow { Layout.fillWidth: true }

                        QQC.MonthGrid {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            month: currentMonth.getMonth()
                            year: currentMonth.getFullYear()

                            delegate: QQC.Label {
                                required property date date
                                required property int day
                                required property int month
                                required property int year
                                required property bool today
                                required property bool inMonth

                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                opacity: inMonth ? 1.0 : 0.35
                                text: day

                                font.underline: today
                                font.bold: today
                            }
                        }
                    }
                }
            }
        }

        onVisibleChanged: {
            if (!visible) persist.calOpen = false
        }
    }
}
