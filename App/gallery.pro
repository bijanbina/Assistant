TEMPLATE = app
TARGET = gallery
INCLUDEPATH += .
QT += quick

SOURCES += \
    main.cpp \
    chapar.cpp

RESOURCES += \
    gallery.qrc


OTHER_FILES += \
    qml/ControlViewToolBar.qml \
    qml/gallery.qml \
    gallery.qrc

HEADERS += \
    chapar.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
