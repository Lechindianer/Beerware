import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
    property string category

    canAccept: category

    Component.onCompleted: categoriesModel.update()

    DialogHeader { id: pageHeader }

    SilicaListView {
        id: categoriesView
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        currentIndex: -1
        clip: true

        header: TextField {
            id: categoryField
            width: parent.width
            label: qsTr("Beer type")
            placeholderText: qsTr("Beer type")
            // TODO: How to make it with aliases?
            text: category
            onTextChanged: {
                category = text;
                categoriesModel.update();
            }
            EnterKey.iconSource: "image://theme/icon-m-enter-close"

            Component.onCompleted: forceActiveFocus()
        }

        model: ListModel {
            id: categoriesModel
            property var categories: beersModel.sourceModel.categories()

            function update() {
                clear();
                for (var i = 0; i < categories.length; ++i) {
                    if (categories[i] && (!category || categories[i].indexOf(category) >= 0)) {
                        append({ "model": categories[i] });
                    }
                }
            }
        }

        delegate: ListItem {
            id: listItem
            onClicked: category = model
            Label {
                anchors {
                    left: parent.left
                    leftMargin: categoriesView.headerItem.textLeftMargin
                    verticalCenter: parent.verticalCenter
                }
                text: model
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
        }

        ViewPlaceholder {
            id: newCategory
            text: qsTr("Add a new beer type")
            enabled: categoriesView.count === 0
            verticalOffset: -200
        }

        VerticalScrollDecorator {}
    }
}
