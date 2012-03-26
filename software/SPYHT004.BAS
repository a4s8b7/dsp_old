'
' Dungeon Studios Prototyping
' http://www.dsprototyping.com
'copyright 2011
'
'Qustions? coments? Email Andy Buczko at A4S8B7@dsprototyping.com
''

DECLARE SUB car (car.x!, car.y!, oldcar.x!, oldcar.y!, DIRECTION!, COL!)
DECLARE SUB walls (objx!, objy!, DIRECTION!)
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
DIM SHARED pold.x AS SINGLE
DIM SHARED pold.y AS SINGLE
DIM SHARED cold.x AS SINGLE
DIM SHARED cold.y AS SINGLE
DIM SHARED c.ctr AS SINGLE
DIM SHARED DIRECTION AS SINGLE
DIM SHARED cDIRECTION AS SINGLE
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
        walls p.x, p.y, DIRECTION
        walls c.x, p.y, cDIRECTION
        boostarrow1 p.x, p.y, p.s, p.ctr
        boostarrow2 c.x, c.y, c.s, c.ctr
        drawscreen
        FOR x = 1 TO 1000: NEXT x
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
    CASE IS < 10
        p.s = p.s + 1
        boostcount1 = boostcount1 + 1
    CASE IS < 60
        boostcount1 = boostcount1 + 1
    CASE IS < 110
        p.s = p.s - 1
        boostcount1 = boostcount1 + 1
    CASE IS < 120
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
    CASE IS < 10
        c.s = c.s + 1
        boostcount2 = boostcount2 + 1
    CASE IS < 60
        boostcount2 = boostcount2 + 1
    CASE IS < 110
        c.s = c.s - 1
        boostcount2 = boostcount2 + 1
    CASE IS < 120
        boostcount2 = 1
        boostflag2$ = "no"
        c.s = 1
 END SELECT
END IF
END SUB

SUB calculate
xsign = 20
ysign = 20
cold.x = c.x
cold.y = c.y
IF c.x > p.x THEN : c.x = c.x - c.s: xsign = 1' "neg"
IF c.x < p.x THEN : c.x = c.x + c.s: xsign = 2' "pos"
IF c.x = p.x THEN : xsign = 20 '"nul"
IF c.y > p.y THEN : c.y = c.y - c.s: ysign = 1' "neg"
IF c.y < p.y THEN : c.y = c.y + c.s: ysign = 2' "pos"
IF c.y = p.y THEN : ysign = 20 '"nul"


SELECT CASE xsign '(xsign AND ysign)
        CASE IS = 20
                IF ysign = 1 THEN
                        cDIRECTION = 6  '20 and 1, nul and neg
                ELSEIF ysign = 2 THEN
                        cDIRECTION = 2  '20 and 2, nul and neg
                END IF
        CASE IS = 2
                IF ysign = 1 THEN
                        cDIRECTION = 5  '2 and 1, pos and neg
                ELSEIF ysign = 20 THEN
                        cDIRECTION = 4  '2 and 20, pos and nul
                ELSEIF ysign = 2 THEN
                        cDIRECTION = 3  '2 and 2, pos and pos
                END IF
       
        CASE IS = 1
                IF ysign = 2 THEN
                        cDIRECTION = 1  '1 and 1, neg and neg
                ELSEIF ysign = 20 THEN
                        cDIRECTION = 8  '1 and 20, neg and nul
                ELSEIF ysign = 1 THEN
                        cDIRECTION = 7  '1 and 1, neg and neg
                END IF
        CASE ELSE
                'error

END SELECT
LOCATE 27, 30: PRINT " X="; xsign; " Y="; ysign

'************test***************'
 IF c.x < (p.x + p.z) AND c.x > (p.x - p.z) THEN
  IF c.y < (p.y + p.z) AND c.y > (p.y - p.z) THEN
    'colisionflag$ = "yes"
    'endflag$ = "yes"
  END IF
 END IF
IF p.s > 60 THEN
p.s = 59
END IF

END SUB

