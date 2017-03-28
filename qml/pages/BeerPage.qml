import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.beerware 1.0


Dialog {
    property Beer beer

    canAccept: beerName.text

    Component.onCompleted: {
        var rating = 5;
        if (beer) {
            beerName.text = beer.name;
            beerCategory.text = beer.category;
            rating = beer.rating;
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

        if (beer) {
            beer.name = beerName.text;
            beer.category = beerCategory.text;
            beer.rating = rating;
            beersModel.updateBeer(beer);
        } else {
            beersModel.addBeer(beerName.text, beerCategory.text, rating);
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
