import QtQuick 2.0
import Sailfish.Silica 1.0
import "../database.js" as DB


Page {

    id: root

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: BeerModel { id: beerModel }
        header: PageHeader {
            title: "Beerware"
        }

        section {
            property: "category"
            delegate: SectionHeader {
                text: section
            }
        }

        delegate: ListItem {
            id: listItem
            width: listView.width
            ListView.onRemove: animateRemoval(listItem)

            onClicked: pageStack.push(Qt.resolvedUrl("ChangeBeer.qml"), {
                                          listModel: beerModel,
                                          index: index,
                                          oldBeerName: beerModel.get(index).name,
                                          oldBeerType: beerModel.get(index).category,
                                          oldBeerRating: beerModel.get(index).rating,
                                          uID: beerModel.get(index).uID
                                      })

            Label {
                id: listLabel
                anchors {
                    left: parent.left
                    leftMargin: Theme.horizontalPageMargin
                    verticalCenter: parent.verticalCenter
                }
                text: model.name
                color: beerModel.highlighted || contextMenu.active ?
                           Theme.highlightColor : Theme.primaryColor
            }

            Row {
                id: row
                width: parent.width / 3
                anchors {
                    right: parent.right
                    rightMargin: Theme.horizontalPageMargin
                    verticalCenter: parent.verticalCenter
                }                

                Repeater {
                    id: repeater
                    model: 5

                    GlassItem {
                        color: "white"
                        width: parent.width / 5
                        height: parent.width / 5
                        radius: 4
                        falloffRadius: 0.2
                        visible: (rating > index) ? true : false
                    }
                }
            }

            menu: ContextMenu {
                id: contextMenu

                MenuItem {
                    text: qsTr("Remove")
                    onClicked: remorseAction(qsTr("Deleting"), function() {
                        beerModel.remove(index);
                        DB.removeBeer(beerModel.get(index).uID);
                    })
                }
            }
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("About.qml"), {dataContainer: root})
                }
            }

            MenuItem {
                text: qsTr("Add beer")
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
            text: qsTr("No entries")
            enabled: beerModel.count === 0
        }

        Component.onCompleted: {
            DB.loadBeers()
        }

        VerticalScrollDecorator {}
    }

    function addBeer(uID, name, category, rating){
        beerModel.append({"uID": uID ,"name": name, "category": category, "rating": rating})
    }
}


