var workSecs=0;
var freeSecs=0;
var currSecs=0;
var isWork=0;
var isPaused=true;

function setWork() {
    if (isWork==0){
        freeSecs=currSecs;
        currSecs=workSecs;
        smallTxt.text = bigTxt.text;
        updateTimer();
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
        smallTxt.text = bigTxt.text;
        updateTimer();
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
}

function startTimer(){
    tickTimer.start();
    pauseBlink.stop();
    bigTxt.visible=true;
    isPaused=false;
    updateColor();
}

function updateTimer(){
    currSecs+=1;
    var sec   = Math.abs(Math.floor(currSecs)%60); //sek
    var min   = Math.abs(Math.floor(currSecs/60)%60); //min
    var hours = Math.abs(Math.floor(currSecs/60/60)%24); //hours
    if (sec.toString().length   == 1) sec   = '0' + sec;
    if (min.toString().length   == 1) min   = '0' + min;
    if (hours.toString().length == 1) hours = '0' + hours;
    bigTxt.text = hours + ':' + min + ':' + sec;
}

function updateColor(){
    bigTxt.color = (Js.isWork)?"#d4ec0e":"#0dedd4";
}
