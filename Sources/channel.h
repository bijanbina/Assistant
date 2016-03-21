#ifndef CHANNEL_H
#define CHANNEL_H

#include "backend.h"
#include <QObject>
#include <QtCore/QObject>
#include <QtDBus/QtDBus>

class Channel : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "com.binaee.assistant")
public:
    Channel(QObject *ui, QObject *parent = NULL);
    ~Channel();

public slots:
    Q_SCRIPTABLE void translate(const QString &text);

private:
    void ConnectDBus();

    QObject *root;
};



#endif // CHANNEL_H
