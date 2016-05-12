#ifndef CHANNEL_H
#define CHANNEL_H

#include "backend.h"
#include <QObject>
#include <QtCore/QObject>
#include <QtDBus/QtDBus>

#define PH_UPDATE_INTERVAL 30 //in minutes
#define PH_UPDATE_OUTDATED 8 //in hours


class Channel : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", COM_NAME)
public:
    Channel(QObject *ui, QObject *parent = NULL);

    void startServer();

    ~Channel();

public slots:
    void translateDirect();
    void translate(const QString &text);
    //Q_SCRIPTABLE void translate(const QString &text);

    void checkPhraseBook();
    void writeAccepted(QString title, QString word);
    void notifExit();

private:
    void ConnectDBus();

    QObject *root;
    QTimer  *phChecker; //phrase checker
    bool    isDirectLoad;
};



#endif // CHANNEL_H
