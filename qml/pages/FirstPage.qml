/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: root

    ListModel {
        id: pagesModel

        ListElement {
            page: "ButtonPage.qml"
            title: "Diebels"
            section: "Pils"
            rating: 2
        }
        ListElement {
            page: "ComboBoxPage.qml"
            title: "Augustiner"
            section: "Helles"
            rating: 5
        }
        ListElement {
            page: "MenuPage.qml"
            title: "Franziskaner"
            section: "Weizen"
            rating: 5
        }
        ListElement {
            page: "MenuPage.qml"
            title: "Pils 3"
            section: "Pils"
            rating: 3
        }
        ListElement {
            page: "MenuPage.qml"
            title: "Helles 2"
            section: "Helles"
            rating: 2
        }
        ListElement {
            page: "MenuPage.qml"
            title: "Weizen 1 "
            section: "Weizen"
            rating: 1
        }
    }



    SilicaListView {
        id: listView
        model: pagesModel
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Beerware")
        }

        section {
            property: 'section'
            delegate: SectionHeader {
                text: section
            }
        }
        delegate: BackgroundItem {
            width: listView.width
            Label {
                id: listLabel
                text: model.title
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
            }

            Row {
                id: row
                width: parent.width / 3
                anchors.right: parent.right
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
           // onClicked: pageStack.push(Qt.resolvedUrl(page))
        }
        PullDownMenu {
                    MenuItem {
                        text: "About"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("About.qml"), {dataContainer: root})
                        }
                    }
                    MenuItem {
                        text: "Add Beer"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("NewBeer.qml"), {dataContainer: root, noteUid: 0})
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
        VerticalScrollDecorator {}
    }
}


