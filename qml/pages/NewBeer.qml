import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: newBeerPage

    SilicaFlickable {
        anchors.fill: parent

        TextField {
            id: beerName

            anchors.top: parent.top
            anchors.topMargin: 100
            width: parent.width

            label: qsTr("Beer name")
            placeholderText: qsTr("New Beer")
            focus: true
            EnterKey.onClicked: {
                console.log(beerName.text)
                beerType.focus = true;
            }
        }

        TextField {
            id: beerType

            anchors.top: beerName.top
            anchors.topMargin: 100
            width: parent.width

            label: qsTr("Beer type")
            placeholderText: qsTr("Beer type")
            focus: true
            EnterKey.onClicked: {
                console.log(beerType.text)
                parent.focus = true;
            }
        }
    }

    onStatusChanged: {

    }
}
