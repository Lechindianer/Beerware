import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQml.Models 2.2
import "."

Page {
    property bool _searchEnabled: false

    id: root

    DelegateModel {

        function update() {
            var text = listView.headerItem.searchField.text.toLowerCase();
            var noText = !text;
            for (var i = 0; i < BeerModel.count; ++i) {
                var beer = BeerModel.get(i);

                if (noText ||
                    beer.name.toLowerCase().indexOf(text) >= 0 ||
                    beer.category.toLowerCase().indexOf(text) >= 0) {
                    items.addGroups(i, 1, "visible");
                } else {
                    items.removeGroups(i, 1, "visible");
                }
            }
        }

        id: delegateModel
        model: BeerModel
        delegate: BeerDelegate { }
        groups: [
            DelegateModelGroup {
                name: "visible"
                includeByDefault: true
            }
        ]
        filterOnGroup: "visible"
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: delegateModel
        currentIndex: -1
        header: Column {
            property alias searchField: searchField

            width: parent.width

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
                    onTextChanged: delegateModel.update()

                    opacity: _searchEnabled ? 1 : 0
                    visible: opacity > 0
                    onVisibleChanged: if (visible) forceActiveFocus()

                    enabled: _searchEnabled
                    onEnabledChanged: if (!enabled) text = ""

                    EnterKey.iconSource: "image://theme/icon-m-enter-close"

                    Behavior on opacity { FadeAnimation { duration: 150 } }
                }
            }
        }

        section {

            property: "category"
            delegate: SectionHeader {
                text: section
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
                text: _searchEnabled ? qsTr("Hide search field") : qsTr("Show search field")
                onClicked: _searchEnabled = !_searchEnabled
            }

            MenuItem {
                text: qsTr("Add beer")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("BeerPage.qml"))
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
            enabled: BeerModel.count === 0
        }

        VerticalScrollDecorator {}
    }
}
