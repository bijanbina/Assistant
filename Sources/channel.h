#ifndef CHANNEL_H
#define CHANNEL_H

#include "backend.h"
#include <QObject>
#include <QtCore/QObject>
#include <QtDBus/QtDBus>


class Channel : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", COM_NAME)
public:
    Channel(QObject *ui, QObject *parent = NULL);

    void startServer();

    ~Channel();

public slots:
    Q_SCRIPTABLE void translate(const QString &text);
    Q_SCRIPTABLE void translateDirect();
    void checkPhraseBook();

private:
    void ConnectDBus();

    QObject *root;
    QTimer  *phChecker; //phrase checker
};



#endif // CHANNEL_H
