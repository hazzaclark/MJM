;----------------------------------------------------------
;       MICHAEL JACKSON'S MOONWALKER DECOMPILATION
;              (C) HARRY CLARK 2023
;----------------------------------------------------------

;----------------------------------------------------------
;
;     THIS FILE PERTAINS TO THE HEADER FILE OF THE
;     MOTOROLA 68000, DEFININNG THE VECTOR TABLE TO
;     MEET SPECIFIC ARGS BEFORE THE GAME'S EXECUTION    
;
;----------------------------------------------------------

GAME_HEADER:

    ORG              $0000000000
    DC.L             SUPERVISOR_STACK_POINTER
    DC.L             BUS_ERROR
    DC.L             STACK_ERROR
    DC.L             ADDRESS_ERROR
    DC.L             ILLEGAL_INSTRUCTION
    DC.L             BRA_OR_SET_UC
    DC.L             INEXACT_RESULT
    DC.L             UNDERFLOW
    DC.L             OVERFLOW
    DC.L             NAN_SIG
    DC.L             MMU_CONFIG_ERROR
    DC.L             MMU_ACCESS_ERROR


    ;; INTERRUPT REQUEST HANDLERS

    DC.L             IRQ_1
    DC.L             IRQ_2
    DC.L             IRQ_3
    DC.L             HBLANK  
    DC.L             IRQ_5
    DC.L             VBLANK   
    DC.L             IRQ_7

    ;; MATHEMATICAL EXCEPTION HANDLERS

    DC.L             ZERO_DIV
    DC.L             DVIDE
    DC.L             CHECK_EXC
    DC.L             TRAP_V_EXC
    DC.L             PRIVILAGE_EXC
    DC.L             TRACE_EXC

    ;; INTERLACE NAME TABLE

    DC.L             INTERLACE_A_MODE
    DC.L             INTERLACE_B_MODE
    DC.L             INTERLACE_F_MODE

    ;; THE TRAPS ON THE M68K ARE THE MICRO-PROCESSOR'S WAY OF
    ;; HANDLING EXCEPTIONS 


    DC.L             TRAP_00
    DC.L             TRAP_01
    DC.L             TRAP_02
    DC.L             TRAP_03
    DC.L             TRAP_04
    DC.L             TRAP_05
    DC.L             TRAP_06
    DC.L             TRAP_07
    DC.L             TRAP_08
    DC.L             TRAP_09
    DC.L             TRAP_10
    DC.L             TRAP_11
    DC.L             TRAP_12
    DC.L             TRAP_13
    DC.L             TRAP_14
    DC.L             TRAP_15

;----------------------------------------------------------
;                       END OF FILE
;----------------------------------------------------------
