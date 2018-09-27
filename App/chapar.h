#ifndef CHAPAR_H
#define CHAPAR_H

#include <QObject>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQmlProperty>

class chapar : public QObject
{
    Q_OBJECT

public:
    explicit chapar(QObject *ui, QObject *parent = NULL);
    void     start();
    void updateData();
    ~chapar();

//signals:

public slots:
    void sendMSG(QString text);

private slots:

private:
    void sendMessage(QString message);
    void getAgentID();
    void openSerialPort();
    bool IE;//interrupt enable
    bool multiPacket;
    QObject  *root;

    QString buffer;
    QString txBuffer;
};

#endif // CHAPAR_H
