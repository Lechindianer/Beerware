# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-beerware

CONFIG += sailfishapp

SOURCES += src/harbour-beerware.cpp

OTHER_FILES += qml/harbour-beerware.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-beerware.changes.in \
    rpm/harbour-beerware.spec \
    rpm/harbour-beerware.yaml \
    translations/*.ts \
    harbour-beerware.desktop \
    qml/pages/NewBeer.qml \
    qml/pages/About.qml \
    qml/pages/BeerModel.qml \
    qml/database.js

RESOURCES += harbour-beerware.qrc

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/Beerware-de.ts

DISTFILES += \
    qml/pages/ChangeBeer.qml
