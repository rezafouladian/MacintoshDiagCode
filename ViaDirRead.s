        IFND SE30
SE30        EQU 0
        ENDIF

        IFND SE
SE          EQU 0
        ENDIF

        IFND Portable
Portable    EQU 0
        ENDIF

        IF SE30
VIA2        EQU 1
            INCLUDE 'ROMTools/Hardware/SE30.s'
        ENDIF

        IF SE
VIA2        EQU 0
            INCLUDE 'ROMTools/Hardware/SE.s'
        ENDIF

        IF Portable
VIA2        EQU 0
            INCLUDE 'ROMTools/Hardware/Portable.s'
        ENDIF

        IFND VIA2
VIA2        EQU 0
        ENDIF

; ViaDirRead
;
; Read the contents of the VIA direction registers
; Output format is $CCDDAABB
; CC = VIA 2 Direction A
; DD = VIA 2 Direction B
; AA = VIA 1 Direction A
; BB = VIA 2 Direction B
; Output is returned in D6
ViaDirRead:
            moveq   #0,D6
            lea     VBase,A2
            move.b  (vDIRA,A2),D2
            lsl.l   #8,D6
            move.b  (vDIRB,A2),D6
        IF VIA2
            swap    D6
            lea     VBase2,A2
            move.b  (vDIRA,A2),D2
            lsl.w   #8,D6
            move.b  (vDIRB,A2),D6
            swap    D6
        ENDIF
            jmp     (A6)
