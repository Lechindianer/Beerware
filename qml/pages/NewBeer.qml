import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: newBeerPage

    property BeerModel listModel

    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column
            spacing: Theme.paddingMedium
            //y: Theme.paddingLarge
            anchors.fill: parent
            anchors.topMargin: 100

            TextField {
                id: beerName

                //anchors.top: parent.top
                //anchors.topMargin: 100
                width: parent.width

                label: qsTr("Beer name")
                placeholderText: qsTr("New Beer")
                focus: true
                EnterKey.onClicked: {
                    beerType.focus = true;
                }
            }

            TextField {
                id: beerType
                //anchors.top: beerName.top
                //anchors.topMargin: 100
                width: parent.width

                label: qsTr("Beer type")
                placeholderText: qsTr("Beer type")
                focus: true
                EnterKey.onClicked: {
                    listModel.append({"name": beerName.text, "section": beerType.text, "rating": 4})
                    navigateBack()
                }
            }

            Row {
                id: row
                height: Theme.itemSizeMedium
                anchors.horizontalCenter: parent.horizontalCenter


                Repeater {
                    id: repeater
                    model: 5
                    GlassItem {
                        id: glassItem
                        property bool dimmed: true
                        falloffRadius: dimmed ? undefined : 0.075
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                for (var i = 0; i <= index; i++) {
                                    repeater.itemAt(i).dimmed = true
                                }
                                for (var i = index+1; i < repeater.count; i++) {
                                    repeater.itemAt(i).dimmed = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
