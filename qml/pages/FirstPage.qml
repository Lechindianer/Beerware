import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQml.Models 2.1


Page {
    readonly property bool _currentlySearching: listView.headerItem.searchField.text.length

    id: root

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: beersModel
        delegate: BeerDelegate { }
        currentIndex: -1
        header: Column {
            property alias searchField: searchField

            width: parent ? parent.width : 0

            PageHeader {
                title: "Beerware"
            }

            Item {
                id: searchFieldPlaceholder
                width: parent.width
                height: searchField.visible ? searchField.height : 0

                Behavior on height {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }

                SearchField {
                    id: searchField
                    width: parent.width
                    placeholderText: qsTr("Beer name or category")
                    focusOutBehavior: FocusBehavior.KeepFocus
                    onTextChanged: beersModel.setFilterFixedString(text)

                    opacity: settings.searchEnabled ? 1 : 0
                    visible: opacity > 0
                    onVisibleChanged: if (visible) forceActiveFocus()

                    enabled: settings.searchEnabled
                    onEnabledChanged: if (!enabled) text = ""

                    EnterKey.iconSource: "image://theme/icon-m-enter-close"

                    Behavior on opacity { FadeAnimation { duration: 150 } }
                }
            }
        }

        section {
            property: "beer.category"
            delegate: SectionHeader {
                text: section
            }
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
                }
            }

            MenuItem {
                text: settings.searchEnabled ? qsTr("Hide search field") : qsTr("Show search field")
                onClicked: settings.searchEnabled = !settings.searchEnabled
            }

            MenuItem {
                text: qsTr("Add beer")
                onClicked: pageStack.push(Qt.resolvedUrl("BeerPage.qml"))
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
            text: _currentlySearching ? qsTr("Nothing found") : qsTr("No entries")
            enabled: listView.count === 0
        }

        VerticalScrollDecorator {}
    }
}
