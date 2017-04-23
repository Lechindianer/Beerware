#ifndef BEERSSORTFILTERPROXYMODEL_H
#define BEERSSORTFILTERPROXYMODEL_H

#include <QSortFilterProxyModel>

class Beer;

class BeersSortFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit BeersSortFilterProxyModel(QObject *parent = 0);

    Q_INVOKABLE bool addBeer(const QString &name, const QString &category, const int &rating);
    Q_INVOKABLE bool updateBeer(Beer *beer);
    Q_INVOKABLE bool removeBeer(const int &index);

    // QSortFilterProxyModel interface
protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;
};

#endif // BEERSSORTFILTERPROXYMODEL_H
