DECLARE SUB PAUSEE ()
10
'                       MAIN
GOSUB INIT
DO UNTIL PAGE = 2
GOSUB ANIMATE1
GOSUB MOVE
LOOP
GOTO 32767
'
ANIMATE1:
IF FRAME = 1 THEN
                CLS
                LOCATE (DOWN), (OVER)
                PRINT "<"
                'LOCATE (DOWN + 1), (OVER)
                'PRINT "<"
                PAUSEE
                FRAME = 2
        ELSE
                CLS
                LOCATE (DOWN), (OVER)
                PRINT "-"
                PAUSEE
                FRAME = 1
        END IF
RETURN
'
MOVE:
        IF OVER = 15 THEN
                OVER = 1
                DOWN = DOWN + 1
        ELSE
                OVER = OVER + 1
        END IF
        '
        IF DOWN = 10 THEN
                DOWN = 1
                PAGE = PAGE + 1
        END IF
RETURN
'
INIT:
        CLS
        SCREEN 2
        'COLOR 14, 1
        X = 0
        DOWN = 1
        OVER = 1
        FRAME = 1
        PAGE = 1
RETURN
'
'
32767
END

SUB PAUSEE
: FOR X = 1 TO 1000: NEXT X
END SUB

