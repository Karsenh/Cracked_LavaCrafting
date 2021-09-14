#Include, ./helpers.ahk
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

; DEBUGGING - Print Current Mouse Coordinates
NumpadEnter::
    MouseGetPos, X, Y
    MsgBox, % "X = " X " & Y = " Y
return

randomMouseMove() {
    variances := randVariances()
    mouseSpeed := variances["mouseSpeed"]
    pixelDev := variances["pixelDev"]
    actionDelay := variances["actionDelay"]

    Random, randX, 50, 550
    Random, randY, 50, 550

    ; ToolTip, % "Moving to XY " randX " " randY
    customMouseMove(randX, randY)
    Sleep, delay
}

testRandomMouseMovements() {
    Loop, 5 {
        randomMouseMove()
    }
}

testMouseMovements() {

    global inventoryCoords
    global bankCoords
    global equipmentCoords
    global spellCoords
    global altarCoords

    variance := randVariances()
    rDelay := variance["actionDelay"]

    essPouch1X := inventoryCoords[1]["slot1X"]
    essPouch1Y := inventoryCoords[1]["slot1Y"]

    essPouch2X := inventoryCoords[2]["slot2X"]
    essPouch2Y := inventoryCoords[2]["slot2Y"]

    essPouch3X := inventoryCoords[3]["slot3X"]
    essPouch3Y := inventoryCoords[3]["slot3Y"]

    earthRunesX := inventoryCoords[4]["slot4X"]
    earthRunesY := inventoryCoords[4]["slot4Y"]

    ; Bank
    bankX := bankCoords[1]["chestX"]
    bankY := bankCoords[1]["chestY"]

    ; Pure Essence (in Bank)
    pEssX := bankCoords[2]["essenceSlotX"]
    pEssY := bankCoords[2]["essenceSlotY"]
    ; Withdraw Pure Essence
    pEssWithdrawX := bankCoords[3]["essenceWithdrawX"]
    pEssWithdrawY := bankCoords[3]["essenceWithdrawY"]

    ; Ring (in Bank)
    rodX := bankCoords[4]["rodX"]
    rodY := bankCoords[4]["rodY"]

    ; Necklace (in Bank)
    necklaceX := bankCoords[5]["bindingX"]
    necklaceY := bankCoords[5]["bindingY"]

    ; Ring (in Equipment)
    ringSlotX := equipmentCoords[1]["ringSlotX"]
    ringSlotY := equipmentCoords[1]["ringSlotY"]
    ; Right click Ring Duel Arena
    ringSlotDAX := equipmentCoords[2]["duelArenaX"]
    ringSlotDAY := equipmentCoords[2]["duelArenaY"]
    ; Right click ring Castle Wars
    ringSlotCWX := equipmentCoords[3]["castleWarsX"]
    ringSlotCWY := equipmentCoords[3]["castleWarsY"]

    ; Imbue spell (in Magic tab)
    imbueX := spellCoords[1]["imbueX"]
    imbueY := spellCoords[1]["imbueY"]

    capeX := equipmentCoords[4]["conCapeX"]
    capeY := equipmentCoords[4]["conCapeY"]

    adtlVar := 1000

    customMouseMove(essPouch1X, essPouch1Y)
    customMouseMove(essPouch2X, essPouch2Y)
    customMouseMove(essPouch3X, essPouch3Y)

    customMouseMove(earthRunesX, earthRunesY)

    customMouseMove(bankX, bankY)
    Sleep, adtlVar
    MouseClick, Left
    Sleep, adtlVar

    customMouseMove(pEssX, pEssY)
    Sleep, adtlVar
    MouseClick, Right
    Sleep, adtlVar
    customMouseMove(pEssWithdrawX, pEssWithdrawY)
    Sleep, adtlVar

    customMouseMove(rodX, rodY)
    Sleep, adtlVar

    customMouseMove(necklaceX, necklaceY)
    Sleep, adtlVar

    ; Exit Bank
    Send, {Esc}
    ; Open Equipment tab
    Send, {F5}

    customMouseMove(ringSlotX, ringSlotY)
    Sleep, adtlVar
    MouseClick, Right

    customMouseMove(ringSlotCWX, ringSlotCWY)
    Sleep, adtlVar

    customMouseMove(ringSlotDAX, ringSlotDAY)
    Sleep, adtlVar

    customMouseMove(capeX, capeY)
    Sleep, adtlVar

    ;  Open Magic tab
    Send, {F2}
    customMouseMove(imbueX, imbueY)
    Sleep, adtlVar

}