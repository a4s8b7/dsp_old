CLS
SCREEN 7
DIR$ = "IN"
TOM = 1
rew = 5
LzX = 1               'Y
LzY = 100
RzY = 100
RzX = 200
TOP1 = 1
TOP2 = 100
B1 = 199
B2 = 100
':::::::::::::::::::::::::::::::::::
10
FOR DIMUND = 1 TO 2000
        GOSUB CHECK
        GOSUB MAKER
        GOSUB PAUSEE
NEXT DIMUND
END
':::::::::::::::::::::::::::::::::::
MAKER:
LINE (TOP2, TOP1)-(LzX, LzY), (rew)
LINE (TOP2, TOP1)-(RzX, RzY), (rew2)
LINE (B2, B1)-(RzX, RzY), (rew2)
LINE (B2, B1)-(LzX, LzY), (rew)
LOCATE 23, 20
PRINT CTR
LOCATE 22, 20
PRINT TOM
RETURN
':::::::::::::::::::::::::::::::::::
CHECK:
        IF DIR$ = "IN" THEN
                RzX = RzX - 1
                LzX = LzX + 1
                CTR = CTR + 1
                
        ELSE
                IF DIR$ = "OUT" THEN
                        RzX = RzX + 1
                        LzX = LzX - 1
                        CTR = CTR - 1
                        
                END IF
        END IF
'<<<<<<<<<<<<<
IF CTR > 99 THEN
        DIR$ = "OUT"
ELSE
        IF CTR < 2 THEN
                DIR$ = "IN"
        END IF
END IF
'<<<<<<<<<<<<<
IF CTR > 99 OR CTR < 2 THEN
IF TOM = 1 THEN
        rew = 4
        rew2 = 4
        TOM = 4
ELSE
        IF TOM = 2 THEN
                rew = 1
                rew2 = 5
                TOM = 1
        ELSE
                IF TOM = 3 THEN
                        rew = 4
                        rew2 = 2
                        TOM = 2
                ELSE
                        rew = 3
                        rew2 = 4
                        TOM = 3
                END IF
        END IF
END IF
END IF
'\\\\\ \\\\\\\\\\\\\\\\\\\\\\\\\\\
RETURN
':::::::::::::::::::::::::::::::::::
PAUSEE:
        'PAINT (100, 99), 4
        FOR XX = 1 TO 1000: NEXT XX
        CLS
RETURN
':::::::::::::::::::::::::::::::::::


