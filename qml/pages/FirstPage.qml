import QtQuick 2.0
import Sailfish.Silica 1.0
import "../database.js" as DB


Page {

    id: root

    SilicaListView {
        id: listView
        model: BeerModel { id: beerModel }
        width: root.width
        height: root.height
        header: PageHeader {
            title: "Beerware"
        }
        section {
            property: 'category'
            delegate: SectionHeader {
                text: section
            }
        }
        delegate: ListItem {
            id: listItem
            width: listView.width
            ListView.onRemove: animateRemoval(listItem)

            property Item contextMenu
            property bool menuOpen: contextMenu != null && contextMenu.parent === listItem
            height: menuOpen ? contextMenu.height + contentItem.height : contentItem.height

            function remove() {
                remorseAction(qsTr("Deleting"), function() { beerModel.remove(index) })
                DB.removeBeer(beerModel.get(index).uID)
            }

            BackgroundItem {
                id: contentItem
                anchors.fill: parent

                onClicked: {
                    pageStack.push(Qt.resolvedUrl("ChangeBeer.qml"),
                                   {
                                       listModel: beerModel,
                                       index: index,
                                       oldBeerName: beerModel.get(index).name,
                                       oldBeerType: beerModel.get(index).category,
                                       oldBeerRating: beerModel.get(index).rating,
                                       uID: beerModel.get(index).uID
                                   })
                }

                onPressAndHold: {
                    if (!contextMenu) {
                        contextMenu = contextMenuComponent.createObject(listItem)
                    }
                    contextMenu.show(contentItem)
                }


                Label {
                    id: listLabel
                    text: model.name
                    color: beerModel.highlighted ? Theme.highlightColor : Theme.primaryColor
                    anchors.verticalCenter: parent.verticalCenter
                    x: Theme.horizontalPageMargin
                }

                Row {
                    id: row
                    width: parent.width / 3
                    anchors.right: parent.right
                    anchors.rightMargin: 5
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

            Component {
                id: contextMenuComponent
                ContextMenu {
                    id: menu
                    MenuItem {
                        text: qsTr("Remove")
                        onClicked: remove()
                    }
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
                text: "Add beer"
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
            text: qsTr('No entries')
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


