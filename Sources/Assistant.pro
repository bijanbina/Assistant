TEMPLATE = app

QT += qml quick widgets dbus

SOURCES += main.cpp \
    backend.cpp \
    channel.cpp

RESOURCES += ../Resources/resource.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

DISTFILES += \
    ../UI/main.qml

INCLUDEPATH +=  \
    /usr/include/glib-2.0 \
    /usr/lib/glib-2.0/include
LIBS += -lnotify \
    -lgdk_pixbuf-2.0 \
    -lgio-2.0 \
    -lgobject-2.0 \
    -lglib-2.0

QMAKE_CXXFLAGS += -pthread

HEADERS += \
    backend.h \
    channel.h
