#Include, ./debugging.ahk
#Include, ./helpers.ahk
; METHODS
; 1. Bank
;   - Bank for Essence / Fill 3 essence pouches / Re-bank

; 2. Teleport to Duel Arena

; 3. Craft Lava Runes
;   - Cast Imbue / Use earth rune with altar / empty pouches / use

; 4. Teleport to CW

; -----------

; In-Game Hotkeys
; F1 = Inventory tab
; F2 = Magic tab
; F5 = Equipment tab

CoordMode, Mouse, Relative

rodCharges := 8
bindindNecklaceCharges := 16

inventoryCoords := Array()
inventoryCoords := []

bankCoords := Array()
bankCoords := []

equipmentCoords := Array()
equipmentCoords := []

spellCoords := Array()
spellCoords := []

altarCoords := Array()
altarCoords := []

; Build Array with mouse coorindates
Numpad0::
    ; reset arrays to empty
    global inventoryCoords := []
    global bankCoords := []
    global equipmentCoords := []
    global altarCoords := []
    global spellCoords := []

    MouseGetPos, X, Y
    inventoryCoords.Push({ "slot1X": X, "slot1Y": Y }) ; Small pouch
    inventoryCoords.Push({ "slot2X": X, "slot2Y": Y + 33 }) ; Medium pouch
    inventoryCoords.Push({ "slot3X": X, "slot3Y": Y + 66 }) ; Large pouch
    inventoryCoords.Push({ "slot4X": X, "slot4Y": Y + 99 }) ; Earth runes
    inventoryCoords.Push({ "equipItemX": X + 45, "equipItemY": Y })

    bankCoords.Push({ "chestX": X - 308, "chestY": Y - 60 })
    bankCoords.Push({ "essenceSlotX": X - 160, "essenceSlotY": Y - 90 })
    bankCoords.Push({ "essenceWithdrawX": X - 170, "essenceWithdrawY": Y + 10 })
    bankCoords.Push({ "rodX": X - 500, "rodY": Y + 25 })
    bankCoords.Push({ "bindingX": X - 450, "bindingY": Y + 25 })

    equipmentCoords.Push({ "ringSlotX": X + 115, "ringSlotY": Y + 155 })
    equipmentCoords.Push({ "duelArenaX": X + 85, "duelArenaY": Y +195 })
    equipmentCoords.Push({ "castleWarsX": X + 83, "castleWarsY": Y + 210 })
    equipmentCoords.Push({ "conCapeX": X + 20, "conCapeY": Y + 35 })

    altarCoords.Push({ "fireAltarX": X - 296, "fireAltarY": Y - 35 })
    altarCoords.Push({ "entranceX": X - 332, "entranceY": Y - 132 })

    spellCoords.Push({ "imbueX": X + 60, "imbueY": Y + 120 })

return

; BANK
Numpad1::
    Random, clickAltarDelay, 2000, 2100
    BlockInput, On
    global rodCharges

    if (rodCharges == 0) {
        ; withdraw ring of dueling
        ; right click and equip
        getNewJewelry("ring")
    }
    if (bindindNecklaceCharges == 0) {
        ; withdraw necklace of binding
        ; right click and equip
        getNewJewelry("necklace")

    }
    ; openBank()
    withdrawEssence()
    clickAllPouches(False)
    openBank()
    withdrawEssence()
    teleportTo("da")
    customMouseMove(altarCoords[2]["entranceX"], altarCoords[2]["entranceY"])
    Sleep, clickAltarDelay
    MouseClick, Left
    BlockInput, Off
return

; FIRE ALTAR
Numpad2::
    Random, imbueDelay, 2050, 2175
    Random, mouseSpeed, 2.1, 3.2
    BlockInput, On
    MouseMove, 675, 142, mouseSpeed
    MouseClick, Left
    Sleep, imbueDelay
    castImbue()
    craftLavaRunes()
    teleportTo("cw")
    BlockInput, Off
return

; Individual testing
Numpad3::
    ; testMouseMovements()
    global altarCoords

    customMouseMove(altarCoords[2]["entranceX"], altarCoords[2]["entranceY"])
return

Numpad4::
    ; Reset RoD Charge count
    global rodCharges
    rodCharges := 8
    MsgBox, % "Reset RoD charges = " rodCharges
return

Numpad5::
    ; Reset RoD Charge count
    global bindindNecklaceCharges
    bindindNecklaceCharges := 16
    MsgBox, % "Reset binding charges = " bindindNecklaceCharges

return

Numpad6::
    ; Reset BOTH Charge count
    global rodCharges
    global bindindNecklaceCharges
    bindindNecklaceCharges := 16
    rodCharges := 8
    MsgBox, % "Reset BOTH Rod = " rodCharges " & bindind = " bindindNecklaceCharges 
return

NumpadAdd::
    global rodCharges
    global bindindNecklaceCharges
    ; Input custom values for binding and RoD rodCharges
    InputBox, bindingVal , "Bindind Necklace Charges", "How many charges does your binding necklace have?"
    InputBox, rodVal , "RoD Charges", "How many charges does your RoD have?"

    rodCharges := rodVal
    bindindNecklaceCharges := bindingVal

    MsgBox, % "RoD Charges = " rodCharges
    MsgBox, % "Necklace Charges = " bindindNecklaceCharges

return 