#ifndef BEER_H
#define BEER_H

#include <QObject>

class Beer : public QObject
{
    friend class BeersModel;

    Q_OBJECT

    Q_PROPERTY(quint8 rating READ rating WRITE setRating NOTIFY ratingChanged)
    Q_PROPERTY(qint32 uId READ uId WRITE setUId NOTIFY uIdChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString category READ category WRITE setCategory NOTIFY categoryChanged)

public:
    explicit Beer(QObject *parent = 0);
    Beer(const QString &name, const QString &category, const quint8 &rating, QObject *parent = 0);
    Beer(const qint32 &uId, const QString &name, const QString &category, const quint8 &rating, QObject *parent = 0);

    quint8 rating() const;
    void setRating(const quint8 &rating);

    qint32 uId() const;
    void setUId(const qint32 &uId);

    QString name() const;
    void setName(const QString &name);

    QString category() const;
    void setCategory(const QString &category);

signals:
    void ratingChanged();
    void uIdChanged();
    void nameChanged();
    void categoryChanged();

private:
    quint8  mRating;
    qint32  mUId;
    QString mName;
    QString mCategory;
};

#endif // BEER_H
