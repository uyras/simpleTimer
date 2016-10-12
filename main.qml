import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "main.js" as Js

Window {
    id: rootWindow
    visible: true
    width: 160
    height: 76
    flags: Qt.SplashScreen | Qt.WindowStaysOnTopHint | Qt.X11BypassWindowManagerHint

    Rectangle {
        id: btns
        color: "white"
        width: parent.width
        height: 20
        Button{
            id: workBtn
            width: parent.width/2
            height: parent.height
            checkable: true
            text: "Работа"
            onClicked: Js.setWork()
        }
        Button{
            id: freeBtn
            width: parent.width/2
            height: parent.height
            anchors.left: workBtn.right
            text: "Безделье"
            checkable: true
            onClicked: Js.setFree()
        }
    }

    Rectangle {
        id: lbls
        color: "black"
        width: parent.width
        anchors.top: btns.bottom
        height: parent.height-btns.height

        Text {
            id: bigTxt
            color: "white"
            text: "00:00:00"
            anchors.verticalCenterOffset: -6
            anchors.horizontalCenterOffset: 0
            font.bold: false
            font.family: "Verdana"
            font.pointSize: 24
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }

        Text {
            id: smallTxt
            color: "#feecd4"
            text: "00:00:00"
            font.pointSize: 10
            anchors.top: bigTxt.bottom
            anchors.right: bigTxt.right
        }

        MouseArea {
            anchors.fill: parent

            property variant clickPos: "1,1"

            onPressed: {
                clickPos  = Qt.point(mouse.x,mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                rootWindow.x += delta.x;
                rootWindow.y += delta.y;
            }
        }
    }

    Timer {
        id: tickTimer
        interval: 1000;
        running: false
        repeat: true
        onTriggered: Js.updateTimer();
    }

    Timer {
        id: pauseBlink
        interval: 500;
        running: false
        repeat: true
        onTriggered: bigTxt.visible = !bigTxt.visible;
    }
}
