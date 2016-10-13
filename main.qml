import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "main.js" as Js
import Qt.labs.settings 1.0

Window {
    id: rootWindow
    visible: true
    width: 122
    height: 58
    flags: Qt.SplashScreen | Qt.WindowStaysOnTopHint | Qt.X11BypassWindowManagerHint

    Rectangle {
        id: btns
        color: "white"
        width: parent.width
        height: 15

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


        MouseArea {
            id : ma
            anchors.fill: parent
            property variant clickPos: "1,1"
            propagateComposedEvents:true
            onPressed: {
                clickPos  = Qt.point(mouse.x,mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                rootWindow.x += delta.x;
                rootWindow.y += delta.y;
            }
        }

        Text {
            id: bigTxt
            property color workColor: "#46de26"
            property color freeColor: "#eba55d"
            color: "#ffffff"
            text: "00:00:00"
            anchors.verticalCenterOffset: -6
            anchors.horizontalCenterOffset: 0
            font.bold: false
            font.family: "Verdana"
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }

        Text {
            id: smallTxt
            color: "#feecd4"
            text: "00:00:00"
            font.pixelSize: 12
            anchors.top: bigTxt.bottom
            anchors.right: bigTxt.right
        }

        ToolButton {
            id: resetBtn
            iconSource: "reset.png"
            anchors.left: closeBtn.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 3
            width: 16; height: 16;
            onClicked: Js.resetCounter()
            tooltip: "сбросить показания счетчика"
        }
        ToolButton {
            id: closeBtn
            iconSource: "close.png"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: 16; height: 16;
            onClicked: Qt.quit();
            tooltip: "выйти из приложения"
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

    Settings {
        id: set
        property int workTime: 0
        property int freeTime: 0
        property bool first:true
        property bool isWork
        property bool isPaused

        property alias px: rootWindow.x
        property alias py: rootWindow.y
    }

    Component.onCompleted: Js.loadInterface();
    Component.onDestruction: Js.closeInterface();
}
