CLS
SCREEN 13
x1 = 1
x2 = 1
y1 = 1
y2 = 460
rew = 1

10
FOR x = 1 TO 150
LINE (x1, y1)-(x2, y2), (rew)
        x1 = x1 + 2
        x2 = x2 + 2
        rew = rew + 1
LOCATE 15, 15
PRINT rew
NEXT x
CLS
x1 = 1
x2 = 1
GOTO 10

