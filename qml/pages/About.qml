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

    Text {
        id: copyright
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: desc.bottom
        anchors.topMargin: Theme.paddingLarge
        text: "<b>Copyright</b>: Pascal Schmid <br /><b>License: </b>Beerware (Revision 42)"
        color: Theme.primaryColor
    }

    Button {
        id: homepage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: copyright.bottom
        anchors.topMargin: Theme.paddingLarge
        text: "Github repo mirror"
        onClicked: {
            Qt.openUrlExternally("https://github.com/lechindianer/beerware")
        }
    }

}
