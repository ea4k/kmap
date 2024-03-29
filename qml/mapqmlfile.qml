/***************************************************************************
                          mapqmlfile.qml  -  description
                             -------------------
    begin                : May 2021
    copyright            : (C) 2021 by Jaime Robles
    email                : jaime@robles.es
 ***************************************************************************/

/*****************************************************************************
 * This file is part of KLog.                                                *
 *                                                                           *
 *    KLog is free software: you can redistribute it and/or modify           *
 *    it under the terms of the GNU General Public License as published by   *
 *    the Free Software Foundation, either version 3 of the License, or      *
 *    (at your option) any later version.                                    *
 *                                                                           *
 *    KLog is distributed in the hope that it will be useful,                *
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *    GNU General Public License for more details.                           *
 *                                                                           *
 *    You should have received a copy of the GNU General Public License      *
 *    along with KLog.  If not, see <https://www.gnu.org/licenses/>.         *
 *                                                                           *
 *****************************************************************************/
import QtQuick 2.0
import QtQuick.Window 2.12
import QtLocation 5.6
import QtPositioning 5.6

Rectangle {
    width: 640
    height: 480
    visible: true
    property alias zoom: map.zoomLevel
    property alias lat: map.center.latitude
    property alias lon: map.center.longitude
    property variant locQTH

    //property alias locator: map.loca

    //property alias locLat1: locR.topLeft.latitude
    //property alias locLon1: locR.topLeft.longitude
    //property alias locLat2: locR.bottomRight.latitude
    //property alias locLon2: locR.bottomRight.longitude


    Location
    {
        // Define location that will be "center" of map
        id: mapCenter
        coordinate {
            latitude: 43.2
            longitude: -4.816669
        }
    }

    FocusScope
    {
         anchors.fill: parent
    }

    Plugin {
        id: mapPlugin
        name: "osm" // "osm", "mapboxgl", "esri", "googleMap...
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: mapCenter.coordinate

        onCenterChanged:
        {
            console.log("Map Center X: ", lat, " - Map Center Y: ", lon);
        }
        zoomLevel : Math.floor((map.maximumZoomLevel - map.minimumZoomLevel)/2)
        fieldOfView : Math.min(Math.max(45.0, minimumFieldOfView), maximumFieldOfView)
        //zoomLevel: 14
        MouseArea
        {
            hoverEnabled: true
            anchors.fill: parent
            //onPositionChanged:
            //{
            //    Qt.point(mouseX, mouseY)
            //    var coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
            //    console.log("Mouse Position (", mouseX, ", ", mouseY, ")");
            //    console.log("Mouse GeoPosition (", coordinate.latitude, ", ", coordinate.longitude, ")");
            //}
        }

        MapItemView
        {
            model: rectangle_model
            delegate: MapRectangle
            {
                //color: 'green'
                color: "#46a2da"
                border.color: "#190a33"
                border.width: 2
                smooth: true
                opacity: 0.25
                function setGeometry(locQTH){
                        topLeft.latitude = Math.max(locQTH.coordinate.latitude, locQTH.coordinate.latitude)
                        topLeft.longitude = Math.min(locQTH.coordinate.longitude, locQTH.coordinate.longitude)
                        bottomRight.latitude = Math.min(locQTH.coordinate.latitude, locQTH.coordinate.latitude)
                        bottomRight.longitude = Math.max(locQTH.coordinate.longitude, locQTH.coordinate.longitude)
                    }
                //topLeft {
                //    latitude: -27
                //    longitude: 153
                //}
                //bottomRight {
                //    latitude: -28
                //    longitude: 153.5
                //}
            }
        }

        MapItemView
        {
            model: circle_model
            delegate: MapCircle{
                center: model.coordinate
                radius: 5000.0
                color: 'green'
                border.width: 10
            }
        }
    }
}

