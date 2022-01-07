QT       += core \
                gui \
                quickwidgets \
                positioning

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
        mapwidget.cpp \
        utilities.cpp \
        locator.cpp \
        klogdefinitions.cpp \
        mainwindow.cpp

HEADERS += \
        mapwidget.h \
        utilities.h \
        locator.h \
        global.h \
        klogdefinitions.h \
        mainwindow.h

#FORMS += \
#    mainwindow.ui

# deploy
DISTFILES += Changelog COPYING AUTHORS \
    qml/mapqmlfile.qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
