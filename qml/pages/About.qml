import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    allowedOrientations: defaultAllowedOrientations


    Image {
        id: logo
        source: "noto.png"
        anchors.horizontalCenter: parent.horizontalCenter
        y: page.isPortrait ? 200 : 100
    }

    Label {
        id: appName
        anchors.horizontalCenter: parent.horizontalCenter
        y: page.isPortrait ? 320 : 220
        font.bold: true
        text: "Noto 1.7"
    }
    Text {
        id: desc
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: appName.bottom
        anchors.topMargin: 20
        text: "Simple note and todo taking application"
        color: "white"
    }
    Text {
        id: copyright
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: desc.bottom
        anchors.topMargin: 20
        text: "Copyright: Pascal Schmid <br />License: Beerware"
        color: "white"
    }
    Button {
        id: homepage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: copyright.bottom
        anchors.topMargin: 20
        text: "<a href=\"https://github.com/llelectronics/noto\">https://github.com/llelectronics/noto</a>"
        onClicked: {
            Qt.openUrlExternally("https://github.com/llelectronics/noto")
        }
    }

}
