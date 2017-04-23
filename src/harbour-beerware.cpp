#include "beersmodel.h"
#include "beerssortfilterproxymodel.h"
#include "beer.h"
#include "settings.h"

#include <QtQuick>

#include <sailfishapp.h>


int main(int argc, char *argv[])
{
    qmlRegisterType<Beer>("harbour.beerware", 1, 0, "Beer");

    auto app  = SailfishApp::application(argc, argv);
    auto view = SailfishApp::createView();
    auto rootContext = view->rootContext();

    auto settings = new Settings(app);
    rootContext->setContextProperty(QLatin1String("settings"), settings);

    auto beersModel = new BeersSortFilterProxyModel(app);
    auto beersSourceModel = new BeersModel(app);
    beersModel->setSourceModel(beersSourceModel);
    rootContext->setContextProperty(QLatin1String("beersModel"), beersModel);

    QObject::connect(settings, &Settings::sortingOrderChanged, [=]()
    {
        beersModel->setSortRole(settings->sortingOrder() + Qt::UserRole + 1);
    });
    emit settings->sortingOrderChanged();

    view->setSource(SailfishApp::pathTo(QLatin1String("qml/harbour-beerware.qml")));

    view->show();
    return app->exec();
}
