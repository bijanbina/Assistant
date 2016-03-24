
#include "channel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //Added for GUI version

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/notification.qml")));
    QObject *root = engine.rootObjects().first();

    Channel *dbusChnl = new Channel(root);

    QObject::connect(root, SIGNAL(addPhSignal(QString , QString)), dbusChnl, SLOT(writeAccepted(QString , QString)));

    loadOptions();
    dbusChnl->startServer();

    return app.exec();
}

