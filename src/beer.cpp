#include "beer.h"

Beer::Beer(QObject *parent) :
    QObject(parent),
    mRating(0),
    mUId(-1)
{

}

Beer::Beer(const QString &name, const QString &category, const quint8 &rating, QObject *parent) :
    QObject(parent),
    mRating(rating),
    mUId(-1),
    mName(name),
    mCategory(category)
{

}

Beer::Beer(const qint32 &uId, const QString &name, const QString &category, const quint8 &rating, QObject *parent) :
    QObject(parent),
    mRating(rating),
    mUId(uId),
    mName(name),
    mCategory(category)
{

}

quint8 Beer::rating() const
{
    return mRating;
}

void Beer::setRating(const quint8 &rating)
{
    if (mRating != rating)
    {
        mRating = rating;
        emit this->ratingChanged();
    }
}

qint32 Beer::uId() const
{
    return mUId;
}

void Beer::setUId(const qint32 &uId)
{
    if (mUId != uId)
    {
        mUId = uId;
        emit this->uIdChanged();
    }
}

QString Beer::name() const
{
    return mName;
}

void Beer::setName(const QString &name)
{
    if (mName != name)
    {
        mName = name;
        emit this->nameChanged();
    }
}

QString Beer::category() const
{
    return mCategory;
}

void Beer::setCategory(const QString &category)
{
    if (mCategory != category)
    {
        mCategory = category;
        emit this->categoryChanged();
    }
}
