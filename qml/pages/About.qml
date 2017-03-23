import QtQuick 2.0
import Sailfish.Silica 1.0


Page {

    id: aboutPage
    allowedOrientations: Orientation.Portrait

    Image {
        id: logo
        source: "qrc:///harbour-beerware/beer-300.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: appName.top // TODO: Different layout for Page in Landscape
        anchors.bottomMargin: 50

        state: "default"
        states: [State {
            name: "rotated"
            PropertyChanges { target: logo; rotation: 180 }
        },
        State {
            name: "default"
            PropertyChanges { target: logo; rotation: 360 }
        }]

        transitions: Transition {
            RotationAnimation { duration: 500; direction: RotationAnimation.Counterclockwise }
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (logo.state === "default")
                    logo.state = "rotated"
                else {
                    logo.state = "default"
                }
            }
        }
    }

    Label {
        id: appName
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.pixelSize: Theme.fontSizeLarge
        color: Theme.highlightColor
        text: "Beerware 0.8.2"
    }

    Text {
        id: desc
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: appName.bottom
        anchors.topMargin: Theme.paddingLarge
        text: qsTr("Rate your favourite beers")
        color: Theme.primaryColor
    }

    Grid {
        readonly property real _labelWidth: Math.max(copyrightLabel.contentWidth,
                                                     licenseLabel.contentWidth)

        id: copyright
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: desc.bottom
        anchors.topMargin: Theme.paddingLarge
        columns: 2
        columnSpacing: Theme.paddingSmall
        rowSpacing: Theme.paddingSmall

        Label {
            id: copyrightLabel
            width: copyright._labelWidth
            text: qsTr("<b>Copyright</b>:")
            horizontalAlignment: Text.AlignRight
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            text: "Pascal Schmid"
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            id: licenseLabel
            width: copyright._labelWidth
            text: qsTr("<b>License</b>:")
            horizontalAlignment: Text.AlignRight
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            text: "Beerware (Revision 42)"
            font.pixelSize: Theme.fontSizeSmall
        }
    }

    Button {
        id: homepage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: copyright.bottom
        anchors.topMargin: Theme.paddingLarge * 2
        text: qsTr("GitHub repo mirror")
        onClicked: {
            Qt.openUrlExternally("https://github.com/lechindianer/beerware")
        }
    }

}
