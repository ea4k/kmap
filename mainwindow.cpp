#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    locator = new Locator();
    mapWidget = new MapWidget();
    setCentralWidget (mapWidget);
    mapWidget->setCenter(locator->getLat("IN80"), locator->getLon("IN80") );

    mapWidget->addQSO ("IN70de");
}

MainWindow::~MainWindow()
{

}

