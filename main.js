var workSecs=0;
var freeSecs=0;
var currSecs=0;
var isWork=0;
var isPaused=true;

function loadInterface(){
    if (set.first){
        set.first=false;
        console.log("first run settings");
    } else {
        workSecs=set.workTime;
        freeSecs=set.freeTime;
        if(set.isWork){
            console.log("load working mode");
            isWork=0;
            currSecs=set.freeTime;
            setWork();
        } else {
            console.log("load free mode");
            isWork=1;
            currSecs=set.workTime;
            setFree();
        }
        if (set.isPaused)
            pauseTimer();
    }
}

function closeInterface(){
    set.isPaused = isPaused;
    set.isWork = isWork;
    set.freeTime = freeSecs;
    set.workTime = workSecs;
    if(isWork){
        set.workTime = currSecs;
    } else {
        set.freeTime = currSecs;
    }
}

function setWork() {
    if (isWork==0){
        freeSecs=currSecs;
        currSecs=workSecs;
        smallTxt.text = getTime(freeSecs);
        bigTxt.text = getTime(currSecs);
        isWork=1;
        workBtn.checked=true;
        freeBtn.checked=false;
        startTimer();
    } else {
        if (isPaused)
            startTimer()
        else {
            pauseTimer();
            workBtn.checked=false;
        }
    }
}

function setFree() {

    if (isWork==1){
        workSecs=currSecs;
        currSecs=freeSecs;
        smallTxt.text = getTime(workSecs);
        bigTxt.text = getTime(currSecs);
        isWork=0;
        workBtn.checked=false;
        freeBtn.checked=true;
        startTimer();
    } else {
        if (isPaused)
            startTimer();
        else {
            pauseTimer();
            freeBtn.checked=false;
        }
    }
}

function pauseTimer(){
    tickTimer.stop();
    pauseBlink.start();
    isPaused=true;
    updateColor();
    workBtn.checked=false;
    freeBtn.checked=false;
}

function startTimer(){
    tickTimer.start();
    pauseBlink.stop();
    bigTxt.visible=true;
    isPaused=false;
    updateColor();
}

function getTime(secs){
    var sec   = Math.abs(Math.floor(secs)%60); //sek
    var min   = Math.abs(Math.floor(secs/60)%60); //min
    var hours = Math.abs(Math.floor(secs/60/60)%24); //hours
    if (sec.toString().length   == 1) sec   = '0' + sec;
    if (min.toString().length   == 1) min   = '0' + min;
    if (hours.toString().length == 1) hours = '0' + hours;
    return hours + ':' + min + ':' + sec;
}

function updateTimer(){
    currSecs+=1;
    bigTxt.text = getTime(currSecs);
}

function updateColor(){
    bigTxt.color = (Js.isWork)?bigTxt.workColor:bigTxt.freeColor;
}

function resetCounter(){
    console.log("reset counter");
    workSecs=0;
    freeSecs=0;
    currSecs=0;
    smallTxt.text = getTime(0);
    bigTxt.text = getTime(0);
}
