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
TARGET = Beerware

CONFIG += sailfishapp

SOURCES += src/Beerware.cpp

OTHER_FILES += qml/Beerware.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/Beerware.changes.in \
    rpm/Beerware.spec \
    rpm/Beerware.yaml \
    translations/*.ts \
    Beerware.desktop \
    qml/pages/NewBeer.qml \
    qml/pages/About.qml \
    qml/pages/BeerModel.qml \
    assets/beer1-300px.png \
    assets/beer1-800px.png \
    qml/database.js

assets.path = /usr/share/$$TARGET/
assets.files = assets

INSTALLS += assets

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/Beerware-de.ts

