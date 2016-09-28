#ifndef ENGINE_H
#define ENGINE_H

#include <QObject>
#include <QThread>

class Engine : public QThread
{
    Q_OBJECT
public:
    Engine(QString text);
protected:
    void run();

public:
    QString word;
    QString translate;
};

#endif // TERMINAL_H
