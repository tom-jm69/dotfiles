import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot {
    // Hyprland connection
    Hyprland {
        id: hyprland
    }

    // Main bar
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        
        height: 40
        color: Theme.base
        
        RowLayout {
            anchors.fill: parent
            spacing: 10
            
            // Left side - Workspaces
            RowLayout {
                Layout.leftMargin: 10
                spacing: 5
                
                Repeater {
                    model: 10
                    
                    Rectangle {
                        width: 40
                        height: 30
                        radius: 5
                        
                        property int workspaceId: index + 1
                        property bool isActive: hyprland.focusedMonitor.activeWorkspace.id === workspaceId
                        property bool hasWindows: {
                            for (let i = 0; i < hyprland.workspaces.values.length; i++) {
                                let ws = hyprland.workspaces.values[i]
                                if (ws.id === workspaceId && ws.windows.length > 0) {
                                    return true
                                }
                            }
                            return false
                        }
                        
                        color: isActive ? Theme.mauve : (hasWindows ? Theme.surface0 : Theme.base)
                        border.color: Theme.overlay0
                        border.width: 1
                        
                        Text {
                            anchors.centerIn: parent
                            text: parent.workspaceId
                            color: parent.isActive ? Theme.base : Theme.text
                            font.pixelSize: 14
                            font.bold: parent.isActive
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                hyprland.dispatch("workspace", parent.workspaceId.toString())
                            }
                        }
                    }
                }
            }
            
            // Center - Window title
            Item {
                Layout.fillWidth: true
                
                Text {
                    anchors.centerIn: parent
                    text: hyprland.focusedMonitor.activeWorkspace.lastWindow?.title ?? "Hyprland"
                    color: Theme.text
                    font.pixelSize: 14
                    elide: Text.ElideRight
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            
            // Right side - Theme switcher and system info
            RowLayout {
                Layout.rightMargin: 10
                spacing: 10
                
                // Theme switcher button
                Rectangle {
                    width: 100
                    height: 30
                    radius: 5
                    color: Theme.surface0
                    border.color: Theme.overlay0
                    border.width: 1
                    
                    Row {
                        anchors.centerIn: parent
                        spacing: 5
                        
                        Text {
                            text: "󰏘"
                            color: Theme.text
                            font.pixelSize: 16
                            font.family: "Material Symbols Rounded"
                        }
                        
                        Text {
                            text: Theme.activeTheme.charAt(0).toUpperCase() + Theme.activeTheme.slice(1)
                            color: Theme.text
                            font.pixelSize: 12
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: themeMenu.visible = !themeMenu.visible
                    }
                }
                
                // Clock
                Text {
                    id: clockText
                    text: Qt.formatDateTime(new Date(), "hh:mm")
                    color: Theme.text
                    font.pixelSize: 14
                    
                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "hh:mm")
                    }
                }
            }
        }
    }
    
    // Theme selection popup
    PanelWindow {
        id: themeMenu
        visible: false
        
        anchors {
            top: true
            right: true
        }
        
        margins {
            top: 50
            right: 10
        }
        
        width: 150
        height: 200
        color: "transparent"
        
        Rectangle {
            anchors.fill: parent
            color: Theme.base
            border.color: Theme.overlay0
            border.width: 2
            radius: 10
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5
                
                Text {
                    text: "Select Theme"
                    color: Theme.text
                    font.pixelSize: 14
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Theme.overlay0
                }
                
                // Theme buttons
                Repeater {
                    model: ["latte", "frappe", "macchiato", "mocha"]
                    
                    Rectangle {
                        Layout.fillWidth: true
                        height: 30
                        radius: 5
                        
                        property bool isActive: modelData === Theme.activeTheme
                        color: isActive ? Theme.mauve : Theme.surface0
                        
                        Text {
                            anchors.centerIn: parent
                            text: modelData.charAt(0).toUpperCase() + modelData.slice(1)
                            color: parent.isActive ? Theme.base : Theme.text
                            font.pixelSize: 12
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                Theme.setTheme(modelData)
                                themeMenu.visible = false
                            }
                        }
                    }
                }
            }
        }
    }
}
