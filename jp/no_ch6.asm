.n64
.relativeinclude on

.create "no_ch6-jp.z64", 0
.incbin "pm-jp.z64"

;=======================================
; Data
;=======================================

.definelabel gGameStatus, 0x80074004
.definelabel gCurrentSaveFile, 0x800DACA0
.definelabel gPlayerData, 0x8010F450


;=======================================
; Functions
;=======================================

.definelabel evt_get_variable, 0x802C7ABC
.definelabel goto_map, 0x802CA304
.definelabel get_map_IDs_by_name, 0x8005A8B0
.definelabel set_map_transition_effect, 0x8013D350
.definelabel set_game_mode, 0x80033180
.definelabel add_badge, 0x800E76DC
.definelabel dma_copy, 0x800296FC
.definelabel get_global_flag, 0x8014A56C
.definelabel set_global_flag, 0x8014A500


;=======================================
; Hooks
;=======================================

.headersize (0x802CA408 - 0x000F25A8)

.org 0x802CA408
    jal goto_map_new

.org 0x802CA428
    jal goto_map_new

.org 0x802CA448
    jal goto_map_new


;=======================================
; Fix flower fields function addresses
;=======================================

.headersize (0x80740000 - 0x000CB7F20)

.org 0x80740180
    jal 0x807400D4

.org 0x80740190
    j 0x807401A4

.org 0x8074021C
    lui $s4, 0x8074

.org 0x8074022C
    lui $v1, 0x8074

.org 0x80740284
    jal 0x807400D4

.org 0x807402B4
    lui $a2, 0x8074

.org 0x807402D0
    j 0x807402FC

.org 0x8074037C
    j 0x807403EC

.org 0x80740ED0
    j 0x807403E0

.org 0x807403D0
    j 0x807403E0


;=======================================
; Custom Code
;=======================================

.headersize (0x80025C00 - 0x00001000)
.org 0x80033CC0 ; hook random boot function and use to dma our code
    lui $a0, hi(0x806A0000 - 0x80400000 + 0x02800000)
    lui $a1, hi(END - 0x80400000 + 0x02800000)
    ori $a1, $a1, lo(END - 0x80400000 + 0x02800000)
    lui $a2, 0x806A
    jal dma_copy
    nop
    jal dma_stuff


.headersize (0x80400000 - 0x02800000)
.org 0x806A0000
dma_stuff:
    addiu $sp, $sp, -0x04
    sw $ra, 0x00($sp)
    jal 0x80123434 ; displaced boot code
    nop
    jal 0x80125DC0
    nop
    jal 0x8003817C
    nop
    jal 0x801461B0
    nop

    li $a0, 0xCB0000 ; dma upgrade room stuff
    ori $a0, $a0, 0x7F20
    li $a1, 0xCB0000
    ori $a1, $a1, 0xE1E0
    jal dma_copy
    lui $a2, 0x8074

    lui $a0, 0x02B0 ; dma upgrade script
    lui $a1, 0x02B0
    addiu $a1, $a1, 0x0480
    jal dma_copy
    lui $a2, 0x8070

    li $v0, 0x2
    lw $ra, 0x00($sp)
    jr $ra
    addiu $sp, $sp, 0x04

goto_map_new:
    addiu $sp, $sp, -0x14
    sw $a0, 0x00($sp)
    sw $a1, 0x04($sp)
    sw $ra, 0x08($sp)

    lw $t0, 0x0C($a0)
    lw $a1, 0x00($t0) ; get area and map ids from Evt variables
    jal evt_get_variable
    addiu $t0, $t0, 0x04
    daddu $a0, $v0, $r0
    addiu $a1, $sp, 0x0C
    jal get_map_IDs_by_name
    addiu $a2, $sp, 0x10
    lw $a0, 0x00($sp) ; get entrance id from Evt variable
    lw $a1, 0x00($t0)
    jal evt_get_variable
    nop

    lhu $t1, 0x0C($sp) ; check if area is 0x13 (Chapter 6)
    addiu $t2, $r0, 0x13
    beq $t1, $t2, @@is_ch6
    nop

    bnez $t1, @@not_ch6 ; check if area is not 0 (not chapter 6 intro)
    nop

    lhu $t1, 0x10($sp) ; check map id
    addiu $t2, $r0, 0xD
    bne $t1, $t2, @@not_ch6
    nop

    bnez $v0, @@not_ch6 ; check entrance id
    nop

@@is_ch6:
    lui $t2, hi(gGameStatus)
    addiu $t2, $t2, lo(gGameStatus)
    addiu $t3, $r0, 0x01 ; set areaID
    sh $t3, 0x86($t2)
    addiu $t3, $r0, 0x02 ; set mapID
    sh $t3, 0x8C($t2)
    addiu $t3, $r0, 0x05 ; set entryID
    sh $t3, 0x8E($t2)

    ori $a0, $r0, 0x00 ; check if already triggered chapter 6 before
    jal get_global_flag
    nop
    bnez $v0, @@start_transition
    nop

    jal set_global_flag ; set flag
    ori $a0, $r0, 0x00

    lui $t1, hi(gCurrentSaveFile) ; set story byte
    addiu $t1, $t1, lo(gCurrentSaveFile)
    li $t2, 0x3C
    sb $t2, 0x10B0($t1)

    lui $t1, hi(gPlayerData) ; set star power
    addiu $t1, $t1, lo(gPlayerData)
    li $t2, 0x6
    sb $t2, 0x28E($t1)
    sb $t2, 0x290($t1)
    sb $t2, 0x291($t1)

    lb $t3, 0x0F($t1) ; set star pieces
    addiu $t2, $t3, 0x6
    sb $t2, 0x0F($t1)

    jal add_badge ; give badges
    addiu $a0, $r0, 0x010C
    jal add_badge
    addiu $a0, $r0, 0x0126
    jal add_badge
    addiu $a0, $r0, 0x0141

@@start_transition:
    jal set_map_transition_effect ; ending goto_map stuff
    addiu $a0, $r0, 0x01
    jal set_game_mode
    addiu $a0, $r0, 0x05
    j @@end
    nop

@@not_ch6:
    lw $a0, 0x00($sp)
    jal goto_map
    lw $a1, 0x04($sp)

@@end:
    lw $ra, 0x08($sp)
    jr $ra
    addiu $sp, $sp, 0x14

END:

.headersize (0x80259B88 - 0x00821EF8)
.org 0x80259B88
.incbin "door_script.bin"

.headersize (0x80400000 - 0x02800000)
.org 0x80700000
.incbin "upgrade.bin"

.close
