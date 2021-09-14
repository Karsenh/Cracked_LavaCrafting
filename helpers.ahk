#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

randVariances() {
    Random mouseMoveSpeedDev, 3.1, 4.1
    Random pixelCoordDev, 5, 15
    Random actionDelayDev, 550, 775

    variancesObject := Object("mouseSpeed", mouseMoveSpeedDev, "pixelDev", pixelCoordDev, "actionDelay", actionDelayDev)

    return variancesObject
}

clickAllPouches(isWithdraw) {
    global inventoryCoords

    variance := randVariances()
    mouseSpeed := variance["mouseSpeed"]
    pixelDev := variance["pixelDev"]
    delayDev := variance["actionDelay"]

    ; Open inventory
    Send, {F1}

    if (isWithdraw) {
        ; Shift + Left click 
        MouseMove, inventoryCoords[1]["slot1X"] + pixelDev, inventoryCoords[1]["slot1Y"] + pixelDev, mouseSpeed
        Send, {Shift Down}
        MouseClick, Left

        MouseMove, inventoryCoords[2]["slot2X"] + pixelDev, inventoryCoords[2]["slot2Y"] + pixelDev, mouseSpeed
        MouseClick, Left

        MouseMove, inventoryCoords[3]["slot3X"] + pixelDev, inventoryCoords[3]["slot3Y"] + pixelDev, mouseSpeed
        MouseClick, Left 
        Send, {Shift Up}
        Sleep, delayDev + 150
    } else {
        ; Regular Left click
        MouseMove, inventoryCoords[1]["slot1X"] + pixelDev, inventoryCoords[1]["slot1Y"] + pixelDev, mouseSpeed
        MouseClick, Left
        MouseMove, inventoryCoords[2]["slot2X"] + pixelDev, inventoryCoords[2]["slot2Y"] + pixelDev, mouseSpeed
        MouseClick, Left
        MouseMove, inventoryCoords[3]["slot3X"] + pixelDev, inventoryCoords[3]["slot3Y"] + pixelDev, mouseSpeed
        MouseClick, Left
    }

}

withdrawEssence() {
    global bankCoords

    variance := randVariances()
    mouseSpeed := variance["mouseSpeed"]
    pixelDev := variance["pixelDev"]
    delayDev := variance["actionDelay"]

    MouseMove, bankCoords[2]["essenceSlotX"] + pixelDev, bankCoords[2]["essenceSlotY"] + pixelDev, mouseSpeed
    MouseClick, Right
    MouseMove, bankCoords[3]["essenceWithdrawX"] + pixelDev, bankCoords[3]["essenceWithdrawY"] + pixelDev, mouseSpeed
    MouseClick, Left
    Send {Esc}
    Sleep, delayDev
}

openBank() {
    global bankCoords
    variance := randVariances()
    mouseSpeed := variance["mouseSpeed"]
    delayDev := variance["actionDelay"]

    MouseMove bankCoords[1]["chestX"], bankCoords[1]["chestY"], mouseSpeed
    MouseClick, Left
    Sleep, delayDev + 200
}

teleportTo(location) {
    global equipmentCoords
    global rodCharges

    variance := randVariances()
    mouseSpeed := variance["mouseSpeed"]
    pixelDev := variance["pixelDev"]
    delayDev := variance["actionDelay"]

    ; Open equipment tab 
    Send, {F5}
    ; Move mouse to Ring of Dueling
    MouseMove, equipmentCoords[1]["ringSlotX"] + pixelDev, equipmentCoords[1]["ringSlotY"] + pixelDev, mouseSpeed
    ; Right click ring
    MouseClick, Right

    ; Conditonally select CW or DA
    if (location == "da") {
        ; Duel arena
        ; MsgBox, "Teleporting to: Duel Arena"
        MouseMove, equipmentCoords[2]["duelArenaX"] + pixelDev, equipmentCoords[2]["duelArenaY"] + pixelDev, mouseSpeed

    } else {
        ; Castle Wars
        ; MsgBox, % "Teleporting to: Castle Wars with location value = " location
        MouseMove, equipmentCoords[3]["castleWarsX"] + pixelDev, equipmentCoords[3]["castleWarsY"] + pixelDev, mouseSpeed
    }
    ; Click RoD teleport
    MouseClick, Left

    rodCharges -= 1

}

castImbue() {
    ; Open Magic tab
    global spellCoords

    variance := randVariances()
    mouseSpeed := variance["mouseSpeed"]
    pixelDev := variance["pixelDev"]
    delayDev := variance["actionDelay"]

    ; Open Magic tab
    Send, {F2}

    ; Move mouse to Imbue spell
    MouseMove, spellCoords[1]["imbueX"] + pixelDev, spellCoords[1]["imbueY"] + pixelDev, mouseSpeed

    ; MsgBox, % "Casting Imbue! coords: " spellCoords[1]["imbueX"] " " spellCoords[1]["imbueY"]
    MouseClick, Left

    Sleep, delayDev
}

useEarthRunesWithAltar() {
    global inventoryCoords
    global altarCoords
    global bindindNecklaceCharges

    variance := randVariances()
    mouseSpeed := variance["mouseSpeed"]
    pixelDev := variance["pixelDev"]
    delayDev := variance["actionDelay"]

    ; Mousemove to Earth runes
    MouseMove, inventoryCoords[4]["slot4X"] + pixelDev, inventoryCoords[4]["slot4Y"] + pixelDev, mouseSpeed
    ; Select Earth runes
    MouseClick, Left
    ; Mousemove to Fire Altar
    MouseMove, altarCoords[1]["fireAltarX"] + pixelDev, altarCoords[1]["fireAltarY"] + pixelDev, mouseSpeed
    ; Use Earth runes with Fire Altar to craft Lavas
    MouseClick, Left

    bindindNecklaceCharges -= 1

    ; wait for crafting stall
    Sleep, delayDev + 250
}

craftLavaRunes() {
    ; Open inventory
    Send, {F1}
    useEarthRunesWithAltar()
    clickAllPouches(true)
    useEarthRunesWithAltar()
}

getNewJewelry(jewelryType) {
    global bankCoords
    global inventoryCoords

    variance := randVariances()
    rDelay := variance["actionDelay"]
    mouseSpeed := variance["mouseSpeed"]

    if (jewelryType == "ring") {
        ; Assumes bank is already open
        MouseMove, bankCoords[4]["rodX"], bankCoords[4]["rodY"], mouseSpeed
        MouseClick, Left
        Sleep, rDelay
        MouseMove, inventoryCoords[5]["equipItemX"], inventoryCoords[5]["equipItemY"], mouseSpeed
        Sleep, rDelay
        MouseClick, Right
        MouseMove, inventoryCoords[5]["equipItemX"] - 30, inventoryCoords[5]["equipItemY"] + 120, mouseSpeed
        Sleep, rDelay
        MouseClick, Left

    } else if (jewelryType == "necklace") {
        ; Assumes bank is already open
        MouseMove, bankCoords[5]["bindingX"], bankCoords[5]["bindingY"], mouseSpeed
        MouseClick, Left
        Sleep, rDelay
        ; Mousemove to inventory slot (next to origin)
        MouseMove, inventoryCoords[5]["equipItemX"], inventoryCoords[5]["equipItemY"], mouseSpeed
        Sleep, rDelay
        ; Right click necklace
        MouseClick, Right
        ; Mousemove to 'Equip'
        MouseMove, inventoryCoords[5]["equipItemX"] - 32, inventoryCoords[5]["equipItemY"] + 120, mouseSpeed
        Sleep, rDelay
        ; Click to equip
        MouseClick, Left
    }

}