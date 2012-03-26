DECLARE SUB lesson9 ()
DECLARE SUB lesson8 ()
DECLARE SUB lesson7 ()
DECLARE SUB lesson5 ()
DECLARE SUB lesson4 ()
DECLARE SUB lesson3 ()
DECLARE SUB lesson2 ()
DECLARE SUB lesson1 ()
endflag$ = "no"
CLS

LOCATE 5, 35: PRINT "WELCOME TO"
LOCATE 10, 20: PRINT "DUNGEN STUDEOS'S CIRCLE TUTORIAL"

LOCATE 15, 20: PRINT "Ver 10.0 written by Andrew S. Buczko"
LOCATE 16, 20: PRINT "Copy right 2001 \ all rights reserved"

LOCATE 18, 20: PRINT "The following selection will help you"
LOCATE 19, 20: PRINT "with drawing circle's in QBasic."

LOCATE 24, 20: INPUT "Press enter to start"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3

CLS
LOCATE 5, 5: PRINT "Draws a circle or ellipse on the screen."
LOCATE 6, 5: PRINT "CIRCLE [STEP] (x!,y!),radius![,[color%] [,[start!] [,[end!] [,aspect!]]]]"
DO WHILE endflag$ = "no"
LOCATE 10, 20: PRINT "welcome to Andrews circle"
LOCATE 11, 23: PRINT "1> The basic circle"
LOCATE 12, 23: PRINT "2> Locating the circle on the screen"
LOCATE 13, 23: PRINT "3> Using the STEP"
LOCATE 14, 23: PRINT "4> Assigning colors to the circle"
LOCATE 15, 23: PRINT "5> Using the circles aspect"
LOCATE 16, 23: PRINT "6> There is NO rule six"
LOCATE 17, 23: PRINT "7> The Start + Ends of a circle"
LOCATE 18, 23: PRINT "8> This space for rent!"
LOCATE 19, 23: PRINT "9> The NITTY GRITTY's of the circle"
LOCATE 20, 23: INPUT "Please make a selection (Q to quit)"; Enter$

SELECT CASE Enter$
        CASE IS = "1"
           lesson1
        CASE IS = "2"
           lesson2
        CASE IS = "3"
           lesson3
        CASE IS = "4"
           lesson4
        CASE IS = "5"
           lesson5
        CASE IS = "6"
           CLS
           LOCATE 10, 20: PRINT "THERE IS NO RULE SIX!"
                SOUND 15000, 3
                SOUND 5000, 3
                SOUND 1000, 3
           INPUT "Please press enter "; Enter$
        CASE IS = "7"
           lesson7
        CASE IS = "8"
           lesson8
        CASE IS = "9"
           lesson9
        CASE IS = "q"
                endflag$ = "Andrew S Buczko"
        CASE IS = "Q"
                endflag$ = "Andrew S Buczko"
        CASE ELSE
        CLS
        LOCATE 10, 20: INPUT "That was an invalid selection (hit anykey)"; Enter$
END SELECT
LOOP
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
END

SUB lesson1
CLS
'ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
LOCATE 1, 1: PRINT "ok, first we need to set the"
LOCATE 2, 1: PRINT "screen mode to screen 12"

LOCATE 1, 55: PRINT "****<ACTUAL CODE>****"
LOCATE 2, 55: PRINT "*SCREEN 12         *"
LOCATE 3, 55: PRINT "*                  *"
LOCATE 4, 55: PRINT "********************"

LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
SCREEN 12
PRINT
PRINT
PRINT
PRINT "now you should be in screen mode 12"
PRINT
PRINT "mode 12 has a resolution of 640 by 480 pixels,"
PRINT "It has an Assignment of up to 256K for 16"
PRINT "attributes so it can have about 16 different colors"

