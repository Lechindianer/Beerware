import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0


Page {
    id: settingsPage

    Component.onCompleted: sorting.currentIndex = settings.sortingOrder

    Notification {
        function show(message) {
            replacesId = 0;
            previewBody = message;
            publish();
        }

        id: notification
        expireTimeout: 3000
    }

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
            spacing: Theme.paddingMedium

            SectionHeader {
                text: qsTr("Interface")
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

            SectionHeader {
                text: qsTr("Export")
            }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.horizontalPageMargin
                    rightMargin: Theme.horizontalPageMargin
                }
                text: qsTr("Export beers to a CSV file to the Documents directory")
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.highlightColor
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Export beers")
                onClicked: {
                    if (beersModel.sourceModel.exportBeers()) {
                        notification.show(qsTr("Beers were successfully exported"));
                    } else {
                        notification.show(qsTr("An error occurred while exporting beers"));
                    }
                }
            }
        }
    }
}
