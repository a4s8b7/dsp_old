CLS
SCREEN 12
gamepause$ = "NO"
DIRECTION = 1
SPEED = 20
DIRX = 100
DIRY = 100
DO WHILE gamepause$ = "NO"
'Get keyboard input & Change direction accordingly
  kbd$ = INKEY$
   SELECT CASE kbd$
     'CASE "w", "W": speed = speed - 30: car.y = car.y - 1
     'CASE "s", "S": speed = speed - 30: car.y = car.y + 1
     'CASE "a", "A": speed = speed - 30: car.x = car.x - 1
     'CASE "d", "D": speed = speed - 30: car.x = car.x + 1
     CASE CHR$(0) + "H": SPEED = SPEED + 1
     CASE CHR$(0) + "P": SPEED = SPEED - 1
     CASE CHR$(0) + "K": DIRECTION = DIRECTION + 1
     CASE CHR$(0) + "M": DIRECTION = DIRECTION - 1
     CASE "p", "P": gamepause$ = "Paused, push Space Bar "
     CASE ELSE
   END SELECT
        'THIS WILL ADJUST THE STREING RADIUOSE
IF DIRECTION > 8 THEN : DIRECTION = 8
IF DIRECTION < 1 THEN : DIRECTION = 1
   SELECT CASE DIRECTION
        CASE IS = 1: DIRX = DIRX - 1: DIRY = DIRY + 1
        CASE IS = 2: DIRY = DIRY + 1
        CASE IS = 3: DIRX = DIRX + 1: DIRY = DIRY + 1
        CASE IS = 4: DIRX = DIRX + 1
        CASE IS = 5: DIRX = DIRX + 1: DIRY = DIRY - 1
        CASE IS = 6: DIRY = DIRY - 1
        CASE IS = 7: DIRY = DIRY - 1: DIRX = DIRX - 1
        CASE IS = 8: DIRX = DIRX - 1
   END SELECT
IF DIRX > 640 THEN : DIRX = 1
IF DIRX < 1 THEN : DIRX = 640
IF DIRY > 480 THEN : DIRY = 1
IF DIRY < 1 THEN : DIRY = 480
PSET (DIRX, DIRY), 4
LOCATE 20, 5: PRINT "DIRECTION", "SPEED", "DIR-X", "DIR-Y"
PRINT DIRECTION, SPEED, DIRX, DIRY
FOR X = 1 TO 30: NEXT X
LOOP

