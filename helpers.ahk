#Include, ./debugging.ahk
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

randVariances() {
    Random mouseMoveSpeedDev, 3.25, 4.2
    Random pixelCoordDev, -3, 3
    Random actionDelayDev, 550, 825

    variancesObject := Object("mouseSpeed", mouseMoveSpeedDev, "pixelDev", pixelCoordDev, "actionDelay", actionDelayDev)

    return variancesObject
}

customMouseMove(X, Y) {
    variance := randVariances()
    pixeldDev := variance["pixelDev"]
    mouseSpeed := variance["mouseSpeed"]

    MouseMove, X+pixeldDev, Y+pixeldDev, mouseSpeed

    variance := randVariances()
    pixeldDev := variance["pixelDev"]
    mouseSpeed := variance["mouseSpeed"]

    MouseMove, X+pixeldDev, Y+pixeldDev, mouseSpeed

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
        customMouseMove(inventoryCoords[1]["slot1X"], inventoryCoords[1]["slot1Y"])
        Send, {Shift Down}
        MouseClick, Left
        customMouseMove(inventoryCoords[2]["slot2X"], inventoryCoords[2]["slot2Y"])
        MouseClick, Left
        customMouseMove(inventoryCoords[3]["slot3X"], inventoryCoords[3]["slot3Y"])
        MouseClick, Left 
        Send, {Shift Up}
    } else {
        ; Regular Left click
        customMouseMove(inventoryCoords[1]["slot1X"], inventoryCoords[1]["slot1Y"] )
        MouseClick, Left
        customMouseMove(inventoryCoords[2]["slot2X"],inventoryCoords[2]["slot2Y"])
        MouseClick, Left
        customMouseMove(inventoryCoords[3]["slot3X"], inventoryCoords[3]["slot3Y"])
        MouseClick, Left
    }

    Random, adtlDelayVariance, 35, 65
    Sleep, delayDev + adtlDelayVariance

}

withdrawEssence() {
    global bankCoords

    variance := randVariances()
    mouseSpeed := variance["mouseSpeed"]
    pixelDev := variance["pixelDev"]
    delayDev := variance["actionDelay"]

    customMouseMove(bankCoords[2]["essenceSlotX"], bankCoords[2]["essenceSlotY"])
    ; MouseMove, bankCoords[2]["essenceSlotX"] + pixelDev, bankCoords[2]["essenceSlotY"] + pixelDev, mouseSpeed
    MouseClick, Right
    customMouseMove(bankCoords[3]["essenceWithdrawX"], bankCoords[3]["essenceWithdrawY"])
    ; MouseMove, bankCoords[3]["essenceWithdrawX"] + pixelDev, bankCoords[3]["essenceWithdrawY"] + pixelDev, mouseSpeed
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

    ; Conditonally select CW or DA
    if (location == "da") {
        customMouseMove(equipmentCoords[1]["ringSlotX"], equipmentCoords[1]["ringSlotY"])
        ; MouseMove, equipmentCoords[1]["ringSlotX"] + pixelDev, equipmentCoords[1]["ringSlotY"] + pixelDev, mouseSpeed
        ; Right click ring
        MouseClick, Right
        ; Duel arena
        ; MsgBox, "Teleporting to: Duel Arena"
        customMouseMove(equipmentCoords[2]["duelArenaX"], equipmentCoords[2]["duelArenaY"])
        ; MouseMove, equipmentCoords[2]["duelArenaX"] + pixelDev, equipmentCoords[2]["duelArenaY"] + pixelDev, mouseSpeed

    } else if (location == "home") {
        ; Mousemove to construction cape
        customMouseMove(equipmentCoords[4]["conCapeX"], equipmentCoords[4]["conCapeY"])
        MouseClick, Right
        customMouseMove(equipmentCoords[4]["conCapeX"] - 25, equipmentCoords[4]["conCapeY"] + 72)
        MouseClick, Left

        ; Shift + 
    } else {
        customMouseMove(equipmentCoords[1]["ringSlotX"], equipmentCoords[1]["ringSlotY"])
        ; MouseMove, equipmentCoords[1]["ringSlotX"] + pixelDev, equipmentCoords[1]["ringSlotY"] + pixelDev, mouseSpeed
        ; Right click ring
        MouseClick, Right
        ; Castle Wars
        ; MsgBox, % "Teleporting to: Castle Wars with location value = " location
        customMouseMove(equipmentCoords[3]["castleWarsX"], equipmentCoords[3]["castleWarsY"])
        ; MouseMove, equipmentCoords[3]["castleWarsX"] + pixelDev, equipmentCoords[3]["castleWarsY"] + pixelDev, mouseSpeed
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
    customMouseMove(spellCoords[1]["imbueX"], spellCoords[1]["imbueY"])
    ; MouseMove, spellCoords[1]["imbueX"] + pixelDev, spellCoords[1]["imbueY"] + pixelDev, mouseSpeed

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
    customMouseMove(inventoryCoords[4]["slot4X"], inventoryCoords[4]["slot4Y"])
    ; MouseMove, inventoryCoords[4]["slot4X"] + pixelDev, inventoryCoords[4]["slot4Y"] + pixelDev, mouseSpeed
    ; Select Earth runes
    MouseClick, Left
    ; Mousemove to Fire Altar
    customMouseMove(altarCoords[1]["fireAltarX"], altarCoords[1]["fireAltarY"])
    ; MouseMove, altarCoords[1]["fireAltarX"] + pixelDev, altarCoords[1]["fireAltarY"] + pixelDev, mouseSpeed
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
        customMouseMove(bankCoords[4]["rodX"], bankCoords[4]["rodY"])
        ; MouseMove, bankCoords[4]["rodX"], bankCoords[4]["rodY"], mouseSpeed
        MouseClick, Left
        Sleep, rDelay
        customMouseMove(inventoryCoords[5]["equipItemX"], inventoryCoords[5]["equipItemY"])
        ; MouseMove, inventoryCoords[5]["equipItemX"], inventoryCoords[5]["equipItemY"], mouseSpeed
        Sleep, rDelay
        MouseClick, Right
        customMouseMove(inventoryCoords[5]["equipItemX"] - 30, inventoryCoords[5]["equipItemY"] + 120)
        ; MouseMove, inventoryCoords[5]["equipItemX"] - 30, inventoryCoords[5]["equipItemY"] + 120, mouseSpeed
        Sleep, rDelay
        MouseClick, Left

    } else if (jewelryType == "necklace") {
        ; Assumes bank is already open
        customMouseMove(bankCoords[5]["bindingX"], bankCoords[5]["bindingY"])
        ; MouseMove, bankCoords[5]["bindingX"], bankCoords[5]["bindingY"], mouseSpeed
        MouseClick, Left
        Sleep, rDelay
        ; Mousemove to inventory slot (next to origin)
        customMouseMove(inventoryCoords[5]["equipItemX"], inventoryCoords[5]["equipItemY"])
        ; MouseMove, inventoryCoords[5]["equipItemX"], inventoryCoords[5]["equipItemY"], mouseSpeed
        Sleep, rDelay
        ; Right click necklace
        MouseClick, Right
        ; Mousemove to 'Equip'
        customMouseMove(inventoryCoords[5]["equipItemX"] - 32, inventoryCoords[5]["equipItemY"] + 120)
        ; MouseMove, inventoryCoords[5]["equipItemX"] - 32, inventoryCoords[5]["equipItemY"] + 120, mouseSpeed
        Sleep, rDelay
        ; Click to equip
        MouseClick, Left
    }

}