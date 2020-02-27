#ifndef CHAPAR_H
#define CHAPAR_H

#include <QObject>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQmlProperty>
#include "highlight.h"

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
    void removeHighlight(QString word);
    void addHighlight(QString word, QString last);

private slots:

private:
    void sendMessage(QString message);
    void openSerialPort();
    bool IE;//interrupt enable
    bool multiPacket;
    QObject  *root;

    QString buffer;
    QString txBuffer;
    Highlight *highlight_db;
};

#endif // CHAPAR_H