LOCATE 1, 55: PRINT "****<ACTUAL CODE>****"
LOCATE 2, 55: PRINT "*SCREEN 12         *"
LOCATE 3, 55: PRINT "*                  *"
LOCATE 4, 55: PRINT "********************"
xc = 50
FOR xx = 1 TO 16
xc = xc + 10
CIRCLE ((xc + 50), 250), 25, xx
NEXT xx
xc = 0
LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
'ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO
PRINT
PRINT
PRINT
PRINT "so I will set the X and Y to 200, that way our"
PRINT "circle will be neer the center of the screen"
PRINT
PRINT "well set the radius to 50, to make the circle big"
LOCATE 10, 30: PRINT "X = 200"
LOCATE 11, 30: PRINT "Y = 200"
LOCATE 12, 30: PRINT "R = 50"
LOCATE 1, 55: PRINT "****<ACTUAL CODE>****"
LOCATE 2, 55: PRINT "* SCREEN 12         *"
LOCATE 3, 55: PRINT "* X = 200           *"
LOCATE 4, 55: PRINT "* Y = 200           *"
LOCATE 5, 55: PRINT "* R = 50            *"
LOCATE 6, 55: PRINT "********************"

LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
PRINT
PRINT
PRINT
PRINT "Now we need to give the circle some color"
PRINT
PRINT "I'll set it to 1, I like that color"
LOCATE 10, 30: PRINT "X = 200"
LOCATE 11, 30: PRINT "Y = 200"
LOCATE 12, 30: PRINT "R = 50"
LOCATE 13, 30: PRINT "C = 1"

LOCATE 1, 55: PRINT "****<ACTUAL CODE>*****"
LOCATE 2, 55: PRINT "* SCREEN 12         *"
LOCATE 3, 55: PRINT "* X = 200           *"
LOCATE 4, 55: PRINT "* Y = 200           *"
LOCATE 5, 55: PRINT "* R = 50            *"
LOCATE 6, 55: PRINT "* C = 1             *"
LOCATE 7, 55: PRINT "*********************"

x = 200
y = 200
R = 50
C = 1
LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
PRINT
PRINT
PRINT
PRINT " ok now we have all the things that we need to"
PRINT " make a circle"
PRINT
PRINT "This is the command that we'll use to draw the"
PRINT "circle:"
PRINT
PRINT "          circle (X, Y), R, C"
PRINT
PRINT " Now if you wanted to you could put the values right"
PRINT " in the command like so:"
PRINT
PRINT "          circle (200, 200), 50, 1"
LOCATE 11, 55: PRINT "X = 200"
LOCATE 12, 55: PRINT "Y = 200"
LOCATE 13, 55: PRINT "R = 50"
LOCATE 14, 55: PRINT "C = 1"

LOCATE 1, 55: PRINT "*****<ACTUAL CODE>******"
LOCATE 2, 55: PRINT "* SCREEN 12           *"
LOCATE 3, 55: PRINT "* X = 200             *"
LOCATE 4, 55: PRINT "* Y = 200             *"
LOCATE 5, 55: PRINT "* R = 50              *"
LOCATE 6, 55: PRINT "* C = 1               *"
LOCATE 7, 55: PRINT "* CIRCLE (X, Y), R, C *"
LOCATE 8, 55: PRINT "***********************"

LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
'A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com
PRINT "OK OK now this is the CIRCLE!!"
CIRCLE (x, y), R, C
LOCATE 10, 40: PRINT "X = 200"
LOCATE 11, 40: PRINT "Y = 200"
LOCATE 12, 40: PRINT "R = 50"
LOCATE 13, 40: PRINT "C = 1"
LOCATE 1, 55: PRINT "*****<ACTUAL CODE>******"
LOCATE 2, 55: PRINT "* SCREEN 12           *"
LOCATE 3, 55: PRINT "* X = 200             *"
LOCATE 4, 55: PRINT "* Y = 200             *"
LOCATE 5, 55: PRINT "* R = 50              *"
LOCATE 6, 55: PRINT "* C = 1               *"
LOCATE 7, 55: PRINT "* CIRCLE (X, Y), R, C *"
LOCATE 8, 55: PRINT "***********************"


LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
SOUND 200, 1
END SUB

