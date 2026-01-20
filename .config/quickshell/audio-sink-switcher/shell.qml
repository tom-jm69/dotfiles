import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    /* =======================
       WAL THEME (DIRECT FILE)
       ======================= */
    property var wal: ({})
    property color bg: "#000000"
    property color fg: "#ffffff"
    property color accent: "#ffffff"
    property string fontFamily: "CodeNewRoman Nerd Font Propo"

    function parseWalCss(text) {
        const out = {}
        const re = /@define-color\s+([A-Za-z0-9_-]+)\s+(#[0-9A-Fa-f]{6,8})\s*;/g
        let m
        while ((m = re.exec(text)) !== null)
            out[m[1]] = m[2]
        return out
    }

    function applyWal() {
        const bgHex  = wal["background"] ?? wal["color0"]
        const fgHex  = wal["foreground"] ?? wal["color7"] ?? wal["color15"]
        const accHex = wal["color9"] ?? wal["color1"]

        if (bgHex)  bg = bgHex
        if (fgHex)  fg = fgHex
        if (accHex) accent = accHex
    }

    FileView {
        id: walCss
        path: Quickshell.env("HOME") + "/.cache/wal/colors-waybar.css"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            root.wal = root.parseWalCss(text())
            root.applyWal()
        }
    }

    Component.onCompleted: {
        root.wal = root.parseWalCss(walCss.text())
        root.applyWal()
    }

    /* =======================
       AUDIO SINK DATA
       ======================= */
    ListModel { id: sinksModel }

    function parseWpctlStatus(text) {
        sinksModel.clear()
        const lines = text.split("\n")
        let inSinks = false

        for (let raw of lines) {
            const line = raw.replace(/\r/g, "")

            if (line.match(/^\s*Sinks:\s*$/)) { inSinks = true; continue }
            if (!inSinks) continue
            if (line.match(/^\s*(Sources|Sink endpoints|Source endpoints|Filters|Streams|Clients|Video|Settings)\s*:/))
                break

            const m = line.match(/^\s*(\*)?\s*([0-9]+)\.\s*(.+)$/)
            if (!m) continue

            const isDefault = !!m[1]
            const id = m[2]
            const name = m[3].replace(/\s*\[.*$/, "").trim()

            sinksModel.append({ id, name, isDefault })
        }
    }

    function refresh() { wpctlProc.exec() }

    function setDefaultSink(idStr) {
        Quickshell.execDetached(["wpctl", "set-default", idStr])
        popup.visible = false
    }

    /* =======================
       IPC TOGGLE
       ======================= */
    IpcHandler {
        target: "audioMenu"
        function toggle() {
            popup.visible = !popup.visible
            if (popup.visible) refresh()
        }
    }

    Process {
        id: wpctlProc
        command: ["wpctl", "status"]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: root.parseWpctlStatus(text)
        }
    }

    /* =======================
       UI
       ======================= */
    FloatingWindow {
        id: popup
        visible: true   // set to false once you're happy
        width: 760
        height: Math.min(700, 140 + sinksModel.count * 64)
        color: "transparent"

        // Fake shadow: draw a darker rounded rect slightly offset behind the card.
        Rectangle {
            id: shadow
            anchors.fill: card
            anchors.leftMargin: 3
            anchors.topMargin: 3
            radius: 12
            color: Qt.rgba(0, 0, 0, 0.35)
        }

        Rectangle {
            id: card
            anchors.fill: parent
            radius: 12
            color: Qt.rgba(root.bg.r, root.bg.g, root.bg.b, 0.60)

            border.width: 1
            border.color: Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.10)

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 12

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: "Select output"
                        color: root.fg
                        font.family: root.fontFamily
                        font.pixelSize: 30
                    }

                    Item { Layout.fillWidth: true }

                    Text {
                        text: "Esc"
                        color: Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.55)
                        font.family: root.fontFamily
                        font.pixelSize: 22
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.18)
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ListView {
                        id: list
                        model: sinksModel
                        spacing: 10
                        focus: true

                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 56
                            radius: 10

                            color: isDefault
                                ? Qt.rgba(root.accent.r, root.accent.g, root.accent.b, 0.22)
                                : Qt.rgba(root.bg.r, root.bg.g, root.bg.b, 0.25)

                            border.width: isDefault ? 1 : 0
                            border.color: Qt.rgba(root.accent.r, root.accent.g, root.accent.b, 0.55)

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 12
                                spacing: 12

                                Text {
                                    text: isDefault ? "" : "󰓃"
                                    color: isDefault ? root.accent : root.fg
                                    font.family: root.fontFamily
                                    font.pixelSize: 28
                                }

                                Text {
                                    text: name
                                    color: isDefault ? root.accent : root.fg
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                    font.family: root.fontFamily
                                    font.pixelSize: 28
                                }

                                Text {
                                    text: id
                                    color: Qt.rgba(root.fg.r, root.fg.g, root.fg.b, 0.55)
                                    font.family: root.fontFamily
                                    font.pixelSize: 22
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: root.setDefaultSink(id)
                                onEntered: parent.color =
                                    Qt.rgba(root.accent.r, root.accent.g, root.accent.b, 0.28)
                                onExited: parent.color = isDefault
                                    ? Qt.rgba(root.accent.r, root.accent.g, root.accent.b, 0.22)
                                    : Qt.rgba(root.bg.r, root.bg.g, root.bg.b, 0.25)
                            }
                        }
                    }
                }
            }
        }

        Keys.onEscapePressed: popup.visible = false
        onVisibleChanged: if (visible) refresh()
        Component.onCompleted: refresh()
    }
}
