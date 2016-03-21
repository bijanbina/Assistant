
#include "backend.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //Added for GUI version

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/notification.qml")));
    QObject *root = engine.rootObjects().first();
    updateScreenInfo(root);
    startTranslate(root);

    //l
    /*notify_init("OSharee");
    NotifyNotification *message_notify;

    message_notify = notify_notification_new ("title", "matn",NULL);

    notify_notification_set_timeout (message_notify, 5);
    notify_notification_show(message_notify,NULL);

    g_object_unref(G_OBJECT(message_notify));*/
    return app.exec();
}

