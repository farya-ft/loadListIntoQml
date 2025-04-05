#ifndef USERHANDLER_H
#define USERHANDLER_H

#include <QObject>
#include <QString>
#include <QDebug>

class UserHandler : public QObject
{
    Q_OBJECT
public:
    explicit UserHandler(QObject *parent = nullptr);

    Q_INVOKABLE void submitUserInfo(const QString &name, const QString &email);
    Q_INVOKABLE QStringList loadUsers();
signals:
    void userSaved();
    void userSaveFailed(const QString &error);
};

#endif // USERHANDLER_H