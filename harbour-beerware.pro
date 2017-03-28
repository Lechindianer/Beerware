TARGET = harbour-beerware

CONFIG += \
    sailfishapp \
    sailfishapp_i18n \
    c++11

QT += sql

SOURCES += \
    src/harbour-beerware.cpp \
    src/beersmodel.cpp \
    src/beer.cpp \
    src/beerssortfilterproxymodel.cpp \
    src/settings.cpp

HEADERS += \
    src/beersmodel.h \
    src/beer.h \
    src/beerssortfilterproxymodel.h \
    src/settings.h

OTHER_FILES += \
    qml/harbour-beerware.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/About.qml \
    qml/pages/BeerPage.qml \
    qml/pages/BeerDelegate.qml \
    qml/pages/SettingsPage.qml \
    rpm/harbour-beerware.changes \
    rpm/harbour-beerware.spec \
    rpm/harbour-beerware.yaml \
    translations/*.ts \
    harbour-beerware.desktop

RESOURCES += harbour-beerware.qrc

TRANSLATIONS += \
    translations/harbour-beerware-de.ts \
    translations/harbour-beerware-ru.ts

SAILFISHAPP_ICONS = \
    86x86 \
    108x108 \
    128x128 \
    256x256
