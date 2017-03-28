#ifndef SETTINGS_H
#define SETTINGS_H

#include <QSettings>
#include "beersmodel.h"

class Settings : public QSettings
{
    Q_OBJECT

    Q_PROPERTY(bool searchEnabled READ searchEnabled WRITE setSearchEnabled NOTIFY searchEnabledChanged)
    Q_PROPERTY(SortingOrder sortingOrder READ sortingOrder WRITE setSortingOrder NOTIFY sortingOrderChanged)

public:

    enum SortingOrder
    {
        CategoryNameRating,
        CategoryRatingName
    };
    Q_ENUMS(SortingOrder)

    explicit Settings(QObject *parent = 0);

    void setSearchEnabled(const bool &searchEnabled);
    bool searchEnabled() const;

    void setSortingOrder(const SortingOrder &order);
    SortingOrder sortingOrder() const;

signals:
    void searchEnabledChanged();
    void sortingOrderChanged();
};

#endif // SETTINGS_H