SUB lesson2
'A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com
CLS
SCREEN 12
PRINT
PRINT
PRINT
PRINT " Ok so now we want to move the circle arond the screen"
PRINT
PRINT " To do that we will need to change the X and Y cowardice"
x = 200
y = 200
CIRCLE (x, y), 50, 1
PRINT " of the circle"
LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
PRINT
PRINT
PRINT
PRINT "lets start by moving the circle down to the bottom of the screen"
PRINT
PRINT "this is the current position of our circle"
PRINT
LOCATE 8, 10: PRINT "X = "; x; "  Y = "; y
CIRCLE (x, y), 50, 1
LOCATE 23, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
PRINT
PRINT
PRINT
PRINT " Now we'll increment the Y cowardice to move the circle down"
PRINT " by adding Y by 10."
PRINT
PRINT "                 Y = Y + 10"
LOCATE 8, 10: PRINT "X = "; x; "  Y = "; y
        y = y + 10
        CIRCLE (x, y), 50, 1
        LOCATE 8, 10: PRINT "X = "; x; "  Y = "; y
        LOCATE 23, 10: INPUT "press enter to move it 10 more down"; Enter$
        y = y + 10
        CIRCLE (x, y), 50, 1
        LOCATE 8, 10: PRINT "X = "; x; "  Y = "; y
        LOCATE 23, 10: INPUT "press enter to move it 10 more down"; Enter$
        y = y + 10
        CIRCLE (x, y), 50, 1
        LOCATE 8, 10: PRINT "X = "; x; "  Y = "; y
        LOCATE 23, 10: INPUT "press enter to continue"; Enter$
SOUND 600, 6
CLS
x = 200: y = 200
CIRCLE (x, y), 50, 1

'A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com

LOCATE 2, 10: PRINT " Now lets move the circle back and fourth"
LOCATE 3, 10: PRINT "we can do that by increasing or decreasing the X value of the circle."
LOCATE 5, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 6, 10: INPUT "PrEss enter and I'll increment X by +30 "; Enter$
x = x + 30
LOCATE 5, 10: PRINT "X = "; x; "  Y = "; y
CIRCLE (x, y), 50, 1
SOUND 400, 6

LOCATE 6, 10: INPUT "PreSS enter and I'll increment X Again "; Enter$
x = x + 30
LOCATE 5, 10: PRINT "X = "; x; "  Y = "; y
CIRCLE (x, y), 50, 1
SOUND 500, 6

LOCATE 6, 10: INPUT "PRess enter and I'll increment X Again "; Enter$
x = x + 30
LOCATE 5, 10: PRINT "X = "; x; "  Y = "; y
CIRCLE (x, y), 50, 1
SOUND 600, 6

CLS
CIRCLE (x, y), 50, 1
LOCATE 2, 10: PRINT "Now we'll move it back, by decrementing X by -30"
LOCATE 3, 10: PRINT "           X = X - 30"
LOCATE 4, 10: INPUT "Press enter to continued"; Enter$
x = x - 30
CIRCLE (x, y), 50, 1
SOUND 600, 6

CLS
CIRCLE (x, y), 50, 1
LOCATE 4, 10: INPUT "Press Enter to decrement X by -30 "; Enter$
LOCATE 3, 10: PRINT "           X = X - 30"
x = x - 30
CIRCLE (x, y), 50, 1
SOUND 500, 6

LOCATE 4, 10: INPUT "Press Enter to decrement X by -30 "; Enter$
LOCATE 3, 10: PRINT "           X = X - 30"
x = x - 30
CIRCLE (x, y), 50, 1
SOUND 400, 6


CIRCLE (x, y), 50, 0           '0 = black, by drawing a black circle
x = x - 30                     'over the previous circle makes the
CIRCLE (x, y), 50, 1           'old circle disappear, this can be faster
LOCATE 10, 10: PRINT "X = "; x; "  Y = "; y      'than using CLS.

'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
LOCATE 3, 10: PRINT "Ok so to move the circle we just increment or decrement"
LOCATE 4, 10: PRINT "the X and Y values of the circle"
LOCATE 4, 10: PRINT "Now I will show you how the X and Y values change"
LOCATE 5, 10: PRINT "while the circle moves diagonally"
LOCATE 24, 10: INPUT "Press enter to continued"; Enter$
CLS

x = 400
y = 200
FOR CTR = 1 TO 100
x = x + 1
y = y + 1
CIRCLE (x, y), 50, 1
LOCATE 3, 10: PRINT "X = "; x; "  Y = "; y
SOUND 200, 1
NEXT CTR

FOR CTR = 1 TO 100
x = x - 1
y = y + 1
CIRCLE (x, y), 50, 1
LOCATE 3, 10: PRINT "X = "; x; "  Y = "; y
SOUND 400, 1
NEXT CTR

