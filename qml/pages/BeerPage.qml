import QtQuick 2.0
import Sailfish.Silica 1.0
import "."

Dialog {
    property variant model

    canAccept: beerName.text

    Component.onCompleted: {
        var rating = 5;
        if (model) {
            beerName.text = model.name;
            beerCategory.text = model.category;
            rating = model.rating;
        }

        for (var i = 0; i < rating; ++i) {
            repeater.itemAt(i).dimmed = true;
        }
    }

    onAccepted: {
        var rating = 0;
        for (var i = 0; i < repeater.count; ++i) {
            rating += repeater.itemAt(i).dimmed;
        }

        if (model) {
            BeerModel.changeBeer(model.uID, beerName.text, beerCategory.text, rating);
            model.name = beerName.text;
            model.category = beerCategory.text;
            model.rating = rating;
        } else {
            BeerModel.saveBeer(beerName.text, beerCategory.text, rating);
        }
    }

    DialogHeader { id: header }

    Column {
        id: column
        spacing: Theme.paddingMedium
        width: parent.width
        anchors.top: header.bottom

        TextField {
            id: beerName
            width: parent.width
            label: qsTr("Beer name")
            placeholderText: qsTr("Beer name")
            focus: true
            EnterKey.enabled: text.length > 0
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                beerCategory.focus = true;
            }
        }

        TextField {
            id: beerCategory
            width: parent.width
            label: qsTr("Beer type")
            placeholderText: qsTr("Beer type")
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
                    property bool dimmed: false

                    id: glassItem
                    falloffRadius: dimmed ? undefined : 0.075

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            for (var i = 0; i <= index; i++) {
                                repeater.itemAt(i).dimmed = true
                            }
                            for (i; i < repeater.count; i++) {
                                repeater.itemAt(i).dimmed = false
                            }
                        }
                    }
                }
            }
        }
    }
}
