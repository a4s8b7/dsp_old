DECLARE SUB ROTATE (X!, Y!, scalefactor!, DIRECTION$)
DECLARE SUB STRETCH (A.X!, A.Y!, scalefactor!)
CLS
SCREEN 12
'set pon's
DIM SHARED CTR AS SINGLE
DIM SHARED A.X(1 TO 1000) AS SINGLE
DIM SHARED A.Y(1 TO 1000) AS SINGLE
DIM SHARED PONX(1 TO 2000), PONY(1 TO 2000)
DIM SHARED REW(1 TO 2000) AS SINGLE
'[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
OPEN "c:\logo\LOGO-ST.DAT" FOR INPUT AS #1
FOR CTR = 1 TO 508
INPUT #1, PONX(CTR), PONY(CTR), REW(CTR)
 IF PONX(CTR) = 0 THEN
  GOTO skip
 ELSE
   PONX(CTR) = PONX(CTR) - 250
   PONY(CTR) = PONY(CTR) - 250
 END IF
skip:
NEXT CTR
CLOSE #1
XMOV = 250
YMOV = 250
scalefactor = .1
CHANGE = .2
PROCCESS = 2
DIRECTION$ = "LEFT"
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
ANDREW:

'Get keyboard input & Change direction accordingly
  kbd$ = INKEY$
   SELECT CASE kbd$
     CASE IS = "+", "=": CHANGE = CHANGE + .1
     CASE IS = "-", "_": CHANGE = CHANGE - .1
     CASE CHR$(0) + "H": scalefactor = scalefactor + .1: PROCCESS = 1             'ROTATE ARROUND Z ACCES
     CASE CHR$(0) + "P": scalefactor = scalefactor - .1: PROCCESS = 1
     CASE CHR$(0) + "K": DIRECTION$ = "LEFT": PROCCESS = 2     'ROTATE ARROUND X ACCES
     CASE CHR$(0) + "M": DIRECTION$ = "RIGHT": PROCCESS = 2
     CASE "p", "P": gamepause$ = "Paused, push Space Bar "
     CASE ELSE
   END SELECT

GOSUB STRAITS                   'this rotine draws the image
ENDFLAG$ = "NO"
SET = 1
OFFSET = 2
DO WHILE ENDFLAG$ = "NO"
  IF PONX(SET) = 0 OR PONX(OFFSET) = 0 THEN
    SET = SET + 1
    OFFSET = OFFSET + 1
  ELSE
    LINE ((PONX(SET) + XMOV), (PONY(SET) + YMOV))-((PONX(OFFSET) + XMOV), (PONY(OFFSET) + YMOV)), 4
     SET = SET + 1
     OFFSET = OFFSET + 1
  END IF
 IF OFFSET > 508 THEN : ENDFLAG$ = "ANDREW"
LOOP

IF PROCCESS = 1 THEN
        FOR CTR = 1 TO 508                    'THIS LOOP MAKES CHANGES TO THE SHAPE
                STRETCH PONX(CTR), PONY(CTR), scalefactor
        NEXT CTR
ELSE
        FOR CTR = 1 TO 508
                ROTATE PONX(CTR), PONY(CTR), scalefactor, DIRECTION$
        NEXT CTR
END IF
CLS
GOTO ANDREW
END
'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
STRAITS:
LINE ((PONX(142) + XMOV), (PONY(142) + YMOV))-((PONX(270) + XMOV), (PONY(270) + YMOV)), 4
LINE ((PONX(144) + XMOV), (PONY(144) + YMOV))-((PONX(398) + XMOV), (PONY(398) + YMOV)), 4
LINE ((PONX(274) + XMOV), (PONY(274) + YMOV))-((PONX(400) + XMOV), (PONY(400) + YMOV)), 4

LINE ((PONX(173) + XMOV), (PONY(173) + YMOV))-((PONX(302) + XMOV), (PONY(302) + YMOV)), 4
LINE ((PONX(175) + XMOV), (PONY(175) + YMOV))-((PONX(430) + XMOV), (PONY(430) + YMOV)), 4
LINE ((PONX(306) + XMOV), (PONY(306) + YMOV))-((PONX(432) + XMOV), (PONY(432) + YMOV)), 4

LINE ((PONX(205) + XMOV), (PONY(205) + YMOV))-((PONX(334) + XMOV), (PONY(334) + YMOV)), 4
LINE ((PONX(208) + XMOV), (PONY(208) + YMOV))-((PONX(461) + XMOV), (PONY(461) + YMOV)), 4
LINE ((PONX(337) + XMOV), (PONY(337) + YMOV))-((PONX(463) + XMOV), (PONY(463) + YMOV)), 4

LINE ((PONX(237) + XMOV), (PONY(237) + YMOV))-((PONX(365) + XMOV), (PONY(365) + YMOV)), 4
LINE ((PONX(239) + XMOV), (PONY(239) + YMOV))-((PONX(493) + XMOV), (PONY(493) + YMOV)), 4
LINE ((PONX(369) + XMOV), (PONY(369) + YMOV))-((PONX(495) + XMOV), (PONY(495) + YMOV)), 4
RETURN

SUB ROTATE (X, Y, CHANGE, DIRECTION$)
Z = 1
'CHANGE = .05
                IF DIRECTION$ = "LEFT" THEN
                NEWzX = X * COS(CHANGE) - Y * SIN(CHANGE)
                NEWzY = Y * COS(CHANGE) + X * SIN(CHANGE)
                ELSE
                IF DIRECTION$ = "RIGHT" THEN
                NEWzX = X * COS(CHANGE) + Y * SIN(CHANGE)
                NEWzY = Y * COS(CHANGE) - X * SIN(CHANGE)
                END IF
                END IF
                Y = NEWzY
                X = NEWzX
END SUB

SUB STRETCH (A.X, A.Y, scalefactor)
A.X = A.X * scalefactor
A.Y = A.Y * scalefactor
END SUB

