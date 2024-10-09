            IFND SE30
SE30        EQU 0
            ENDIF

            IF SE30
VIA2        EQU 1
            INCLUDE 'ROMTools/Hardware/SE30.s'
            ENDIF

            IFND VIA2
VIA2        EQU 0
            ENDIF

ViaBufRead:
            moveq   #0,D6                           ; Clear D6
            lea     VBase,A2                        ; Load VIA address
            move.b  (vBufA,A2),D6
            lsl.l   #8,D6
            move.b  (vBufB,A2),D6
            IF VIA2
            swap    D6
            lea     VBase2,A2
            move.b  (vBufA,A2),D6
            lsl.w   #8,D6
            move.b  (vBufB,A2),D6
            swap    D6
            ENDIF
            jmp     (A6)                            ; Return to caller