SUB car (OBJ.X, OBJ.Y, oldcar.x, oldcar.y, DIRECTION, COL)
'car
'COL = 1
SELECT CASE DIRECTION
        CASE IS = 6
        '**** 000 deg up
        'errase old car
        LINE ((6 + oldcar.x), (10 + oldcar.y))-((-6 + oldcar.x), (10 + oldcar.y)), 2
        LINE ((-7 + oldcar.x), (9 + oldcar.y))-((-7 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((-6 + oldcar.x), (3 + oldcar.y))-((-6 + oldcar.x), (-3 + oldcar.y)), 2
        LINE ((-7 + oldcar.x), (-5 + oldcar.y))-((-7 + oldcar.x), (-12 + oldcar.y)), 2
        PSET ((-6 + oldcar.x), (-13 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (-13 + oldcar.y))-((-3 + oldcar.x), (-8 + oldcar.y)), 2
        LINE ((-3 + oldcar.x), (-13 + oldcar.y))-((3 + oldcar.x), (-13 + oldcar.y)), 2
        LINE ((5 + oldcar.x), (-13 + oldcar.y))-((3 + oldcar.x), (-8 + oldcar.y)), 2
        PSET ((6 + oldcar.x), (-13 + oldcar.y)), 2
        LINE ((7 + oldcar.x), (-12 + oldcar.y))-((7 + oldcar.x), (-5 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (-4 + oldcar.y))-((6 + oldcar.x), (3 + oldcar.y)), 2
        LINE ((7 + oldcar.x), (4 + oldcar.y))-((7 + oldcar.x), (9 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (10 + oldcar.y))-((-6 + oldcar.x), (10 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (5 + oldcar.y))-((4 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (4 + oldcar.y))-((5 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (-4 + oldcar.y))-((5 + oldcar.x), (-4 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (-5 + oldcar.y))-((5 + oldcar.x), (-5 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (-6 + oldcar.y))-((4 + oldcar.x), (-6 + oldcar.y)), 2
       
        'new car
        LINE ((6 + OBJ.X), (10 + OBJ.Y))-((-6 + OBJ.X), (10 + OBJ.Y)), COL
        LINE ((-7 + OBJ.X), (9 + OBJ.Y))-((-7 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((-6 + OBJ.X), (3 + OBJ.Y))-((-6 + OBJ.X), (-3 + OBJ.Y)), COL
        LINE ((-7 + OBJ.X), (-5 + OBJ.Y))-((-7 + OBJ.X), (-12 + OBJ.Y)), COL
        PSET (-6, -13), COL
        LINE ((-5 + OBJ.X), (-13 + OBJ.Y))-((-3 + OBJ.X), (-8 + OBJ.Y)), COL
        LINE ((-3 + OBJ.X), (-13 + OBJ.Y))-((3 + OBJ.X), (-13 + OBJ.Y)), COL
        LINE ((5 + OBJ.X), (-13 + OBJ.Y))-((3 + OBJ.X), (-8 + OBJ.Y)), COL
        PSET (6, -13), COL
        LINE ((7 + OBJ.X), (-12 + OBJ.Y))-((7 + OBJ.X), (-5 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (-4 + OBJ.Y))-((6 + OBJ.X), (3 + OBJ.Y)), COL
        LINE ((7 + OBJ.X), (4 + OBJ.Y))-((7 + OBJ.X), (9 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (10 + OBJ.Y))-((-6 + OBJ.X), (10 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (5 + OBJ.Y))-((4 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (4 + OBJ.Y))-((5 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (-4 + OBJ.Y))-((5 + OBJ.X), (-4 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (-5 + OBJ.Y))-((5 + OBJ.X), (-5 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (-6 + OBJ.Y))-((4 + OBJ.X), (-6 + OBJ.Y)), COL

        CASE IS = 5
        '**** 045 deg right/up
        'errase old car
        LINE ((-4 + oldcar.x), (12 + oldcar.y))-((-12 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((-12 + oldcar.x), (3 + oldcar.y))-((-8 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((-6 + oldcar.x), (-2 + oldcar.y))-((-1 + oldcar.x), (-7 + oldcar.y)), 2
        LINE ((-1 + oldcar.x), (-8 + oldcar.y))-((4 + oldcar.x), (-13 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (-12 + oldcar.y))-((4 + oldcar.x), (-7 + oldcar.y)), 2  'hood
        LINE ((8 + oldcar.x), (-10 + oldcar.y))-((11 + oldcar.x), (-7 + oldcar.y)), 2
        LINE ((13 + oldcar.x), (-4 + oldcar.y))-((7 + oldcar.x), (2 + oldcar.y)), 2
        LINE ((7 + oldcar.x), (1 + oldcar.y))-((2 + oldcar.x), (7 + oldcar.y)), 2
        LINE ((2 + oldcar.x), (8 + oldcar.y))-((-2 + oldcar.x), (12 + oldcar.y)), 2
        LINE ((-6 + oldcar.x), (-1 + oldcar.y))-((2 + oldcar.x), (6 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (1 + oldcar.y))-((1 + oldcar.x), (6 + oldcar.y)), 2
        LINE ((-1 + oldcar.x), (-5 + oldcar.y))-((6 + oldcar.x), (2 + oldcar.y)), 2
        LINE ((-1 + oldcar.x), (-6 + oldcar.y))-((7 + oldcar.x), (2 + oldcar.y)), 2
        LINE ((0 + oldcar.x), (-6 + oldcar.y))-((6 + oldcar.x), (0 + oldcar.y)), 2
        LINE ((1 + oldcar.x), (-6 + oldcar.y))-((6 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((8 + oldcar.x), (-3 + oldcar.y))-((12 + oldcar.x), (-5 + oldcar.y)), 2
        'new car
        LINE ((-4 + OBJ.X), (12 + OBJ.Y))-((-12 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((-12 + OBJ.X), (3 + OBJ.Y))-((-8 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((-6 + OBJ.X), (-2 + OBJ.Y))-((-1 + OBJ.X), (-7 + OBJ.Y)), COL
        LINE ((-1 + OBJ.X), (-8 + OBJ.Y))-((4 + OBJ.X), (-13 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (-12 + OBJ.Y))-((4 + OBJ.X), (-7 + OBJ.Y)), COL  'hood
        LINE ((8 + OBJ.X), (-10 + OBJ.Y))-((11 + OBJ.X), (-7 + OBJ.Y)), COL
        LINE ((13 + OBJ.X), (-4 + OBJ.Y))-((7 + OBJ.X), (2 + OBJ.Y)), COL
        LINE ((7 + OBJ.X), (1 + OBJ.Y))-((2 + OBJ.X), (7 + OBJ.Y)), COL
        LINE ((2 + OBJ.X), (8 + OBJ.Y))-((-2 + OBJ.X), (12 + OBJ.Y)), COL
        LINE ((-6 + OBJ.X), (-1 + OBJ.Y))-((2 + OBJ.X), (6 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (1 + OBJ.Y))-((1 + OBJ.X), (6 + OBJ.Y)), COL
        LINE ((-1 + OBJ.X), (-5 + OBJ.Y))-((6 + OBJ.X), (2 + OBJ.Y)), COL
        LINE ((-1 + OBJ.X), (-6 + OBJ.Y))-((7 + OBJ.X), (2 + OBJ.Y)), COL
        LINE ((0 + OBJ.X), (-6 + OBJ.Y))-((6 + OBJ.X), (0 + OBJ.Y)), COL
        LINE ((1 + OBJ.X), (-6 + OBJ.Y))-((6 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((8 + OBJ.X), (-3 + OBJ.Y))-((12 + OBJ.X), (-5 + OBJ.Y)), COL

        CASE IS = 4
        '**** 090 deg right
        'errase old car
        LINE ((-9 + oldcar.x), (-7 + oldcar.y))-((-4 + oldcar.x), (-7 + oldcar.y)), 2
        LINE ((-3 + oldcar.x), (-6 + oldcar.y))-((4 + oldcar.x), (-6 + oldcar.y)), 2
        LINE ((5 + oldcar.x), (-7 + oldcar.y))-((12 + oldcar.x), (-7 + oldcar.y)), 2
        PSET (13, -6), 2
        LINE ((13 + oldcar.x), (-5 + oldcar.y))-((8 + oldcar.x), (-3 + oldcar.y)), 2
        LINE ((13 + oldcar.x), (-3 + oldcar.y))-((13 + oldcar.x), (3 + oldcar.y)), 2
        LINE ((13 + oldcar.x), (5 + oldcar.y))-((8 + oldcar.x), (3 + oldcar.y)), 2
        PSET (13, 6), 2
        LINE ((12 + oldcar.x), (7 + oldcar.y))-((5 + oldcar.x), (7 + oldcar.y)), 2
        LINE ((4 + oldcar.x), (6 + oldcar.y))-((-3 + oldcar.x), (6 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (7 + oldcar.y))-((-9 + oldcar.x), (7 + oldcar.y)), 2
        LINE ((-10 + oldcar.x), (6 + oldcar.y))-((-10 + oldcar.x), (-6 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (-4 + oldcar.y))-((-5 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (-5 + oldcar.y))-((-4 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((4 + oldcar.x), (-5 + oldcar.y))-((4 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((5 + oldcar.x), (-5 + oldcar.y))-((5 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (-4 + oldcar.y))-((6 + oldcar.x), (4 + oldcar.y)), 2
        'draw new car
        LINE ((-9 + OBJ.X), (-7 + OBJ.Y))-((-4 + OBJ.X), (-7 + OBJ.Y)), COL
        LINE ((-3 + OBJ.X), (-6 + OBJ.Y))-((4 + OBJ.X), (-6 + OBJ.Y)), COL
        LINE ((5 + OBJ.X), (-7 + OBJ.Y))-((12 + OBJ.X), (-7 + OBJ.Y)), COL
        PSET (13, -6), COL
        LINE ((13 + OBJ.X), (-5 + OBJ.Y))-((8 + OBJ.X), (-3 + OBJ.Y)), COL
        LINE ((13 + OBJ.X), (-3 + OBJ.Y))-((13 + OBJ.X), (3 + OBJ.Y)), COL
        LINE ((13 + OBJ.X), (5 + OBJ.Y))-((8 + OBJ.X), (3 + OBJ.Y)), COL
        PSET (13, 6), COL
        LINE ((12 + OBJ.X), (7 + OBJ.Y))-((5 + OBJ.X), (7 + OBJ.Y)), COL
        LINE ((4 + OBJ.X), (6 + OBJ.Y))-((-3 + OBJ.X), (6 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (7 + OBJ.Y))-((-9 + OBJ.X), (7 + OBJ.Y)), COL
        LINE ((-10 + OBJ.X), (6 + OBJ.Y))-((-10 + OBJ.X), (-6 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (-4 + OBJ.Y))-((-5 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (-5 + OBJ.Y))-((-4 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((4 + OBJ.X), (-5 + OBJ.Y))-((4 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((5 + OBJ.X), (-5 + OBJ.Y))-((5 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (-4 + OBJ.Y))-((6 + OBJ.X), (4 + OBJ.Y)), COL

        CASE IS = 3
        '**** 135 deg right down
        'Errase oldcar
        LINE ((-11 + oldcar.x), (-3 + oldcar.y))-((-3 + oldcar.x), (-11 + oldcar.y)), 2
        LINE ((-2 + oldcar.x), (-11 + oldcar.y))-((3 + oldcar.x), (-6 + oldcar.y)), 2
        LINE ((3 + oldcar.x), (-5 + oldcar.y))-((7 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((8 + oldcar.x), (-1 + oldcar.y))-((13 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((13 + oldcar.x), (6 + oldcar.y))-((9 + oldcar.x), (4 + oldcar.y)), 2   'hood
        LINE ((11 + oldcar.x), (8 + oldcar.y))-((8 + oldcar.x), (11 + oldcar.y)), 2 'grill
        LINE ((6 + oldcar.x), (13 + oldcar.y))-((4 + oldcar.x), (9 + oldcar.y)), 2   'hood
        LINE ((3 + oldcar.x), (13 + oldcar.y))-((-1 + oldcar.x), (9 + oldcar.y)), 2
        LINE ((-1 + oldcar.x), (8 + oldcar.y))-((-6 + oldcar.x), (3 + oldcar.y)), 2
        LINE ((-7 + oldcar.x), (3 + oldcar.y))-((-12 + oldcar.x), (-2 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (-1 + oldcar.y))-((-1 + oldcar.x), (-5 + oldcar.y)), 2   'rear window
        LINE ((-5 + oldcar.x), (1 + oldcar.y))-((1 + oldcar.x), (-5 + oldcar.y)), 2   'rear window
        LINE ((-1 + oldcar.x), (6 + oldcar.y))-((6 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((-1 + oldcar.x), (7 + oldcar.y))-((7 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((0 + oldcar.x), (7 + oldcar.y))-((7 + oldcar.x), (0 + oldcar.y)), 2
        LINE ((1 + oldcar.x), (7 + oldcar.y))-((7 + oldcar.x), (1 + oldcar.y)), 2
        'draw new car
        LINE ((-11 + OBJ.X), (-3 + OBJ.Y))-((-3 + OBJ.X), (-11 + OBJ.Y)), COL
        LINE ((-2 + OBJ.X), (-11 + OBJ.Y))-((3 + OBJ.X), (-6 + OBJ.Y)), COL
        LINE ((3 + OBJ.X), (-5 + OBJ.Y))-((7 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((8 + OBJ.X), (-1 + OBJ.Y))-((13 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((13 + OBJ.X), (6 + OBJ.Y))-((9 + OBJ.X), (4 + OBJ.Y)), COL   'hood
        LINE ((11 + OBJ.X), (8 + OBJ.Y))-((8 + OBJ.X), (11 + OBJ.Y)), COL 'grill
        LINE ((6 + OBJ.X), (13 + OBJ.Y))-((4 + OBJ.X), (9 + OBJ.Y)), COL   'hood
        LINE ((3 + OBJ.X), (13 + OBJ.Y))-((-1 + OBJ.X), (9 + OBJ.Y)), COL
        LINE ((-1 + OBJ.X), (8 + OBJ.Y))-((-6 + OBJ.X), (3 + OBJ.Y)), COL
        LINE ((-7 + OBJ.X), (3 + OBJ.Y))-((-12 + OBJ.X), (-2 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (-1 + OBJ.Y))-((-1 + OBJ.X), (-5 + OBJ.Y)), COL   'rear window
        LINE ((-5 + OBJ.X), (1 + OBJ.Y))-((1 + OBJ.X), (-5 + OBJ.Y)), COL   'rear window
        LINE ((-1 + OBJ.X), (6 + OBJ.Y))-((6 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((-1 + OBJ.X), (7 + OBJ.Y))-((7 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((0 + OBJ.X), (7 + OBJ.Y))-((7 + OBJ.X), (0 + OBJ.Y)), COL
        LINE ((1 + OBJ.X), (7 + OBJ.Y))-((7 + OBJ.X), (1 + OBJ.Y)), COL

        CASE IS = 2
        '**** 180 deg down
        'errase old car
        LINE ((-7 + oldcar.x), (-9 + oldcar.y))-((-7 + oldcar.x), (-4 + oldcar.y)), 2
        LINE ((-6 + oldcar.x), (-3 + oldcar.y))-((-6 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((-7 + oldcar.x), (5 + oldcar.y))-((-7 + oldcar.x), (12 + oldcar.y)), 2
        PSET (-6, 13), 2
        LINE ((-5 + oldcar.x), (13 + oldcar.y))-((-3 + oldcar.x), (8 + oldcar.y)), 2
        LINE ((-3 + oldcar.x), (13 + oldcar.y))-((3 + oldcar.x), (13 + oldcar.y)), 2
        LINE ((5 + oldcar.x), (13 + oldcar.y))-((3 + oldcar.x), (8 + oldcar.y)), 2
        PSET (6, 13), 2
        LINE ((7 + oldcar.x), (12 + oldcar.y))-((7 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (4 + oldcar.y))-((6 + oldcar.x), (-3 + oldcar.y)), 2
        LINE ((7 + oldcar.x), (-4 + oldcar.y))-((7 + oldcar.x), (-9 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (-10 + oldcar.y))-((-6 + oldcar.x), (-10 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (-5 + oldcar.y))-((4 + oldcar.x), (-5 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (-4 + oldcar.y))-((5 + oldcar.x), (-4 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (4 + oldcar.y))-((5 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (5 + oldcar.y))-((5 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (6 + oldcar.y))-((4 + oldcar.x), (6 + oldcar.y)), 2
        'draw new car
        LINE ((-7 + OBJ.X), (-9 + OBJ.Y))-((-7 + OBJ.X), (-4 + OBJ.Y)), COL
        LINE ((-6 + OBJ.X), (-3 + OBJ.Y))-((-6 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((-7 + OBJ.X), (5 + OBJ.Y))-((-7 + OBJ.X), (12 + OBJ.Y)), COL
        PSET (-6, 13), COL
        LINE ((-5 + OBJ.X), (13 + OBJ.Y))-((-3 + OBJ.X), (8 + OBJ.Y)), COL
        LINE ((-3 + OBJ.X), (13 + OBJ.Y))-((3 + OBJ.X), (13 + OBJ.Y)), COL
        LINE ((5 + OBJ.X), (13 + OBJ.Y))-((3 + OBJ.X), (8 + OBJ.Y)), COL
        PSET (6, 13), COL
        LINE ((7 + OBJ.X), (12 + OBJ.Y))-((7 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (4 + OBJ.Y))-((6 + OBJ.X), (-3 + OBJ.Y)), COL
        LINE ((7 + OBJ.X), (-4 + OBJ.Y))-((7 + OBJ.X), (-9 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (-10 + OBJ.Y))-((-6 + OBJ.X), (-10 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (-5 + OBJ.Y))-((4 + OBJ.X), (-5 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (-4 + OBJ.Y))-((5 + OBJ.X), (-4 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (4 + OBJ.Y))-((5 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (5 + OBJ.Y))-((5 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (6 + OBJ.Y))-((4 + OBJ.X), (6 + OBJ.Y)), COL
       
        CASE IS = 1
        '**** 225 deg left down
        'errase old car
        LINE ((3 + oldcar.x), (-11 + oldcar.y))-((11 + oldcar.x), (-3 + oldcar.y)), 2
        LINE ((2 + oldcar.x), (-11 + oldcar.y))-((-3 + oldcar.x), (-6 + oldcar.y)), 2
        LINE ((3 + oldcar.x), (-5 + oldcar.y))-((-7 + oldcar.x), (1 + oldcar.y)), 2' 2
        LINE ((-8 + oldcar.x), (-1 + oldcar.y))-((-13 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((-13 + oldcar.x), (6 + oldcar.y))-((-9 + oldcar.x), (4 + oldcar.y)), 2   'hood
        LINE ((-11 + oldcar.x), (8 + oldcar.y))-((-8 + oldcar.x), (11 + oldcar.y)), 2  'grill
        LINE ((-6 + oldcar.x), (13 + oldcar.y))-((-4 + oldcar.x), (9 + oldcar.y)), 2    'hood
        LINE ((-3 + oldcar.x), (13 + oldcar.y))-((1 + oldcar.x), (9 + oldcar.y)), 2
        LINE ((1 + oldcar.x), (8 + oldcar.y))-((6 + oldcar.x), (3 + oldcar.y)), 2
        LINE ((7 + oldcar.x), (3 + oldcar.y))-((12 + oldcar.x), (-2 + oldcar.y)), 2
        LINE ((5 + oldcar.x), (-1 + oldcar.y))-((1 + oldcar.x), (-5 + oldcar.y)), 2  'rear window
        LINE ((5 + oldcar.x), (1 + oldcar.y))-((-1 + oldcar.x), (-5 + oldcar.y)), 2   'rear window
        LINE ((1 + oldcar.x), (6 + oldcar.y))-((-6 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((1 + oldcar.x), (7 + oldcar.y))-((-7 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((0 + oldcar.x), (7 + oldcar.y))-((-7 + oldcar.x), (0 + oldcar.y)), 2
        LINE ((-1 + oldcar.x), (7 + oldcar.y))-((-7 + oldcar.x), (1 + oldcar.y)), 2
        'draw new car
        LINE ((3 + OBJ.X), (-11 + OBJ.Y))-((11 + OBJ.X), (-3 + OBJ.Y)), COL
        LINE ((2 + OBJ.X), (-11 + OBJ.Y))-((-3 + OBJ.X), (-6 + OBJ.Y)), COL
        LINE ((3 + OBJ.X), (-5 + OBJ.Y))-((-7 + OBJ.X), (1 + OBJ.Y)), 2' col
        LINE ((-8 + OBJ.X), (-1 + OBJ.Y))-((-13 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((-13 + OBJ.X), (6 + OBJ.Y))-((-9 + OBJ.X), (4 + OBJ.Y)), COL   'hood
        LINE ((-11 + OBJ.X), (8 + OBJ.Y))-((-8 + OBJ.X), (11 + OBJ.Y)), COL  'grill
        LINE ((-6 + OBJ.X), (13 + OBJ.Y))-((-4 + OBJ.X), (9 + OBJ.Y)), COL    'hood
        LINE ((-3 + OBJ.X), (13 + OBJ.Y))-((1 + OBJ.X), (9 + OBJ.Y)), COL
        LINE ((1 + OBJ.X), (8 + OBJ.Y))-((6 + OBJ.X), (3 + OBJ.Y)), COL
        LINE ((7 + OBJ.X), (3 + OBJ.Y))-((12 + OBJ.X), (-2 + OBJ.Y)), COL
        LINE ((5 + OBJ.X), (-1 + OBJ.Y))-((1 + OBJ.X), (-5 + OBJ.Y)), COL  'rear window
        LINE ((5 + OBJ.X), (1 + OBJ.Y))-((-1 + OBJ.X), (-5 + OBJ.Y)), COL   'rear window
        LINE ((1 + OBJ.X), (6 + OBJ.Y))-((-6 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((1 + OBJ.X), (7 + OBJ.Y))-((-7 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((0 + OBJ.X), (7 + OBJ.Y))-((-7 + OBJ.X), (0 + OBJ.Y)), COL
        LINE ((-1 + OBJ.X), (7 + OBJ.Y))-((-7 + OBJ.X), (1 + OBJ.Y)), COL

        CASE IS = 8
        '**** 270 deg left
        'errase old car
        LINE ((4 + oldcar.x), (-7 + oldcar.y))-((9 + oldcar.x), (-7 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (-6 + oldcar.y))-((3 + oldcar.x), (-6 + oldcar.y)), 2
        LINE ((-12 + oldcar.x), (-7 + oldcar.y))-((-5 + oldcar.x), (-7 + oldcar.y)), 2
        PSET (13, -6), 2
        LINE ((-8 + oldcar.x), (-5 + oldcar.y))-((-13 + oldcar.x), (-3 + oldcar.y)), 2
        LINE ((-13 + oldcar.x), (-3 + oldcar.y))-((-13 + oldcar.x), (3 + oldcar.y)), 2
        LINE ((-8 + oldcar.x), (5 + oldcar.y))-((-13 + oldcar.x), (3 + oldcar.y)), 2
        PSET (13, 6), 2
        LINE ((-5 + oldcar.x), (7 + oldcar.y))-((-12 + oldcar.x), (7 + oldcar.y)), 2
        LINE ((3 + oldcar.x), (6 + oldcar.y))-((-4 + oldcar.x), (6 + oldcar.y)), 2
        LINE ((9 + oldcar.x), (7 + oldcar.y))-((4 + oldcar.x), (7 + oldcar.y)), 2
        LINE ((10 + oldcar.x), (6 + oldcar.y))-((10 + oldcar.x), (-6 + oldcar.y)), 2
        LINE ((5 + oldcar.x), (-4 + oldcar.y))-((5 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((4 + oldcar.x), (-5 + oldcar.y))-((4 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((-4 + oldcar.x), (-5 + oldcar.y))-((-4 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((-5 + oldcar.x), (-5 + oldcar.y))-((-5 + oldcar.x), (5 + oldcar.y)), 2
        LINE ((-6 + oldcar.x), (-4 + oldcar.y))-((-6 + oldcar.x), (4 + oldcar.y)), 2
        'draw new car
        LINE ((4 + OBJ.X), (-7 + OBJ.Y))-((9 + OBJ.X), (-7 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (-6 + OBJ.Y))-((3 + OBJ.X), (-6 + OBJ.Y)), COL
        LINE ((-12 + OBJ.X), (-7 + OBJ.Y))-((-5 + OBJ.X), (-7 + OBJ.Y)), COL
        PSET (13, -6), COL
        LINE ((-8 + OBJ.X), (-5 + OBJ.Y))-((-13 + OBJ.X), (-3 + OBJ.Y)), COL
        LINE ((-13 + OBJ.X), (-3 + OBJ.Y))-((-13 + OBJ.X), (3 + OBJ.Y)), COL
        LINE ((-8 + OBJ.X), (5 + OBJ.Y))-((-13 + OBJ.X), (3 + OBJ.Y)), COL
        PSET (13, 6), COL
        LINE ((-5 + OBJ.X), (7 + OBJ.Y))-((-12 + OBJ.X), (7 + OBJ.Y)), COL
        LINE ((3 + OBJ.X), (6 + OBJ.Y))-((-4 + OBJ.X), (6 + OBJ.Y)), COL
        LINE ((9 + OBJ.X), (7 + OBJ.Y))-((4 + OBJ.X), (7 + OBJ.Y)), COL
        LINE ((10 + OBJ.X), (6 + OBJ.Y))-((10 + OBJ.X), (-6 + OBJ.Y)), COL
        LINE ((5 + OBJ.X), (-4 + OBJ.Y))-((5 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((4 + OBJ.X), (-5 + OBJ.Y))-((4 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((-4 + OBJ.X), (-5 + OBJ.Y))-((-4 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((-5 + OBJ.X), (-5 + OBJ.Y))-((-5 + OBJ.X), (5 + OBJ.Y)), COL
        LINE ((-6 + OBJ.X), (-4 + OBJ.Y))-((-6 + OBJ.X), (4 + OBJ.Y)), COL

        CASE IS = 7
        '**** 315 deg up left
        'Errase old car
        LINE ((4 + oldcar.x), (12 + oldcar.y))-((12 + oldcar.x), (4 + oldcar.y)), 2
        LINE ((12 + oldcar.x), (3 + oldcar.y))-((8 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (-2 + oldcar.y))-((1 + oldcar.x), (-7 + oldcar.y)), 2
        LINE ((1 + oldcar.x), (-8 + oldcar.y))-((-4 + oldcar.x), (-13 + oldcar.y)), 2
        LINE ((-6 + oldcar.x), (-12 + oldcar.y))-((-4 + oldcar.x), (-7 + oldcar.y)), 2  'hood
        LINE ((-8 + oldcar.x), (-10 + oldcar.y))-((-11 + oldcar.x), (-7 + oldcar.y)), 2
        LINE ((-13 + oldcar.x), (-4 + oldcar.y))-((-7 + oldcar.x), (2 + oldcar.y)), 2
        LINE ((-7 + oldcar.x), (1 + oldcar.y))-((-2 + oldcar.x), (7 + oldcar.y)), 2
        LINE ((-2 + oldcar.x), (8 + oldcar.y))-((2 + oldcar.x), (12 + oldcar.y)), 2
        LINE ((6 + oldcar.x), (-1 + oldcar.y))-((-2 + oldcar.x), (6 + oldcar.y)), 2
        LINE ((5 + oldcar.x), (1 + oldcar.y))-((-1 + oldcar.x), (6 + oldcar.y)), 2
        LINE ((1 + oldcar.x), (-5 + oldcar.y))-((-6 + oldcar.x), (2 + oldcar.y)), 2
        LINE ((1 + oldcar.x), (-6 + oldcar.y))-((-7 + oldcar.x), (2 + oldcar.y)), 2
        LINE ((0 + oldcar.x), (-6 + oldcar.y))-((-6 + oldcar.x), (0 + oldcar.y)), 2
        LINE ((-1 + oldcar.x), (-6 + oldcar.y))-((-6 + oldcar.x), (-1 + oldcar.y)), 2
        LINE ((-8 + oldcar.x), (-3 + oldcar.y))-((-12 + oldcar.x), (-5 + oldcar.y)), 2
        'Draw new car
        LINE ((4 + OBJ.X), (12 + OBJ.Y))-((12 + OBJ.X), (4 + OBJ.Y)), COL
        LINE ((12 + OBJ.X), (3 + OBJ.Y))-((8 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (-2 + OBJ.Y))-((1 + OBJ.X), (-7 + OBJ.Y)), COL
        LINE ((1 + OBJ.X), (-8 + OBJ.Y))-((-4 + OBJ.X), (-13 + OBJ.Y)), COL
        LINE ((-6 + OBJ.X), (-12 + OBJ.Y))-((-4 + OBJ.X), (-7 + OBJ.Y)), COL  'hood
        LINE ((-8 + OBJ.X), (-10 + OBJ.Y))-((-11 + OBJ.X), (-7 + OBJ.Y)), COL
        LINE ((-13 + OBJ.X), (-4 + OBJ.Y))-((-7 + OBJ.X), (2 + OBJ.Y)), COL
        LINE ((-7 + OBJ.X), (1 + OBJ.Y))-((-2 + OBJ.X), (7 + OBJ.Y)), COL
        LINE ((-2 + OBJ.X), (8 + OBJ.Y))-((2 + OBJ.X), (12 + OBJ.Y)), COL
        LINE ((6 + OBJ.X), (-1 + OBJ.Y))-((-2 + OBJ.X), (6 + OBJ.Y)), COL
        LINE ((5 + OBJ.X), (1 + OBJ.Y))-((-1 + OBJ.X), (6 + OBJ.Y)), COL
        LINE ((1 + OBJ.X), (-5 + OBJ.Y))-((-6 + OBJ.X), (2 + OBJ.Y)), COL
        LINE ((1 + OBJ.X), (-6 + OBJ.Y))-((-7 + OBJ.X), (2 + OBJ.Y)), COL
        LINE ((0 + OBJ.X), (-6 + OBJ.Y))-((-6 + OBJ.X), (0 + OBJ.Y)), COL
        LINE ((-1 + OBJ.X), (-6 + OBJ.Y))-((-6 + OBJ.X), (-1 + OBJ.Y)), COL
        LINE ((-8 + OBJ.X), (-3 + OBJ.Y))-((-12 + OBJ.X), (-5 + OBJ.Y)), COL
        CASE ELSE
        LOCATE 10, 10: PRINT "no dir"
END SELECT

END SUB

SUB drawscreen
car p.x, p.y, pold.x, pold.y, DIRECTION, 1
car c.x, c.y, cold.x, cold.y, cDIRECTION, 3  'computer car

'Dashboard
LOCATE 28, 1: PRINT "player's speed |"; p.s; " "; DIRECTION
LOCATE 28, 30: PRINT "| comp's speed |"; c.s; " "; cDIRECTION

'Boost arrow
LINE (100, 100)-(150, 150), 6, BF

'Walls
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
   pold.x = p.x
   pold.y = p.y
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

PAINT (160, 100), 2
END SUB

SUB walls (objx!, objy!, newDIRECTION!)
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
   SELECT CASE newDIRECTION
    CASE IS = 1: newDIRECTION = 3
    CASE IS = 2: newDIRECTION = 6
    CASE IS = 3: newDIRECTION = 1
    CASE IS = 4: newDIRECTION = 8
    CASE IS = 5: newDIRECTION = 7
    CASE IS = 6: newDIRECTION = 2
    CASE IS = 7: newDIRECTION = 5
    CASE IS = 8: newDIRECTION = 4
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

