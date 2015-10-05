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
        //y: page.isPortrait ? 320 : 220
        anchors.bottom: desc.top
        font.bold: true
        font.pixelSize: Theme.fontSizeLarge
        text: "Beerware 1.0"
    }
    Text {
        id: desc
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: copyright.top
        anchors.topMargin: 20
        text: qsTr("Rate you favourite beers")
        color: "white"
    }
    Text {
        id: copyright
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.top: desc.bottom
        anchors.verticalCenter: parent.verticalCenter
        anchors.topMargin: 20
        text: qsTr("<b>Copyright</b>: Pascal Schmid <br /><b>License</b>: Beerware")
        color: "white"
    }
    Button {
        id: homepage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: copyright.bottom
        anchors.topMargin: 20
        text: "<a href=\"https://github.com/lechindianer/beerware\">Get source code</a>"
        onClicked: {
            Qt.openUrlExternally("https://github.com/lechindianer/beerware")
        }
    }

}
