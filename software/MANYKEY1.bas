SCREEN 12
ENDFLAG$ = "NO"

DO WHILE ENDFLAG$ = "NO"
        ASB$ = ""
        DO WHILE ASB$ = ""
           ASB$ = INKEY$
        LOOP
        'CLS
        'HHCTR$ = LEFT$(ASB$, 1)         'pull the high bit
        HCTR = ASC(HHCTR$)              'convert from ascii to decmial
        'LLCTR$ = RIGHT$(ASB$, 1)        'pull the low bit
        'LCTR = ASC(LLCTR$)              'convert from ascii to decmial

        PRINT ASB$

        IF HCTR = 27 THEN
               ENDFLAG$ = "ANSDREW S BUCZKO"
        END IF

LOOP