FOR CTR = 1 TO 100
x = x - 1
y = y - 1
CIRCLE (x, y), 50, 1
LOCATE 3, 10: PRINT "X = "; x; "  Y = "; y
SOUND 600, 1
NEXT CTR

FOR CTR = 1 TO 100
x = x + 1
y = y - 1
CIRCLE (x, y), 50, 1
LOCATE 3, 10: PRINT "X = "; x; "  Y = "; y
SOUND 800, 1
NEXT CTR
CLS
SOUND 200, 1
END SUB

SUB lesson3
SCREEN 12
'A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com
CLS
x = 200
y = 200
LOCATE 2, 5: PRINT "      STEP       Specifies that coordinates are relative to the current"
LOCATE 3, 5: PRINT "                 graphics cursor position."
CIRCLE (x, y), 50, 1
LOCATE 5, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 6, 10: INPUT "Please press enter to continue"; Enter$
LOCATE 20, 5: PRINT "You can not use CLS, for CLS will change the cursor position."
LOCATE 21, 5: PRINT "The cursor position is different from the TEXT cursor position. (I think)"
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3

CIRCLE STEP(x, 0), 50, 1
LOCATE 2, 5: PRINT "      STEP       Specifies that coordinates are relative to the current"
LOCATE 3, 5: PRINT "                 graphics cursor position."
LOCATE 4, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 5, 8: PRINT "CIRCLE STEP(X, 0), 50, 1"
LOCATE 20, 5: PRINT "To STEP the circle to the right, I placed a 0 inplace of the Y variable."
LOCATE 6, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3

CIRCLE STEP(0, y), 50, 1
LOCATE 2, 5: PRINT "      STEP       Specifies that coordinates are relative to the current"
LOCATE 3, 5: PRINT "                 graphics cursor position."
LOCATE 5, 8: PRINT "CIRCLE STEP(0, Y), 50, 1"
LOCATE 4, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 20, 5: PRINT "If Y = 50 then the STEP will make Y = 100, since there is a 0 in Y's place."
LOCATE 21, 5: PRINT "|                                                                         |"
LOCATE 6, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3

CIRCLE STEP(-x, 0), 50, 1
LOCATE 5, 8: PRINT "CIRCLE STEP(-X, 0), 50, 1"
LOCATE 4, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 20, 5: PRINT "You might have to draw something FIRST before using the STEP, other wise it"
LOCATE 21, 5: PRINT "may step from the point of 0,0"
LOCATE 6, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3

CIRCLE STEP(0, -y), 50, 2
LOCATE 2, 5: PRINT "      STEP       Specifies that coordinates are relative to the current"
LOCATE 3, 5: PRINT "                 graphics cursor position."
LOCATE 5, 8: PRINT "CIRCLE STEP(0, -Y), 50, 2        <-- I have changed the color so"
LOCATE 6, 8: PRINT "                                     that we can see its movement"
LOCATE 4, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 7, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3

CLS
CIRCLE (200, 250), 50
LOCATE 2, 5: PRINT "      STEP       Specifies that coordinates are relative to the current"
LOCATE 3, 5: PRINT "                 graphics cursor position."
LOCATE 5, 8: PRINT "CIRCLE (200, 250), 50"
LOCATE 4, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 25, 5: PRINT "Now we can also STEP the other values of the circle."
LOCATE 6, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
'A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com
'CLS
CIRCLE STEP(0, 0), 100
LOCATE 2, 5: PRINT "      STEP       Specifies that coordinates are relative to the current"
LOCATE 3, 5: PRINT "                 graphics cursor position."
LOCATE 4, 8: PRINT "CIRCLE STEP(0, 0), 100"
LOCATE 5, 10: PRINT "X = "; x; "  Y = "; y
LOCATE 25, 5: PRINT "See I just STEPed the value of the radius, now the radius is doubled."
LOCATE 6, 10: INPUT "Please press enter to continue"; Enter$
SOUND 200, 1
CLS


END SUB

