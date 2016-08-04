
#include "channel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    bool loadDirect = false;
    if (argc > 1)
    {
        if (strcmp (argv[1],"--help") == 0)
        {
            if (argc == 2)
            {
                printf("Usage:\n  assistant [OPTION...]\n\nApplication Options:\n  --help\t\t\t  Show help options\n  --direct\t\t\t  Direct translation on first load\n\nShatter Me\n");
            }
            else
            {
               perror("you use this software in wrong syntax please type \"--help\" for more information");
               return 2;
            }
        }
        if (strcmp (argv[1],"--direct") == 0)
        {
            if (argc == 2)
            {
                loadDirect = true;
            }
            else
            {
               perror("you use this software in wrong syntax please type \"--help\" for more information");
               return 2;
            }
        }
    }
    //Added for GUI version

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/notification.qml")));
    QObject *root = engine.rootObjects().first();

    Channel *dbusChnl = new Channel(root);

    QObject::connect(root, SIGNAL(addPhSignal(QString , QString)), dbusChnl, SLOT(writeAccepted(QString , QString)));
    QObject::connect(root, SIGNAL(notifExit()), dbusChnl, SLOT(notifExit()));


    loadOptions();
    dbusChnl->startServer();

    if (loadDirect)
    {
        dbusChnl->translateDirect();
    }

    return app.exec();
}

