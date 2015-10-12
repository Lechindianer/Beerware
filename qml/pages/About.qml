import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: aboutPage
    allowedOrientations: Orientation.Portrait

    Image {
        id: logo
        source: "../../assets/beer1-300px.png"
        anchors.horizontalCenter: parent.horizontalCenter
       // anchors.bottom: appName.top // TODO: Different layout for Page in Landscape

    }

    Label {
        id: appName
        anchors.horizontalCenter: parent.horizontalCenter
        //y: page.isPortrait ? 320 : 220
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.pixelSize: Theme.fontSizeLarge
        color: Theme.primaryColor
        text: "Beerware 0.8"
    }

    Text {
        id: desc
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: appName.bottom
        anchors.topMargin: 20
        text: qsTr("Rate you favourite beers")
        color: Theme.primaryColor
    }

    Text {
        id: copyright
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: desc.bottom
        anchors.topMargin: 20
        textFormat: Text.RichText
        text: qsTr("<b>Copyright</b>: Pascal Schmid <br /><b>License: </b>Beerware (Revision 42)")
        color: Theme.primaryColor
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
