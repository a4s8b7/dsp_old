CLS
RANDOMIZE TIMER
FOR RUUN = 1 TO 1000
FOR A = 60 TO 90
X = INT(RND * 24) + 1
Y = INT(RND * 70) + 1
LOCATE (X), (Y): PRINT CHR$(A)
kbd$ = INKEY$
IF kbd$ = "q" OR kbd$ = "Q" THEN
GOTO AndrewBuczko
END IF
NEXT A
NEXT RUUN
AndrewBuczko:

