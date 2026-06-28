InitPlayerData:
InitPlayerData2:

	call Random
	ldh a, [hRandomSub]
	ld [wPlayerID], a

	call Random
	ldh a, [hRandomAdd]
	ld [wPlayerID + 1], a

	ld a, $ff
	ld [wUnusedPlayerDataByte], a

	ld hl, wPartyCount
	call InitializeEmptyList
	ld hl, wBoxCount
	call InitializeEmptyList
	ld hl, wNumBagItems
	call InitializeEmptyList
	ld hl, wNumBoxItems
	call InitializeEmptyList

DEF START_MONEY EQU $3000
	ld hl, wPlayerMoney + 1
	ld a, HIGH(START_MONEY)
	ld [hld], a
	xor a ; LOW(START_MONEY)
	ld [hli], a
	inc hl
	ld [hl], a

	ld [wMonDataLocation], a

	ld hl, wObtainedBadges
	ld [hli], a
	ASSERT wObtainedBadges + 1 == wUnusedObtainedBadges
	ld [hl], a

	ld hl, wPlayerCoins
	ld [hli], a
	ld [hl], a

	ld hl, wGameProgressFlags
	ld bc, wGameProgressFlagsEnd - wGameProgressFlags
	call FillMemory ; clear all game progress flags

<<<<<<< HEAD
	; Items Starter Pack(relative safe static item injection)
    ld a, 5                 ; Injecting 5 items
    ld [wNumBagItems], a    ; Set total bag count explicitly

    ld hl, wBagItems

    ld [hl], BICYCLE        ; Slot 1: Item ID
    inc hl
    ld [hl], 1              ; Slot 1: Quantity
    inc hl

    ld [hl], MASTER_BALL    ; Slot 2: Item ID
    inc hl
    ld [hl], 99              ; Slot 2: Quantity
    inc hl

    ld [hl], MAX_REPEL      ; Slot 3: Item ID
    inc hl
    ld [hl], 99              ; Slot 3: Quantity
    inc hl

    ld [hl], LEMONADE      ; Slot 4: Item ID
    inc hl
    ld [hl], 1              ; Slot 4: Quantity
    inc hl

    ld [hl], RARE_CANDY      ; Slot 5: Item ID
    inc hl
    ld [hl], 99              ; Slot 5: Quantity
    inc hl

    ld [hl], $ff            ; Place the hard stop terminator safely at the end!
    ; Fly anywhere
    dec a ; $ff (all bits)
    ld a, $ff
    ld [wTownVisitedFlag], a
    ld [wTownVisitedFlag + 1], a

	jp InitializeToggleableObjectsFlags

InitializeEmptyList:
	xor a ; count
	ld [hli], a
	dec a ; terminator
	ld [hl], a
	ret
