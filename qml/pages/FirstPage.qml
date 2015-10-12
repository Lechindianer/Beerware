import QtQuick 2.0
import Sailfish.Silica 1.0
import "../database.js" as DB

Page {
    id: root

    SilicaListView {
        id: listView
        model: BeerModel { id: beerModel }
        anchors.fill: parent
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
            menu: contextMenu
            ListView.onRemove: animateRemoval(listItem)

            function remove() {
                remorseAction(qsTr("Deleting"), function() { beerModel.remove(index) })
                DB.removeBeer(beerModel.get(index).name, beerModel.get(index).category)
            }

            Component {
                id: contextMenu
                ContextMenu {
                    MenuItem {
                        text: qsTr("Remove")
                        onClicked: remove()
                    }
                }
            }

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

    function addBeer(name, category, rating){
        beerModel.append({"name": name, "category": category, "rating": rating})
    }
}


