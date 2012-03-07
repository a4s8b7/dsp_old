DECLARE SUB Sartup ()
DECLARE SUB Calcs (data$)
DECLARE SUB DataIN (data$)
DECLARE SUB Display ()
DECLARE SUB test (bit())
DECLARE SUB readprinterport ()
DIM SHARED endflag AS STRING
DIM SHARED bit(1 TO 8) AS SINGLE

'* Great Train Network controll program.
'*       Versions:
'*               GTN-00-00-0000
'*               GTN-11-25-2008
'*               GTN-02-10-2009 screen and subs added
Sartup

CLS
SCREEN 13
LOCATE 3, 2: PRINT "Great Train network"

'XXX = data
'do while XXX == 0
'	select case XXX'
'		case is > 128 then
'			bit(8) = 1
'			XXX = XXX - 128
'		case is > 64 then
'			bit(7) = 1
'			XXX = XXX - 64
'
'		case is > 32 then
'			bit(6) = 1
'			XXX = XXX - 32
'
'		case is > 16 then
'			bit(5) = 1
'			XXX = XXX - 16
'
'		case is > 8 then
'			bit(4) = 1
'			XXX = XXX - 8
'
'		case is > 4 then
'			bit(3) = 1
'			XXX = XXX - 4
'
'		case is > 2 then
'			bit(2) = 1
'			XXX = XXX - 2
'
'		case is > 1 then
'			bit(1) = 1
'			XXX = XXX - 1
'	end select
'loop



DO WHILE endflag$ = "no"

	Display
	DataIN data$
	Calcs data$

LOOP

END

SUB Calcs (data$)
IF data$ = "exit" OR data$ = "EXIT" THEN
endflag$ = "yes"
END IF
IF data$ = "test" THEN
test bit()
END IF

END SUB

SUB DataIN (data$)
 LOCATE 24, 2
 INPUT "GTN:\{"; data$

END SUB

SUB Display
 
	LOCATE 22, 2: PRINT "type exit to exit"
 
	LINE (2, 2)-(2, 175), 1        'left side line
	LINE (250, 2)-(250, 175), 1    'right side line
 
	LINE (2, 2)-(250, 2), 1        'top line
	LINE (2, 175)-(250, 175), 1    'bottom line

 
	LINE (252, 2)-(252, 175), 3    'left side line
	LINE (315, 2)-(315, 175), 3    'right side line

	LINE (252, 2)-(315, 2), 3      'top line
	LINE (252, 175)-(315, 175), 3  'bottom line

	LINE (2, 177)-(2, 195), 2      'left side line
	LINE (315, 177)-(315, 195), 2  'right side line

	LINE (2, 177)-(315, 177), 2    'top line
	LINE (2, 195)-(315, 195), 2    'bottom line



END SUB

SUB Notes
'* http://courses.ece.uiuc.edu/ece390/books/labmanual/parallel-comm-asm.html
'* http://et.nmsu.edu/~etti/fall96/computer/printer/printer.html
'* Machine-language control uses OUT  instructions to transfer a byte from register
'* AL of the CPU to the adapter's Out latches, or IN instructions to transfer data
'* from the In buffers to register AL. A simplified logic diagram is shown in Figure
'* 13-2. Machine language control is straightforward but several peculiarities of the
' Mario & Zelda Big Band Live - Yoshi's Island - Theme of Athletic
'* adapter logic must be noted:

		'* Data is sent to the printer by OUTputting a byte from register AL to the Data
		'* Out Latch. This latch has tri-state outputs which are always enabled. Thus, the
		'* printer's Data lines CANNOT be used for input; the Data In Buffer can only be
		'* used to read back to data in the Data Out Latch.
		'* Status signals from the printer are INput into register AL via the Status In Buffer
		'* (bits 3-7 only). Table 13-3 shows the meaning assigned to the various bits. Note that
		'* some signals are complemented between the connector and the In Buffer. (The status
		'* byte returned by BIOS call 17h register AH has a timeout indicator added in bit 0 and,
		'* for some reason, has bits 3 and 6 complemented by software.)

			'*Table 13-3. Register AL Bit Assignments for Printer Status Signals
			'*----------------------------------------------------------------------------
			'*pin 0 = nc
			'*pin 1 = nc
			'*pin 2 = nc
			'*pin 3 = I/O error
			'*pin 4 = selected
			'*pin 5 = out of papper
			'*pin 6 = Ack
			'*pin 7 = busy
		 
			'*pin 10 = Ack
			'*pin 11 = busy
			'*pin 12 = out of paper
			'*pin 13 = selected
			'*pin 15 = I/O error
		 
		'* Printer         Data Port        Status          Control
	'* LPT1            0x03bc           0x03bd          0x03be
	'* LPT2            0x0378          0x0379          0x037a
	'* LPT3            0x0278          0x0279          0x027a

	'* To definitively identify the assignments for a particular machine, use the DOS debug program to display memory locations 0040:0008. For example:
	'* >debug
	'* -d 0040:0008 L8
	'* 0040:0008       78 03 78 02 00 00 00 00

'*Note in the example that LPT1 is at 0x0378, LPT2 at 0x0278 and LPT3 and LPT4 are not assigned.
'* Thus, for this hypothetical machine;
'*
'*      Printer         Data Port        Status          Control
'*       LPT1            0x0378          0x0379          0x037a
'*       LPT2            0x0278          0x0279          0x027a
'*       LPT3            NONE
'*       LPT4            NONE

END SUB

SUB readprinterport
	trainload = INP(&H3FC)
END SUB

SUB Sartup
endflag$ = "no"

END SUB

SUB test (bit())
ctr = 1
pause = 1000
DIM bitcolor(1 TO 8) AS SINGLE

FOR ctr = 1 TO 256
	OUT &H3FC, ctr
	LOCATE 15, 15: PRINT "Data Out "; ctr
 
		'* use 3 and 4 for color and the bit value.

	FOR testbitctr = 1 TO 8
		 SELECT CASE bit(testbitctr)
				CASE IS = 1
					 bitcolor(testbitctr) = 4
			 CASE IS = 0
					 bitcolor(testbitctr) = 3
		 END SELECT
	NEXT testbitctr

				LINE (116, 90)-(204, 110), 3, BF   'TEST BOX

				LINE (118, 96)-(126, 104), bitcolor(1), BF
				LINE (129, 96)-(137, 104), bitcolor(2), BF
				LINE (140, 96)-(148, 104), bitcolor(3), BF
				LINE (151, 96)-(159, 104), bitcolor(4), BF

				LINE (162, 96)-(170, 104), bitcolor(5), BF
				LINE (173, 96)-(181, 104), bitcolor(6), BF
				LINE (183, 96)-(191, 104), bitcolor(7), BF
				LINE (194, 96)-(202, 104), bitcolor(8), BF
 
 
 
	FOR rtc = 1 TO pause: NEXT rtc
NEXT ctr


END SUB

