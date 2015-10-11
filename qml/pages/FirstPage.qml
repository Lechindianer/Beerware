import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0 as LS


Page {
    id: root

    SilicaListView {
        id: listView
        model: BeerModel { id: beerModel }
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Beerware")
        }
        section {
            property: 'section'
            delegate: SectionHeader {
                text: section
            }
        }
        delegate: BackgroundItem {
            width: listView.width
            Label {
                id: listLabel
                text: model.name
                color: beerModel.highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
            }

            Row { // TODO: Rewrite with Repeater
                id: row
                width: parent.width / 3
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                GlassItem {
                    color: "white"
                    width: parent.width / 5
                    height: parent.width / 5
                    radius: 4
                    falloffRadius: 0.2
                    visible: (model.rating >= 1) ? true : false
                }

                GlassItem {
                    color: "white"
                    width: parent.width / 5
                    height: parent.width / 5
                    radius: 4
                    falloffRadius: 0.2
                    visible: (model.rating >= 2) ? true : false
                }

                GlassItem {
                    color: "white"
                    width: parent.width / 5
                    height: parent.width / 5
                    radius: 4
                    falloffRadius: 0.2
                    visible: (model.rating >= 3) ? true : false
                }

                GlassItem {
                    color: "white"
                    width: parent.width / 5
                    height: parent.width / 5
                    radius: 4
                    falloffRadius: 0.2
                    visible: (model.rating >= 4) ? true : false
                }

                GlassItem {
                    color: "white"
                    width: parent.width / 5
                    height: parent.width / 5
                    radius: 4
                    falloffRadius: 0.2
                    visible: (model.rating >= 5) ? true : false
                }
            }
        }

        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("About.qml"), {dataContainer: root})
                }
            }

            MenuItem {
                text: "Add Beer"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("NewBeer.qml"), {"listModel": beerModel})
                }
            }
        }

        PushUpMenu {
            spacing: Theme.paddingLarge
            MenuItem {
                text: qsTr("Return to Top")
                onClicked: listView.scrollToTop()
            }
        }

        ViewPlaceholder {
            id: emptyText
            text: 'No entries'
            enabled: beerModel.count === 0
        }

        Component.onCompleted: {
            var db = LS.LocalStorage.openDatabaseSync("Beerware", "0.6", "Beerware LocalStorage Database", 1000000);
            db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Greeting(salutation TEXT, salutee TEXT)');

                    var rs = tx.executeSql('SELECT * FROM beers');

                    for (var i = 0; i < rs.rows.length; i++) {
                        beerModel.append({"name": rs.rows.item(i).name, "section": rs.rows.item(i).category, "rating": rs.rows.item(i).rating})
                        console.debug("Load Beers: " + rs.rows.item(i).name)
                    }
                }
            )
        }

        VerticalScrollDecorator {}
    }
}


