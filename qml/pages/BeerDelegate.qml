import QtQuick 2.0
import Sailfish.Silica 1.0


ListItem {
    property color itemColor: highlighted || contextMenu.active ?
                                  Theme.highlightColor : Theme.primaryColor

    id: listItem
    width: listView.width
    ListView.onRemove: _currentlySearching ? undefined : animateRemoval(listItem)

    onClicked: pageStack.push(Qt.resolvedUrl("BeerPage.qml"), { "beer": beer })

    Label {
        id: listLabel
        anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }
        text: beer.name
        color: itemColor
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
                color: itemColor
                width: parent.width * 0.2
                height: width
                radius: 4
                falloffRadius: 0.2
                visible: (beer.rating > index) ? true : false
            }
        }
    }

    menu: ContextMenu {
        id: contextMenu

        MenuItem {
            text: qsTr("Remove")
            onClicked: remorseAction(qsTr("Deleting"), function() {
                beersModel.removeBeer(index);
            })
        }
    }
}
