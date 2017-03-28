#include "settings.h"

#define SEARCH_ENABLED QLatin1String("SearchEnabled")
#define SORTING_ORDER  QLatin1String("SortingOrder")

Settings::Settings(QObject *parent) :
    QSettings(parent)
{

}

void Settings::setSearchEnabled(const bool &searchEnabled)
{
    if (this->searchEnabled() != searchEnabled)
    {
        this->setValue(SEARCH_ENABLED, searchEnabled);
        emit this->searchEnabledChanged();
    }
}

bool Settings::searchEnabled() const
{
    return this->value(SEARCH_ENABLED, false).toBool();
}

void Settings::setSortingOrder(const SortingOrder &order)
{
    if (this->sortingOrder() != order)
    {
        this->setValue(SORTING_ORDER, order);
        emit this->sortingOrderChanged();
    }
}

Settings::SortingOrder Settings::sortingOrder() const
{
    return static_cast<SortingOrder>(
        this->value(SORTING_ORDER, CategoryNameRating).toInt());
}
