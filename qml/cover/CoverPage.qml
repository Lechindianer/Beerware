import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Image {
        id: coverImage
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: Theme.paddingLarge
        }

        source: "qrc:///harbour-beerware/beer-300.png"
        opacity: 0.5
        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: coverLabel
        anchors {
            top: coverImage.bottom
            horizontalCenter: parent.horizontalCenter
        }

        text: "Beerware"
        font.pixelSize: Theme.fontSizeSmall
    }

    CoverActionList {

        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                pageStack.push(Qt.resolvedUrl("../pages/BeerPage.qml"), null, PageStackAction.Immediate);
                appWindow.activate();
            }
        }
    }
}
