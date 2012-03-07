CLS
SCREEN 12
'set pon's
DIM SHARED CTR AS SINGLE
DIM SHARED PONX(1 TO 2000), PONY(1 TO 2000)

Z = 1                   '28 = 1/4
X = 20                  '128 = full rotation
Y = 20                 'pon's wil be 1 to 128
CHANGE = .05
'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        FOR CTR = 1 TO 126
                NEWzX = X * COS(CHANGE) - Y * SIN(CHANGE)
                NEWzY = Y * COS(CHANGE) + X * SIN(CHANGE)
                Y = NEWzY
                X = NEWzX
        PONX(CTR) = X
        PONY(CTR) = Y
        LOCATE 20, 25: PRINT CTR
        LINE (Z + 100, Z + 100)-(Y + 100, X + 100)
        NEXT CTR
'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
CLS
X = 30                                          'RING 2
Y = 30
CHANGE = .05
'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        FOR CTR = 129 TO 253
                NEWzX = X * COS(CHANGE) - Y * SIN(CHANGE)
                NEWzY = Y * COS(CHANGE) + X * SIN(CHANGE)
                Y = NEWzY
                X = NEWzX
        PONX(CTR) = X
        PONY(CTR) = Y
        LOCATE 20, 25: PRINT CTR
        LINE (Z + 100, Z + 100)-(Y + 100, X + 100)
        FOR XXX = 1 TO 40: NEXT XXX
        NEXT CTR
'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
CLS
X = 60                                  'RING 3
Y = 60
CHANGE = .05
        FOR CTR = 257 TO 382
                NEWzX = X * COS(CHANGE) - Y * SIN(CHANGE)
                NEWzY = Y * COS(CHANGE) + X * SIN(CHANGE)
                Y = NEWzY
                X = NEWzX
        PONX(CTR) = X
        PONY(CTR) = Y
        LOCATE 20, 25: PRINT CTR
        LINE (Z + 100, Z + 100)-(Y + 100, X + 100)
        FOR XXX = 1 TO 40: NEXT XXX
        NEXT CTR
'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
CLS
X = 70                                  'RING 4
Y = 70
CHANGE = .05
        FOR CTR = 383 TO 508
                NEWzX = X * COS(CHANGE) - Y * SIN(CHANGE)
                NEWzY = Y * COS(CHANGE) + X * SIN(CHANGE)
                Y = NEWzY
                X = NEWzX
        PONX(CTR) = X
        PONY(CTR) = Y
        LOCATE 20, 25: PRINT CTR
        LINE (Z + 100, Z + 100)-(Y + 100, X + 100)
        FOR XXX = 1 TO 40: NEXT XXX
        NEXT CTR
'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
'JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
'LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
HOME:
CTR = 0
LOCATE 2, 2: PRINT "|1=PIXLE'S ON |2=PIXLE ON |3=CLS |4=END |5=ARMS ON |6=CIRCLES ON |7=PIXLE OFF |"
LOCATE 3, 3: PRINT "|8=LIST ALL VALS |10=DUMP"
LOCATE 1, 1: INPUT "ENTER OPTION"; HUMMM$
SELECT CASE HUMMM$
        CASE IS = "1"
                INPUT "CTR START"; CTRS
                INPUT "CTR STOP"; CTRP
                FOR CTR = CTRS TO CTRP
                PSET ((PONX(CTR) + 250), (PONY(CTR) + 250))
                NEXT CTR
        CASE IS = "2"
                INPUT "PIXLE'S NUMBER (1 TO 508)"; CTR
                PSET ((PONX(CTR) + 250), (PONY(CTR) + 250))
        CASE IS = "3"
                CLS
        CASE IS = "4"
                GOTO 37000
        CASE IS = "5"
                GOSUB STRAITS
        CASE IS = "6"
                GOSUB LINNES1
        CASE IS = "7"
                INPUT "PIXLE TO TURN OFF"; CTR
                PSET ((PONX(CTR) + 250), (PONY(CTR) + 250)), 1
        CASE IS = "8"
                GOSUB PPRRIINNT
        CASE IS = "9"
                GOSUB CIRT1
        CASE IS = "10"
                GOSUB dump
