import QtQuick 2.0
import Sailfish.Silica 1.0
import "../database.js" as DB


Dialog {

    property BeerModel listModel
    property int index
    property string oldBeerName
    property string oldBeerType
    property int oldBeerRating
    property int uID

    DialogHeader { id: header }

    onAccepted: {
        var rating = 0;
        for (var i = 0; i < repeater.count; i++) {
            if (repeater.itemAt(i).dimmed === true)
                rating += 1
        }
        listModel.set(index, {"uID": uID, "name": beerName.text, "category": beerType.text, "rating": rating})
        listModel.quick_sort()
        DB.changeBeer(uID, beerName.text, beerType.text, rating)
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
            text: oldBeerName
            focus: true
            EnterKey.enabled: text.length > 0
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                beerType.focus = true;
            }
        }

        TextField {
            id: beerType
            width: parent.width
            label: qsTr("Beer type")
            text: oldBeerType
            EnterKey.enabled: text.length > 0
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                row.focus = true;
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
                    property bool dimmed: false
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
            Component.onCompleted: {
                for (var i = 0; i < oldBeerRating; i++) {
                    repeater.itemAt(i).dimmed = true
                }
            }
        }
    }
}
