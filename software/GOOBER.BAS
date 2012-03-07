RANDOMIZE TIMER
CLS
GOSUB HELLO
CLS
LOCATE 13, 15
        PLAY "MBT160O1L8CDEDCDL4ECC"
PRINT "лллллллллллллллллллллллл"
SLEEP 3
CLS
        GOSUB HELLO
        CLS
        LOCATE 13, 15
        PRINT "ON DRUGS"
        SLEEP 2
        PLAY "MBT160O1L8CDFDCFL4EBC"
CLS
SCREEN 2
FOR Xx = 1 TO 1000
        DIR = INT(RND * 4) + 1
        GOSUB DECID
        GOSUB CHECK
        PSET (X, Y), 2
NEXT Xx
CLS
LOCATE 12, 14
PRINT "ANY QUSTIONS?"
SLEEP 3
GOTO 32767

DECID:
IF DIR = 1 THEN
        X = X + 1
ELSE
        IF DIR = 2 THEN
                X = X - 1
        END IF
END IF

IF DIR = 3 THEN
        Y = Y + 1
ELSE
        Y = Y - 1
END IF
RETURN

CHECK:
        IF Y > 200 THEN
                Y = 100
        ELSE
                IF Y < 100 THEN
                        Y = 200
                END IF
        END IF
        IF X > 200 THEN
                X = 100
        ELSE
                IF X < 100 THEN
                        X = 200
                END IF
        END IF
RETURN
HELLO:
CLS
LOCATE 12, 20
PRINT "THIS"
LOCATE 13, 22
PRINT "IS"
LOCATE 14, 24
PRINT "SAMMY"
SLEEP 3
RETURN
32767
END

