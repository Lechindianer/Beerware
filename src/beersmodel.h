#ifndef BEERSMODEL_H
#define BEERSMODEL_H

#include <QAbstractListModel>

class Beer;

class BeersModel : public QAbstractListModel
{
    Q_OBJECT

public:

    enum Roles
    {
        BeerRole = Qt::UserRole,
        CategoryNameRatingSortRole,
        CategoryRatingNameSortRole
    };
    Q_ENUMS(Roles)

    explicit BeersModel(QObject *parent = 0);
    ~BeersModel();

    Q_INVOKABLE bool addBeer(const QString &name, const QString &category, const int &rating);
    Q_INVOKABLE bool updateBeer(Beer *beer);
    Q_INVOKABLE bool removeBeer(const int &index);

    Beer *getBeer(const int &row);

private slots:
    void select();
    void initInfoTable(const QString &version);
    void checkDbVersion();

private:
    QList<Beer *> mData;

    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QHash<int, QByteArray> roleNames() const;
    QVariant data(const QModelIndex &index, int role) const;
};

#endif // BEERSMODEL_H
