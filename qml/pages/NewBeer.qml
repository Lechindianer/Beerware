import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {

    property BeerModel listModel

    DialogHeader { id: header }

    onAccepted: {
        var rating = 0;
        for (var i = 0; i < repeater.count; i++) {
            if (repeater.itemAt(i).dimmed === true)
                rating += 1
        }

        listModel.append({"name": beerName.text, "section": beerType.text, "rating": rating})
        listModel.quick_sort()
    }

    Column {
        id: column
        spacing: Theme.paddingMedium
        width: parent.width
        anchors.top: header.bottom

        TextField {
            id: beerName
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
            width: parent.width
            label: qsTr("Beer type")
            placeholderText: qsTr("Beer type")
            focus: true
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
