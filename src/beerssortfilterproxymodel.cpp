#include "beerssortfilterproxymodel.h"
#include "beersmodel.h"
#include "beer.h"

#include <QDebug>

BeersSortFilterProxyModel::BeersSortFilterProxyModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
    this->setFilterCaseSensitivity(Qt::CaseInsensitive);
    this->setSortCaseSensitivity(Qt::CaseInsensitive);
    this->setDynamicSortFilter(true);
    this->sort(0);
}

bool BeersSortFilterProxyModel::addBeer(const QString &name, const QString &category, const int &rating)
{
    auto model = this->sourceModel();
    if (!model)
    {
        return false;
    }
    return static_cast<BeersModel *>(model)->addBeer(name, category, rating);
}

bool BeersSortFilterProxyModel::updateBeer(Beer *beer)
{
    auto model = this->sourceModel();
    if (!model)
    {
        return false;
    }
    auto ok = static_cast<BeersModel *>(model)->updateBeer(beer);
    if (ok)
    {
        this->invalidate();
    }
    return ok;
}

bool BeersSortFilterProxyModel::removeBeer(const int &index)
{
    auto model = this->sourceModel();
    if (!model)
    {
        return false;
    }
    auto sourceIndex = this->mapToSource(this->index(index, 0)).row();
    return static_cast<BeersModel *>(model)->removeBeer(sourceIndex);
}

bool BeersSortFilterProxyModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    Q_UNUSED(source_parent);

    auto beer = static_cast<BeersModel *>(this->sourceModel())->getBeer(source_row);
    auto filter = this->filterRegExp();
    return beer->name().contains(filter) || beer->category().contains(filter);
}
