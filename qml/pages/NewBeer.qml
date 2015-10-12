import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0 as LS


Dialog {

    property BeerModel listModel

    DialogHeader { id: header }

    onAccepted: {
        var rating = 0;
        for (var i = 0; i < repeater.count; i++) {
            if (repeater.itemAt(i).dimmed === true)
                rating += 1
        }

        function saveBeer(){
            listModel.append({"name": beerName.text, "section": beerType.text, "rating": rating})
            listModel.quick_sort()

            var db = LS.LocalStorage.openDatabaseSync("Beerware", "0.6", "Beerware LocalStorage Database", 1000000);
            db.transaction(
                function(tx) {
                    var rs = tx.executeSql('INSERT OR REPLACE INTO beers VALUES (?,?,?);', [beerName.text, beerType.text, rating]);
                    if (rs.rowsAffected > 0) {
                        console.log ("Saved to database");
                    } else {
                        console.log ("Error saving to database");
                    }
                }
            )
        }

        saveBeer()
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

    Rectangle {
        id: buttonPhoto
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: column.bottom
        anchors.topMargin: 10
        width: 225
        height: 400

        border.color: Theme.highlightColor
        border.width: 4
        color: "transparent"

        Image {
            id: image
            source: ""
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    var imagePicker = pageStack.push("Sailfish.Pickers.ImagePickerPage");
                    imagePicker.selectedContentChanged.connect(function() {
                        image.source = imagePicker.selectedContent;
                    });
                }
            }
        }
    }
}
