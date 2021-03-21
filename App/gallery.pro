TEMPLATE = app
TARGET = gallery
INCLUDEPATH += .
QT += quick

SOURCES += \
    main.cpp \
    chapar.cpp \
    highlight.cpp

RESOURCES += \
    gallery.qrc


OTHER_FILES += \
    qml/ControlViewToolBar.qml \
    gallery.qrc \
    qml/*.qml


HEADERS += \
    chapar.h \
    highlight.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    qml/main.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