SUB lesson4
SCREEN 12
CLS
PRINT
PRINT "CIRCLE [STEP] (x!,y!),radius![,[color%] [,[start!] [,[end!] [,aspect!]]]]"
PRINT
PRINT "      color%     A color attribute that sets the circle's color. The"
PRINT "                 available color attributes depend on your graphics adapter"
PRINT "                 and the screen mode set by the most recent SCREEN statement."
PRINT
PRINT
PRINT " the color part of the circle is one of the easer parts of drawing a circle"
PRINT
PRINT " CIRCLE (425,350), 50, CCOLOR    This is the circle command, you can see that "
PRINT
PRINT " the variable is for color is the one named color."
PRINT
PRINT " Some simple color values are 1 though 10, you can get more colors by using"
PRINT
PRINT " Red Green Blue setting of 0 to 255 but those settings only work with certain"
PRINT
PRINT " video modes and video cards"
CCOLOR = 1
DO WHILE INKEY$ = ""
 LOCATE 20, 10: PRINT "Please press any key to continue"
 CIRCLE (425, 350), 50, CCOLOR
 CCOLOR = CCOLOR + 1
 IF CCOLOR > 15 THEN
        CCOLOR = 0
 END IF
LOOP
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
'RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
x = 200
y = 200
R = 50
C = 1
FOR CTR = 1 TO 2000
        CIRCLE (x, y), R, C
        x = x + 1
        y = y + 1
        C = C + 1
        IF x > 640 THEN
                x = 1
        END IF
        IF y > 480 THEN
                y = 1
        END IF
        IF C > 16 THEN
                C = 0
        END IF
NEXT CTR
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
LOCATE 6, 10: PRINT "That was a bunch of circles drawn using"
LOCATE 7, 10: PRINT "SCREEN 12 / witch has 16 colors"
LOCATE 8, 10: INPUT "Please press enter to continue"; Enter$
'ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO ANDREW S BUCZKO
SCREEN 13
FOR CTR = 1 TO 2000
        CIRCLE (x, y), R, C
        x = x + 1
        y = y + 1
        C = C + 1
        IF x > 320 THEN
                x = 1
        END IF
        IF y > 200 THEN
                y = 1
        END IF
        IF C > 255 THEN
                C = 0
        END IF
NEXT CTR
LOCATE 1, 1: PRINT "That was about 256 different colored"
LOCATE 2, 1: PRINT "circles using SCREEN 13, now you can"
LOCATE 3, 1: PRINT "get fancy by using Red Green Blue"
LOCATE 4, 1: PRINT "settings. but this is a CIRCLE tutorial"
LOCATE 5, 1: PRINT "NOT a graphic demo."
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
LOCATE 6, 1: INPUT "Please press enter to continue"; Enter$
SCREEN 12
CLS
SOUND 200, 1
END SUB

SUB lesson5
'A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com A4S8B7@bpsom.com
' ANDREW BUCZKO ANDREW BUCZKO ANDREW BUCZKO ANDREW BUCZKO ANDREW BUCZKO ANDREW BUCZKO
CLS
SCREEN 12
CIRCLE (200, 200), 50, 1, S, E, a
LOCATE 3, 25: PRINT "  aspect!   "
LOCATE 4, 30: PRINT "The ratio of the length"
LOCATE 5, 35: PRINT "of the y axis to the"
LOCATE 6, 40: PRINT "length of the x axis,"
LOCATE 7, 45: PRINT "used to draw ellipses."
C = 1: M = 60: MX = 80
FOR x = 1 TO 11    '23
a = x
C = C + 1
M = M + 23
    MX = MX + 13
CIRCLE (M, MX), 80, C, , , a
 IF C > 10 THEN
    C = 1
 END IF
NEXT x
FOR x = 11 TO 1 STEP -1
a = x
C = C + 1
 M = M + 23
 MX = MX + 13
        CIRCLE (M, MX), 80, C, , , a
        IF C > 10 THEN
                C = 1
        END IF
NEXT x
LOCATE 30, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
LOCATE 5, 5: PRINT "Now we'll compare two circles while using the ASPECT variable"
LOCATE 7, 5: PRINT "the Blue circle has                         The Green circle has"
LOCATE 8, 5: PRINT "an ASPECT of 1.                             an ASPECT of 2."

CIRCLE (200, 225), 80, 1, , , 1

