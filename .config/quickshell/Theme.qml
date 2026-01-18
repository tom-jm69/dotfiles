pragma Singleton
import QtQuick

QtObject {
    // Current active theme - change this to switch themes
    property string activeTheme: "macchiato" // latte, frappe, macchiato, mocha
    
    // Color properties that update based on active theme
    property color rosewater: themes[activeTheme].rosewater
    property color flamingo: themes[activeTheme].flamingo
    property color pink: themes[activeTheme].pink
    property color mauve: themes[activeTheme].mauve
    property color red: themes[activeTheme].red
    property color maroon: themes[activeTheme].maroon
    property color peach: themes[activeTheme].peach
    property color yellow: themes[activeTheme].yellow
    property color green: themes[activeTheme].green
    property color teal: themes[activeTheme].teal
    property color sky: themes[activeTheme].sky
    property color sapphire: themes[activeTheme].sapphire
    property color blue: themes[activeTheme].blue
    property color lavender: themes[activeTheme].lavender
    property color text: themes[activeTheme].text
    property color subtext1: themes[activeTheme].subtext1
    property color subtext0: themes[activeTheme].subtext0
    property color overlay2: themes[activeTheme].overlay2
    property color overlay1: themes[activeTheme].overlay1
    property color overlay0: themes[activeTheme].overlay0
    property color surface2: themes[activeTheme].surface2
    property color surface1: themes[activeTheme].surface1
    property color surface0: themes[activeTheme].surface0
    property color base: themes[activeTheme].base
    property color mantle: themes[activeTheme].mantle
    property color crust: themes[activeTheme].crust
    
    // Semantic color aliases for easier use
    property color bg: base
    property color fg: text
    property color bgAlt: mantle
    property color fgAlt: subtext1
    property color accent: mauve
    property color accentAlt: blue
    property color success: green
    property color warning: yellow
    property color error: red
    
    // All theme definitions
    readonly property var themes: ({
        "latte": {
            rosewater: "#dc8a78",
            flamingo: "#dd7878",
            pink: "#ea76cb",
            mauve: "#8839ef",
            red: "#d20f39",
            maroon: "#e64553",
            peach: "#fe640b",
            yellow: "#df8e1d",
            green: "#40a02b",
            teal: "#179299",
            sky: "#04a5e5",
            sapphire: "#209fb5",
            blue: "#1e66f5",
            lavender: "#7287fd",
            text: "#4c4f69",
            subtext1: "#5c5f77",
            subtext0: "#6c6f85",
            overlay2: "#7c7f93",
            overlay1: "#8c8fa1",
            overlay0: "#9ca0b0",
            surface2: "#acb0be",
            surface1: "#bcc0cc",
            surface0: "#ccd0da",
            base: "#eff1f5",
            mantle: "#e6e9ef",
            crust: "#dce0e8"
        },
        "frappe": {
            rosewater: "#f2d5cf",
            flamingo: "#eebebe",
            pink: "#f4b8e4",
            mauve: "#ca9ee6",
            red: "#e78284",
            maroon: "#ea999c",
            peach: "#ef9f76",
            yellow: "#e5c890",
            green: "#a6d189",
            teal: "#81c8be",
            sky: "#99d1db",
            sapphire: "#85c1dc",
            blue: "#8caaee",
            lavender: "#babbf1",
            text: "#c6d0f5",
            subtext1: "#b5bfe2",
            subtext0: "#a5adce",
            overlay2: "#949cbb",
            overlay1: "#838ba7",
            overlay0: "#737994",
            surface2: "#626880",
            surface1: "#51576d",
            surface0: "#414559",
            base: "#303446",
            mantle: "#292c3c",
            crust: "#232634"
        },
        "macchiato": {
            rosewater: "#f4dbd6",
            flamingo: "#f0c6c6",
            pink: "#f5bde6",
            mauve: "#c6a0f6",
            red: "#ed8796",
            maroon: "#ee99a0",
            peach: "#f5a97f",
            yellow: "#eed49f",
            green: "#a6da95",
            teal: "#8bd5ca",
            sky: "#91d7e3",
            sapphire: "#7dc4e4",
            blue: "#8aadf4",
            lavender: "#b7bdf8",
            text: "#cad3f5",
            subtext1: "#b8c0e0",
            subtext0: "#a5adcb",
            overlay2: "#939ab7",
            overlay1: "#8087a2",
            overlay0: "#6e738d",
            surface2: "#5b6078",
            surface1: "#494d64",
            surface0: "#363a4f",
            base: "#24273a",
            mantle: "#1e2030",
            crust: "#181926"
        },
        "mocha": {
            rosewater: "#f5e0dc",
            flamingo: "#f2cdcd",
            pink: "#f5c2e7",
            mauve: "#cba6f7",
            red: "#f38ba8",
            maroon: "#eba0ac",
            peach: "#fab387",
            yellow: "#f9e2af",
            green: "#a6e3a1",
            teal: "#94e2d5",
            sky: "#89dceb",
            sapphire: "#74c7ec",
            blue: "#89b4fa",
            lavender: "#b4befe",
            text: "#cdd6f4",
            subtext1: "#bac2de",
            subtext0: "#a6adc8",
            overlay2: "#9399b2",
            overlay1: "#7f849c",
            overlay0: "#6c7086",
            surface2: "#585b70",
            surface1: "#45475a",
            surface0: "#313244",
            base: "#1e1e2e",
            mantle: "#181825",
            crust: "#11111b"
        }
    })
    
    // Function to switch theme
    function setTheme(themeName) {
        if (themes.hasOwnProperty(themeName)) {
            activeTheme = themeName
        }
    }
}
