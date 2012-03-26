' Dungeon Studios Prototyping
' http://www.dsprototyping.com
'copyright 2011
'
'Qustions? coments? Email Andy Buczko at A4S8B7@dsprototyping.com
''


DECLARE SUB walls (objx!, objy!)
DECLARE SUB walls (objx!, objy!)
DECLARE SUB STARTUP ()
DECLARE SUB ENDGAME ()
DECLARE SUB boostarrow2 (objx!, objy!, speed!, boostcount2!)
DECLARE SUB boostarrow1 (objx!, objy!, speed!, boostcount1!)
DECLARE SUB getinput ()
DECLARE SUB calculate ()
DECLARE SUB drawscreen ()
DIM SHARED wall.xs(1 TO 10)  AS SINGLE
DIM SHARED wall.xe(1 TO 10)  AS SINGLE
DIM SHARED wall.ys(1 TO 10)  AS SINGLE
DIM SHARED wall.ye(1 TO 10)  AS SINGLE
DIM SHARED p.x AS SINGLE
DIM SHARED p.y AS SINGLE
DIM SHARED p.z AS SINGLE
DIM SHARED p.s AS SINGLE
DIM SHARED p.ctr AS SINGLE
DIM SHARED c.x AS SINGLE
DIM SHARED c.y AS SINGLE
DIM SHARED c.z AS SINGLE
DIM SHARED c.s AS SINGLE
DIM SHARED c.ctr AS SINGLE
DIM SHARED DIRECTION AS SINGLE
DIM SHARED speed AS SINGLE
DIM SHARED endflag AS STRING
DIM SHARED pauseflag AS STRING
DIM SHARED colisionflag AS STRING
DIM SHARED boostflag1 AS STRING
DIM SHARED boostflag2 AS STRING
DIM SHARED playflag AS STRING
DIM SHARED wallflag AS STRING
DIM SHARED waitflag AS SINGLE
DIM SHARED boostcount1 AS SINGLE
DIM SHARED boostcount2 AS SINGLE
startupp:
RANDOMIZE TIMER
CLS
SCREEN 12       '640 x 480
STARTUP
main:
 DO WHILE endflag$ = "no"
        getinput
        calculate
        walls p.x, p.y
        boostarrow1 p.x, p.y, p.s, p.ctr
        boostarrow2 c.x, c.y, c.s, c.ctr
        drawscreen
        FOR x = 1 TO 100: NEXT x
 LOOP
ENDGAME
IF playflag$ = "andrew" THEN : GOTO startupp
END

SUB boostarrow1 (objx, objy, speed, boostcount1)
'this is the boost arrows on the screen and determines there were a bouts
IF objx < 150 AND objx > 100 THEN
 IF objy < 150 AND objy > 100 THEN
  boostflag1$ = "yes"
 END IF
END IF
IF boostflag1$ = "yes" THEN
 SELECT CASE boostcount1
    CASE IS < 50
        p.s = p.s + 1
        boostcount1 = boostcount1 + 1
    CASE IS < 100
        boostcount1 = boostcount1 + 1
    CASE IS < 150
        p.s = p.s - 1
        boostcount1 = boostcount1 + 1
    CASE IS < 155
        boostcount1 = 1
        boostflag1$ = "no"
        p.s = 1
 END SELECT
END IF
END SUB

SUB boostarrow2 (objx, objy, c.s, boostcount2)
IF objx < 150 AND objx > 100 THEN
 IF objy < 150 AND objy > 100 THEN
  boostflag2$ = "yes"
 END IF
END IF
IF boostflag2$ = "yes" THEN
 SELECT CASE boostcount2
    CASE IS < 50
        c.s = c.s + 1
        boostcount2 = boostcount2 + 1
    CASE IS < 100
        boostcount2 = boostcount2 + 1
    CASE IS < 150
        c.s = c.s - 1
        boostcount2 = boostcount2 + 1
    CASE IS < 155
        boostcount2 = 1
        boostflag2$ = "no"
        c.s = 1
 END SELECT
END IF
END SUB

SUB calculate
IF c.x > p.x THEN : c.x = c.x - c.s
IF c.x < p.x THEN : c.x = c.x + c.s
IF c.y > p.y THEN : c.y = c.y - c.s
IF c.y < p.y THEN : c.y = c.y + c.s
IF c.z > p.z THEN : c.z = c.z - c.s
IF c.z < p.z THEN : c.z = c.z + c.s
'************test***************'
 IF c.x < (p.x + p.z) AND c.x > (p.x - p.z) THEN
  IF c.y < (p.y + p.z) AND c.y > (p.y - p.z) THEN
    colisionflag$ = "yes"
    endflag$ = "yes"
  END IF
 END IF
IF p.s > 60 THEN
p.s = 59
END IF

END SUB

SUB drawscreen
CIRCLE (p.x, p.y), p.z, 2
CIRCLE (c.x, c.y), c.z, 4
PSET (p.x, p.y), 2
PSET (c.x, c.y), 4
LOCATE 1, 1: PRINT "player's speed |"; p.s
LOCATE 2, 1: PRINT "| computer's x/y |"; c.s; " "; DIRECTION
LINE (100, 100)-(150, 150), 6, BF

'LINE (308, 50)-(310, 100), 4, BF   'test wall
FOR ctr = 1 TO 4
LINE (wall.xs(ctr), wall.ys(ctr))-(wall.xe(ctr), wall.ye(ctr)), 4, BF
NEXT ctr
END SUB