CIRCLE (500, 225), 80, 2, , , 2
LOCATE 21, 5: PRINT "you can see that an ASPECT of 1, makes a perfect circle."
LOCATE 22, 5: PRINT "While an ASPECT of 2 is half of the original diameter."
LOCATE 30, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
CLS
LOCATE 5, 5: PRINT "If the ASPECT variable changes the X diameter by half when set to 2"
LOCATE 6, 5: PRINT "And if the ASPECT was set to 3 the diameter would be one third."
LOCATE 7, 5: PRINT "With the ASPECT variable being this sensitive We would want to use"
LOCATE 8, 5: PRINT "smaller increments. "
LOCATE 10, 5: PRINT "The next thing well try is to increment the ASPECT from 1 to 4,"
LOCATE 11, 5: PRINT "using an increment of 0.25"
LOCATE 30, 10: INPUT "Please press enter to continue"; Enter$
SOUND 15000, 3
SOUND 5000, 3
SOUND 1000, 3
again:
FOR CTR = 1 TO 30
aspect = aspect + .25
 IF aspect > 4 THEN
   aspect = .25
 END IF
CIRCLE (200, 250), 80, 1, , , aspect
LOCATE 25, 25: PRINT "ASPECT="; aspect
FOR XXX = 1 TO 5000: NEXT XXX
NEXT CTR
LOCATE 23, 10: INPUT "Press enter to see that again, or Q to continue"; Enter$
IF Enter$ = "Q" OR Enter$ = "q" THEN
  GOTO done
ELSE
  CLS
  GOTO again
END IF
done:
CLS
END SUB

SUB lesson7
CLS
SCREEN 12
'circle
'    þ start!     The starting angle for the arc, in radians.
'    þ end!       The ending angle for the arc, in radians.
SOUND 200, 1
Ran = 0
FOR ctr2 = 5 TO 200 STEP 5
 FOR CTR = .5 TO 6 STEP .5
 
  CIRCLE (250, 200), ctr2, 1, Ran, CTR
  xRan = Ran
  Ran = Ran + .5
  IF Ran > 6 THEN : Ran = 0
  xctr = CTR
  xctr2 = ctr2
  FOR vvv = 1 TO 400: NEXT vvv
  CIRCLE (250, 200), xctr2, 2, xRan, xctr
 
LOCATE 20, 40: PRINT "The Start and End of"
LOCATE 21, 40: PRINT "the Circle are used "
LOCATE 22, 40: PRINT "for drawing arces."

LOCATE 24, 40: PRINT "The Start and End"
LOCATE 25, 40: PRINT "values are in radians"
LOCATE 26, 40: PRINT "instead of degrees"

 NEXT CTR
NEXT ctr2
LOCATE 25, 1: INPUT "Please press enter"; Enter$

x = 150
y = 150
DIA = 150
COL = 1
start = 0
FOR CTR = 0 TO 6 STEP .1
CLS
CIRCLE (x, y), DIA, COL, start, EEND
LOCATE 22, 10: PRINT "START = 0  END = "; EEND
LOCATE 23, 10: PRINT "CIRCLE (X, Y), DIA, COL, "; start; ","; EEND
LOCATE 24, 10: INPUT "Please press Enter to continue"; Enter$
EEND = CTR
NEXT CTR
CIRCLE (x, y), DIA, COL, start, EEND
LOCATE 24, 10: INPUT "Please press Enter to continue"; Enter$

CLS
RANDOMIZE TIMER
FOR CTR = 1 TO 500
x = INT(RND * 640) + 1
y = INT(RND * 420) + 1
DIA = INT(RND * 40) + 1
COL = INT(RND * 10) + 1
start = INT(RND * 6) + .5
EEND = INT(RND * 6) + .5
CIRCLE (x, y), DIA, COL, start, EEND
NEXT CTR
LOCATE 25, 1: INPUT "Please press enter"; Enter$
END SUB

