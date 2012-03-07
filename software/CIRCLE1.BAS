CLS             'Dungen Studeos 1997
SCREEN 2
FOR all = 1 TO 5
FOR twist = 10 TO 1 STEP -1
CIRCLE (100, 100), 50, , , , twist
FOR x = 1 TO 100: NEXT x
CLS
NEXT twist
'******************************
FOR twist = 1 TO 10
CIRCLE (100, 100), 50, , , , twist
FOR x = 1 TO 100: NEXT x
CLS
NEXT twist
NEXT all