SUB ENDGAME
IF colisionflag$ = "yes" THEN
        CLS
        LINE (100, 170)-(500, 240), 4, BF
        LOCATE 12, 15: PRINT "YOU GOT CAUGHT!"
        CIRCLE (320, 350), 100, 2
        CIRCLE (270, 300), 10, 2
        CIRCLE (360, 300), 10, 2
        CIRCLE (320, 500), 100, 2, 1, 2.2       'phrone
END IF
LOCATE 14, 15: INPUT "Do you wish to play again (Y or N)"; playflag$
IF playflag$ = "y" OR playflag$ = "Y" THEN
        playflag$ = "andrew"
ELSE
 IF playflag$ = "n" OR playflag$ = "N" THEN
        CLS
        LOCATE 14, 15: PRINT "thank you for playing"
        CIRCLE (320, 350), 100, 1
        CIRCLE (270, 300), 10, 1
        CIRCLE (360, 300), 10, 1
        CIRCLE (320, 320), 100, 1, 4, 5.45      'smile
 END IF
END IF
END SUB

SUB getinput
'Get keyboard input & Change direction accordingly
  kbd$ = INKEY$
   SELECT CASE kbd$
     CASE CHR$(0) + "H": p.s = p.s + 1
     CASE CHR$(0) + "P": p.s = p.s - 1
     CASE CHR$(0) + "K": DIRECTION = DIRECTION + 1
     CASE CHR$(0) + "M": DIRECTION = DIRECTION - 1
     CASE "p", "P": pauseflag$ = "Paused, push Space Bar "
     CASE "q", "Q": endflag$ = "yes"
     CASE ELSE
   END SELECT
        'THIS WILL ADJUST THE STREING RADIUOSE
IF DIRECTION > 8 THEN : DIRECTION = 1
IF DIRECTION < 1 THEN : DIRECTION = 8
   SELECT CASE DIRECTION
        CASE IS = 1: p.x = p.x - p.s: p.y = p.y + p.s
        CASE IS = 2: p.y = p.y + p.s
        CASE IS = 3: p.x = p.x + p.s: p.y = p.y + p.s
        CASE IS = 4: p.x = p.x + p.s
        CASE IS = 5: p.x = p.x + p.s: p.y = p.y - p.s
        CASE IS = 6: p.y = p.y - p.s
        CASE IS = 7: p.y = p.y - p.s: p.x = p.x - p.s
        CASE IS = 8: p.x = p.x - p.s
   END SELECT
IF p.x > 640 THEN : p.x = 1
IF p.x < 1 THEN : p.x = 640
IF p.y > 480 THEN : p.y = 1
IF p.y < 1 THEN : p.y = 480
IF c.x > 640 THEN : c.x = 1
IF c.x < 1 THEN : c.x = 640
IF c.y > 480 THEN : c.y = 1
IF c.y < 1 THEN : c.y = 480
END SUB

SUB STARTUP
boostcount = 1
speed = 1
p.s = INT(RND * 5) + 1
c.s = INT(RND * 5) + 1
DIRECTION = INT(RND * 8) + 1
p.x = INT(RND * 480) + 1                'c is the enemy, p is the user
p.y = INT(RND * 640) + 1
p.z = INT(RND * 10) + 1
c.x = INT(RND * 480) + 1
c.y = INT(RND * 640) + 1
c.z = INT(RND * 10) + 1
endflag$ = "no"
pauseflag$ = "no"
playflag$ = "andrew"
boostflag$ = "no"
colisionflag$ = "no"
wallflag$ = "no"
waitflag = 0
'
wall.xs(1) = 305
wall.xe(1) = 310
wall.ys(1) = 50
wall.ye(1) = 100

wall.xs(2) = 305
wall.xe(2) = 310
wall.ys(2) = 105
wall.ye(2) = 150

wall.xs(3) = 350
wall.xe(3) = 355
wall.ys(3) = 200
wall.ye(3) = 250

wall.xs(4) = 5
wall.xe(4) = 10
wall.ys(4) = 30
wall.ye(4) = 160

END SUB

SUB walls (objx!, objy!)
'640 x 480
' wall at 310-50 \ 310-100

'wall.xs(ctr)   /STARTING WALL VERTICIY
'wall.ys(ctr)

'wall,xe(ctr)   /ENDING WALL VERTICY
'wall.ye(ctr)

FOR ctr = 1 TO 4 'wallmax
 IF objx < wall.xe(ctr) AND objx > wall.xs(ctr) THEN
  IF objy < wall.ye(ctr) AND objy > wall.ys(ctr) THEN
   'wallflag$ = "yes"
   'waitflag = 0                            'the "s" start, is always the lesser number
   SELECT CASE DIRECTION
    CASE IS = 1: DIRECTION = 3
    CASE IS = 2: DIRECTION = 6
    CASE IS = 3: DIRECTION = 1
    CASE IS = 4: DIRECTION = 8
    CASE IS = 5: DIRECTION = 7
    CASE IS = 6: DIRECTION = 2
    CASE IS = 7: DIRECTION = 5
    CASE IS = 8: DIRECTION = 4
   END SELECT
  END IF                                   ' eg. s = 5 and e = 10. obj sould fall inbteen the values
 END IF                                    'for the ruteen to to something.
NEXT ctr
'IF waitflag > 10 THEN
'        wallflag$ = "no"
'ELSE
'        waitflag = waitflag + 1
'END IF
END SUB