SUB lesson8
CLS
SCREEN 9
COLOR 1
PRINT "                         TTTT   H   H    II    SSSSS"
PRINT "                          TT    H   H    II    SS"
PRINT "                          TT    HHHHH    II    SSSSS"
PRINT "                          TT    H   H    II       SS"
PRINT "                          TT    H   H    II    SSSSS"
PRINT
COLOR 2
PRINT "           SSSSS  PPPPP   AAA   CCCCC  EEEEE      FFFFF   OOO   RRRR  "
PRINT "           SS     PP  P  A   A  CC     EE         FF     OO OO  RR  R "
PRINT "           SSSSS  PPPPP  AAAAA  CC     EEEEE      FFFF   OO OO  RRRR  "
PRINT "              SS  PP     A   A  CC     EE         FF     OO OO  RR  R "
PRINT "           SSSSS  PP     A   A  CCCCC  EEEEE      FF      OOO   RR  RR"
PRINT
PRINT
COLOR 4
PRINT "                          RRRRRR   EEEEEE  NN  NN  TTTTTT "
PRINT "                          RR   RR  EE      NNN NN    TT   "
PRINT "                          RRRRRR   EEEEEE  NNNNNN    TT   "
PRINT "                          RR   RR  EE      NN NNN    TT   "
PRINT "                          RR   RR  EE      NN  NN    TT   "
PRINT "                          RR   RR  EEEEEE  NN  NN    TT   "
PRINT
PRINT
INPUT "Please press enter "; Enter$
PRINT
PRINT "For more information write to:"
PRINT
PRINT "Dungen Studeos"
PRINT "PO BOX 63"
PRINT "Bloomville oh, 44818"
PRINT
INPUT "Please press enter "; Enter$
SOUND 200, 1
SCREEN 12
CLS
END SUB

SUB lesson9
CLS
SCREEN 12
LOCATE 10, 5: PRINT "   the Circle command is all ready made for you But, for"
LOCATE 11, 5: PRINT " those of us that want more flex-ability here is [ HOW TO"
LOCATE 12, 5: PRINT " DRAW A CIRCLE USING THE PSET COMMAND ]."

LOCATE 14, 5: PRINT "    The relationship of a circle's diameter to its circumference is 3.14"
LOCATE 15, 5: PRINT " or also known as PI. Since the radius is half the diameter, there are"
LOCATE 16, 5: PRINT " 2 * 3.14 or roughly 6.28 radians in the circumference of a circle. "
LOCATE 17, 5: PRINT " Qbasic's sine and cosine functions I be leave are designed to work"
LOCATE 18, 5: PRINT " with radians."

LOCATE 19, 5: PRINT "    to draw a circle pixle by pixle we'll need a center vertex."
LOCATE 20, 5: PRINT " Then you'll need to pset a vertex one half the diameter out from your"
LOCATE 21, 5: PRINT " center vertex. Now to draw the next vertex, you will have to rotate the"
LOCATE 22, 5: PRINT " vertex to a new location. "
LOCATE 24, 5: INPUT " please press ENTER"; Enter$
CLS
Z = 1
x = 100
y = 100
CHANGE = .01
'DFDFDFDFFDFDFDFDFDFFDFDFDFDFDFFDFDFDFFDFDFDFDFDFFDFDF
        FOR xx = 1 TO 628
                NEWzX = x * COS(CHANGE) - y * SIN(CHANGE)
                NEWzY = y * COS(CHANGE) + x * SIN(CHANGE)
                y = NEWzY
                x = NEWzX
        LINE (Z + 200, Z + 200)-(y + 200, x + 200), 4
       
        Zold = Z + 200
        Yold1 = y + 200
        Xold1 = x + 200
        Yold2 = Yold1
        Xold2 = Xold1
        Yold3 = Yold2    'this passes the values down / like a delay
        Xold3 = Xold2
        Yold4 = Yold3
        Xold4 = Xold3
        Yold5 = Yold4
        Xold5 = Xold4
        Yold6 = Yold5
        Xold6 = Xold5
        Yold7 = Yold6
        Xold7 = Xold6
       
        'LINE (Zold, Zold)-(Yold6, Xold6), 0     'draws a black line to erase the red line
       
        PSET (Yold7, Xold7), 1          'This part draws a dot on the screen

        FOR XXX = 1 TO 1000: NEXT XXX
       
        NEXT xx
'DFDFDFDFFDFDFDFDFDFFDFDFDFDFDFFDFDFDFFDFDFDFDFDFFDFDF

LOCATE 24, 10: INPUT "please press ENTER"; Enter$
END SUB
