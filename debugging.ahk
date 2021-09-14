#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

; DEBUGGING - Print Current Mouse Coordinates
NumpadEnter::
    MouseGetPos, X, Y
    MsgBox, % "X = " X " & Y = " Y
return

randomMouseMove(speed, delay) {
    Random, randX, 100, 500
    Random, randY, 100, 500

    MsgBox, % "Moving to XY " randX " " randY
    MouseMove, randX, randY, speed
    Sleep, delay
}

testVariances() {
    variances := randVariances()
    mouseSpeed := variances["mouseSpeed"]
    pixelDev := variances["pixelDev"]
    actionDelay := variances["actionDelay"]

    ; moveSpeed := 100

    MsgBox, % "TESTING VARIANCES: mouseSpeed = " mouseSpeed " | pixelDev = " pixelDev " | actionDelay = " actionDelay
    MsgBox, % "Mouse moveSpeed = " mouseSpeed

    randomMouseMove(mouseSpeed, actionDelay)
    randomMouseMove(mouseSpeed, actionDelay)
    randomMouseMove(mouseSpeed, actionDelay)
    randomMouseMove(mouseSpeed, actionDelay)

}