#include "userhandler.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

UserHandler::UserHandler(QObject *parent)
    : QObject(parent)
{
}

void UserHandler::submitUserInfo(const QString &name, const QString &email)
{
    QFile file("userdata.txt");
    if (file.open(QIODevice::Append | QIODevice::Text)) {
        QTextStream out(&file);
        out << "Name: " << name << ", Email: " << email << "\n";
        file.close();

        qDebug() << "Data saved to file.";
        emit userSaved();
    } else {
        qDebug() << "Failed to open file!";
        emit userSaveFailed("Could not write to file.");
    }
}

QStringList UserHandler::loadUsers()
{
    QStringList users;
    QFile file("userdata.txt");
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        while (!in.atEnd()) {
            QString line = in.readLine();
            users.append(line);
        }
        file.close();
    }
    return users;
}