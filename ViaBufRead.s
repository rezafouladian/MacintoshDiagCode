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

; ViaBufRead
;
; Read the contents of the VIA data registers
; Output format is $CCDDAABB
; CC = VIA 2 Buffer A
; DD = VIA 2 Buffer B
; AA = VIA 1 Buffer A
; BB = VIA 2 Buffer B
; Output is returned in D6
ViaBufRead:
            moveq   #0,D6                           ; Clear D6
            lea     VBase,A2                        ; Load VIA address
            move.b  (vBufA,A2),D6                   ; Read buffer A
            lsl.l   #8,D6                           ; Make room for B
            move.b  (vBufB,A2),D6                   ; Read buffer B
        IF VIA2
            swap    D6                              ; Swap for VIA 2
            lea     VBase2,A2                       ; Load VIA 2 address
            move.b  (vBufA,A2),D6                   ; Read buffer A
            lsl.w   #8,D6                           ; Make room for B
            move.b  (vBufB,A2),D6                   ; Read buffer B
            swap    D6                              ; Swap back
        ENDIF
            jmp     (A6)                            ; Return to caller
