#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "userhandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    UserHandler userHandler;
    engine.rootContext()->setContextProperty("userHandler", &userHandler);

    const QUrl url(u"qrc:/qml/main.qml"_qs);
    engine.load(url);

    return app.exec();
}