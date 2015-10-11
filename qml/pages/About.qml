import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    allowedOrientations: Orientation.Portrait

    Image {
        id: logo
        source: "../../assets/beer1-300px.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: appName.top // TODO: Different layout for Page in Landscape
        //y: page.isPortrait ? 200 : 100
    }

    Label {
        id: appName
        anchors.horizontalCenter: parent.horizontalCenter
        //y: page.isPortrait ? 320 : 220
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.pixelSize: Theme.fontSizeLarge
        text: "Beerware 0.6"
    }

    Text {
        id: desc
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: appName.bottom
        anchors.topMargin: 20
        text: qsTr("Rate you favourite beers")
        color: "white"
    }

    Text {
        id: copyright
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: desc.bottom
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
