import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: settingsPage

    Component.onCompleted: sorting.currentIndex = settings.sortingOrder

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("About.qml"))
                }
            }
        }

        PageHeader {
            id: header
            title: qsTr("Settings")
        }

        Column {
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
            }

            ComboBox {
                id: sorting
                width: parent.width
                label: qsTr("Sorting order")
                menu: ContextMenu {
                    MenuItem { text: qsTr("Category - Name - Rating") }
                    MenuItem { text: qsTr("Category - Rating - Name") }
                }
                onCurrentIndexChanged: settings.sortingOrder = currentIndex
            }
        }
    }
}
