CLS
STOP$ = "AndreSBuczko"
H = 0
X = 0
F = 4
Y = 4
10
        H = H + 1
        X = X + 1
        
        IF F < 14 THEN
        F = F + 1               'Dungen Studeos 1997
        ELSE
        F = 5
        Y = 30
        END IF

        IF H = 21 THEN
        STOP$ = "YES"
        ELSE
        COLOR (H)
        LOCATE (F), (Y)
        PRINT ; X; , CHR$(219)
        GOTO 10
        END IF

        IF STOP$ = "YES" THEN
        GOTO 4000
        END IF
4000
COLOR 14
END

