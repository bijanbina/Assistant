TEMPLATE = app
TARGET = gallery
INCLUDEPATH += .
QT += quick

SOURCES += \
    sources/*.cpp

RESOURCES += \
    resources/fonts.qrc \
    qml/ui.qrc


OTHER_FILES += \
    qml/ControlViewToolBar.qml \
    resources/fonts.qrc \
    qml/ui.qrc \
    qml/*.qml


HEADERS += \
    sources/*.h

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += qml/

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