END SELECT
GOTO HOME
37000
END

STRAITS:
LINE ((PONX(142) + 250), (PONY(142) + 250))-((PONX(270) + 250), (PONY(270) + 250)), 4
LINE ((PONX(144) + 250), (PONY(144) + 250))-((PONX(398) + 250), (PONY(398) + 250)), 4
LINE ((PONX(274) + 250), (PONY(274) + 250))-((PONX(400) + 250), (PONY(400) + 250)), 4

LINE ((PONX(173) + 250), (PONY(173) + 250))-((PONX(302) + 250), (PONY(302) + 250)), 4
LINE ((PONX(175) + 250), (PONY(175) + 250))-((PONX(430) + 250), (PONY(430) + 250)), 4
LINE ((PONX(306) + 250), (PONY(306) + 250))-((PONX(432) + 250), (PONY(432) + 250)), 4

LINE ((PONX(205) + 250), (PONY(206) + 250))-((PONX(334) + 250), (PONY(334) + 250)), 4
LINE ((PONX(208) + 250), (PONY(208) + 250))-((PONX(461) + 250), (PONY(461) + 250)), 4
LINE ((PONX(337) + 250), (PONY(337) + 250))-((PONX(463) + 250), (PONY(463) + 250)), 4

LINE ((PONX(237) + 250), (PONY(237) + 250))-((PONX(365) + 250), (PONY(365) + 250)), 4
LINE ((PONX(239) + 250), (PONY(239) + 250))-((PONX(493) + 250), (PONY(493) + 250)), 4
LINE ((PONX(369) + 250), (PONY(369) + 250))-((PONX(495) + 250), (PONY(495) + 250)), 4
RETURN

LINNES1:
FOR CTR = 2 TO 126
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 128 TO 142
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 144 TO 173
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 175 TO 205
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 208 TO 237
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 239 TO 253
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 255 TO 270
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 272 TO 302
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 306 TO 334
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 337 TO 365
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 369 TO 383
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 383 TO 398
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 400 TO 430
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 432 TO 461
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 463 TO 493
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
FOR CTR = 495 TO 508
        LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250)), 5
NEXT CTR
RETURN

PPRRIINNT:
 INPUT "PRESS ENTER TO CONTINUE"; ENTER$
  CLS
   FOR CTR = 1 TO 508
    PRINT PONY(CTR), PONX(CTR)
   NEXT CTR
RETURN

CIRT1:
FOR CTR = 1 TO 126
LINE ((PONX(CTR) + 250), (PONY(CTR) + 250))-((PONX(CTR + 1) + 250), (PONY(CTR + 1) + 250))
NEXT CTR
RETURN

dump:
LOCATE 24, 15: PRINT "(1) C:\LOGO.DAT (2)A:\LOGO.DAT"
LOCATE 25, 5: INPUT "WERE DO YOU WANT THE DATA FILE"; FILENAME$
IF FILENAME$ = "1" THEN
        FILENAME$ = "C:\LOGO.DAT"
ELSE
        IF FILENAME$ = "2" THEN
                FILENAME$ = "A:\LOGO.DAT"
        END IF
END IF
GOSUB STRAITS
OPEN FILENAME$ FOR OUTPUT AS #1
FOR ME = 1 TO 508
BOBB:
PSET ((PONX(ME) + 250), (PONY(ME)) + 250), 5
LOCATE 24, 10: INPUT "WRITE THIS PIXLE (Y-N)"; ANSREW$
IF ANSREW$ = "Y" OR ANSREW$ = "y" THEN
        WRITE #1, (PONX(ME) + 250), (PONY(ME) + 250), 4
ELSE
 IF ANSREW$ = "N" OR ANSREW$ = "n" THEN
        PRESET ((PONX(ME) + 250), (PONY(ME) + 250))
        WRITE #1, 0, 0, 0
 ELSE
        GOTO BOBB:
 END IF
END IF
NEXT ME
CLOSE #1
RETURN

