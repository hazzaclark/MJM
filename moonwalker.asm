;----------------------------------------------------------
;       MICHAEL JACKSON'S MOONWALKER DECOMPILATION
;              (C) HARRY CLARK 2024
;----------------------------------------------------------

include "macros.asm"
include "header.asm"

SRAM:

ENABLE_SRAM         EQU          0
BACKUP_SRAM         EQU          1
SRAM_ADDR           EQU          2

CARTRIDGE_INIT:

;; SET REV TO 0 FOR ORIGINAL VERSION
;; SET REV TO 1 FOR THE WORLD VERSION (NTSC AND JPN)

GAME_REV            =          1

DC.B                 "SEGA MEGA DRIVE "                            ;; CONSOLE NAME
DC.B                 "(C)SEGA 1990.JUL"                            ;; RELEASE DATE
DC.B                 "MICHAEL JACKSON          FS MOONWALKER"      ;; DOMESTIC NAME

if GAME_REV=0

DC.B "GM 00004028-01"                                              ;; GAME VERSION - DOMESTIC
else 

DC.B "GM 00004048-00"                                              ;; GAME VERSION - NON-DOM

endif

SETUP_IO:

    DC.B                 "J              "                             ;; IO SUPPORT 
    DC.L                  CARTRIDGE_INIT
    DC.L                  END_OF_CARTRIDGE-1

    DC.B                  RAM_START             $FF0000
    DC.B                  RAM_END               $FFFFFF

CHECKSUM:

if GAME_REV=0
    DC.W        $96FH
else
    DC.W        $AFC7
endif

ROM_SRAM:

    DC.B    "       "                           ;; SRAM CODE (SEEMS TO BE UNUSED)
    DC.L    $20202020                           ;; SRAM START
    DC.L    $20202020                           ;; SRAM END

Z80_LOOKUP:

    TST.L                   (Z80_CTRL).L                            ;; TEST THE LONG LENGTH OF THE Z80'S REGISTERS (A, B)
    BNE.W                   Z80_INIT                                ;; Z80 INITILISATION FUNCTION USING CHECK ZERO OR NON-ZERO
    TST.W                   (Z80_EXT_CTRL).L                        ;; TEST THE LONG LENGTH OF THE Z80'S REGISTERS (C)

Z80_INIT:                                                       ;; THIS IS ALSO REFERRED TO AS THE RESET COROUTINE - CALLED WHEN THE Z80 IS RE-INITIALISED ON BOOT

    BNE.B                   Z80_LOOKUP                          ;; SKIPS THE COROUTINE CHECK TO INITIALISE CONTROL REGISTERS
    LEA                     VDP_SETUP($88, PC), A5                 ;; LOAD EFFECTIVE ADDRESS INTO THE VDP VALUE SETUP MACRO - LOADING FROM THE ARRAY STRUCTURE
                                                                    ;; SEE ADDRESSING CAPABILITIES - FIGURE 2.4 https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf

    MOVEM.L                 (A5)+,D5-D7                             ;; PERFROM A MULTI-REG PUSH ARGUMENT FROM THE ARRAY STRUCT INTO D5 THROUGH TO D7
    MOVE.W                  (-0x1100, A1)=>Z80_PCB_VER, D0          ;; ALLOCATE THE Z80 PCB INTO THE CORRESPONDING ADDRESS AND DATA REGSITERS 
                                                                    ;; ACCORDING TO THE MEMORY MAP, THE Z80 IS CALLED AT THE PROVIDED ADDRESS REGISTER, WITH A DEDICATED
                                                                    ;; SIZE ALLOCATED ONTO THE ROM https://wiki.megadrive.org/index.php?title=Main_68k_memory_map

    ANDI.W                  #$0F00, D0                                  ;; DISCERN AN AND LOGICAL OPERATIONS BETWEEN THE SOURCE ADDRESS AND THE NEW DESTINATION OF THE VALUE 
    BEQ.B                   VDP_RESET                                   ;; COUROUTINE TO CHECK IF THE CART CORRESPONDS WITH THE DESTINATION OPERAND LOCATED IN THE CCR , OTHERWISE THE VDP WILL RESET 
    MOVE.L                  #$53454741, ($2F00, A1)=>IO_TMSS          ;; IF THE CCR IS FOUND, CHECK FOR TMSS

;; SINCE THIS REVISION OF MOONWALKER DOESN'T SUPPORT NATIVE TMSS
;; THIS SECTION WILL ENCOMPASS A COROUTINE SUCH THAT IT WON'T LOOK FOR ANYTHING  

IO_TMSS:

    MOVE.W                  (A4),D0                                     ;; CLEAR WRITE PENDING FLAGS IN VDP TO PREVENT OVERFLOWS
    MOVEQ                   #0, D0                                      ;; CLEAR DATA REG 0, WHICH FLUSHES THE OPERAND
    MOVEA.L                 D0, A6                                      ;; CLEAR ADDRESS REG 6, WHICH STORES THE USP
    MOVE.L                  A6, USP                                     ;; SET USER STACK POINTER TO NULL

VDP_RESET:

    MOVE.W                  (A4)=>VDP_CTRL, D0                          ;; MOVE THE VDP CONTROL CACHE INTO D0
    MOVEQ                   #$00, D0                                    ;; SET D0'S CONTENTS AND PRECEEDING CORRESPONDENCE TO NULL
    MOVEA.L                 D0, A6
    MOVE                    A6, USP                                     ;; MOVE THIS INTO THE USP
    MOVEQ                   #$17, D1

;; ASSUMING THAT THE VDP HAS BEEN RESET THROUGH SOFT OR HARD RESET
;; WE CAN BEGIN TO SETUP IT'S CORRESPONDENCE

VDP_SETUP:

    DC.W                    $8000                                       ;; VDP INITIAL ADDRESS
    DC.W                    $3FFF                                       ;; SIZE OF VDP DMA
    DC.W                    $100                                        ;; VDP REGISTER OFFSET

    DC.L                    $40000080                                   ;; VRAM ADDRESS
 
END_OF_CARTRIDGE:

        END
