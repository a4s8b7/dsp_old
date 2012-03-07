; 
; NES demo by Tony Young (youngac@expert.cc.purdue.edu) 
;
; Converted to NESASM by Charles Doty (cdoty@doitnow.com)

; INES header setup
        .inesprg    2
        .ineschr    1
        .inesmir    1
        .inesmap    0

        .bank 0
        .org $8000      ; CHR ROM is addressed starting with $8000..
                        ; this compensates making all Jumps valid
main:
        sei
        cld
        jsr ppuinit     ; initialize PPU
        jsr palette     ; setup palette
        jsr attrib      ; setup attribute table
        jsr mazer       ; write maze to name table
        jsr spriter     ; create sprite

end:
        jsr mover       ; take care of moving sprite with joystick
        jmp end

nmi:                    ; begin vblank interrupt (60 times per sec.)
        jsr sndinit     ; initialize sound
        jsr sounder     ; read sound values from memory and control
                        ; music during the interrupt phase
        rti

ppuinit:
        lda #$80        ; See NES Document for register values and meaning
        sta $2000       ; Writes $80 to register $2000
        lda #$1F        ; and
        sta $2001       ; $1F to register $2001
        rts

sndinit:
        lda #$1F        ; Make all sound channels active
        sta $4015
        lda #$0F        ; See NES Document for register values and meaning
        sta $4000       ; Square 1
        sta $4004       ; Square 2
        sta $4008       ; Triangle 
        lda #$00        ; See NES Document for register values and meaning
        sta $4001       ; Square 1
        sta $4005       ; Square 2
        sta $4009       ; Triangle
        rts

square1:
        stx $4002       ; This subroutine stores the X and Y register
                        ; values to $4002 & $4003
        sty $4003       ; Initiating a tone in the square wave channel #1
        rts

square2:
        stx $4006       ; This subroutine stores the X and Y register values to
                        ; $4006 & $4007
        sty $4007       ; Initiating a tone in the square wave channel #2
        rts

triangle:
        stx $400A       ; This subroutine stores the X and Y register values to
                        ; $400A & $400B
        sty $400B       ; Initiating a tone in the triangle wave channel
        rts

palette:
        lda #$3F        ; This is a really crazy way to map a palette..
        sta $2006       ; It's a ROM hog, but it works 
        lda #$00        ; basically the first four lines set the PPU writing
        sta $2006       ; address to $3F00 and the remaining lines write value 
        lda #$01        ; by value to the PPU through $2007 and every write to 
        sta $2007       ; $2007 results in an auto increment by one.. See NES
        lda #$02        ; documentation for more details.
        sta $2007       ; This takes care of the Image Palette and the Sprite
        lda #$03        ; Palette
        sta $2007
        lda #$04
        sta $2007
        lda #$01
        sta $2007
        lda #$05
        sta $2007
        lda #$06
        sta $2007
        lda #$07
        sta $2007
        lda #$01
        sta $2007
        lda #$08
        sta $2007
        lda #$09
        sta $2007
        lda #$0A
        sta $2007
        lda #$01
        sta $2007
        lda #$0B
        sta $2007
        lda #$0C
        sta $2007
        lda #$0D
        sta $2007
        lda #$01
        sta $2007
        lda #$02
        sta $2007
        lda #$03
        sta $2007
        lda #$04
        sta $2007
        lda #$01
        sta $2007
        lda #$05
        sta $2007
        lda #$06
        sta $2007
        lda #$07
        sta $2007
        lda #$01
        sta $2007
        lda #$08
        sta $2007
        lda #$09
        sta $2007
        lda #$0A
        sta $2007
        lda #$01
        sta $2007
        lda #$0B
        sta $2007
        lda #$0C
        sta $2007
        lda #$0D
        sta $2007
        rts

scroll:        
        stx $2005       ; This routine writes the X and Y registers to the 
        sty $2005       ; scroll register.. See NES Doc. for more details.
        rts

hput:
        sty $2007       ; This is not a general routine, but a specific routine
        dex             ; for writing a chain of contiguous identical values to 
        bne hput        ; the PPU.. The X register must be set to the number of 
        rts             ; repeats, the Y reg. to the value, and the start address
                        ; must be written to through $2006 before calling this sub.
put:
        sty $2007       ; Just for writing a single value to the PPU
        rts

attrib:
        ldx #$00        ; Initialize X register to 0
        lda #$23        ;
        sta $2006       ; Set start address to PPU address $23C0
        lda #$C0        ;    (1st attribute table)
        sta $2006       ;

lll:
        lda #$FF        ; Write attribute table value and auto increment
        sta $2007       ; to next address
        inx             ; Increment the X register
        cpx #$40        ; Check to see if X register = $40 (size of Att. table)
        bne lll         ; If X does not yet equal $40 the loop back to lll and 
        rts             ; repeat

mazer:
        lda #$20        ;
        sta $2006       ; Set start address to Name Table #1
        lda #$00        ;
        sta $2006       ;
        ldx #$00        ; Set X insty to 0

beg:
        ldy maze,x      ; Load Y insty with "maze" + X offset

rep:
        lda #$01        ; begin 1st cycle of writing $01 to the name table
        sta $2007       ; the number of times in the Y register
        dey             ; Decrement Y and
        bne rep         ; Repeat if Y is not yet zero
        inx             ; Increment X and
        ldy maze,x      ; Read the next maze value into the Y register

repa:
        lda #$00        ; begin 2nd cycle of writing $00 to the name table
        sta $2007       ; the number of times in the Y register
        dey             ; Decrement Y and
        bne repa        ; Repeat if Y is not zero
        inx             ; Increment X
        cpx #252        ; right now the routine quits after 252 maze values
        bne beg         ; repeat the 1st & 2nd cycle if X isn't yet 252
        rts

beep:                   ; Just makes a beep
        lda #$03
        sta $4006
        lda #$AA
        sta $4007
        rts

sounder:                ; Takes care of sound handling
        stx <$06        ; Save X value in case it's being used when sounder is called
        ldx <$03        ; Load the contents of memory address $03 into X
        inx             ; and add one
        stx <$03        ; then put it back
        cpx #15         ; If $03 is equal to 15 then continue otherwise go to 
        bne noplay      ; label noplay
        ldx #$00        ; BEGIN SOUND CODE (4 times per 60 cycles or 1 second)
        stx <$03        ; start $03 at zero again
        ldx <$02        ; $02 is an insty value to tell which set of notes are 
        lda music,x     ; being used from the music data
        sta $4002       ; 
        inx             ;   Loads two bytes into square wave #1 registers 
        lda music,x     ;
        sta $4003       ; <
        inx             ;
        lda music,x     ;
        sta $4006       ;   Loads two bytes into square wave #2 registers
        inx             ;
        lda music,x     ;
        sta $4007       ; <
        inx         	;
        lda music,x 	;
        sta $400A   	;
        inx         	;   Loads two bytes into triangle wave registers
        lda music,x 	;
        sta $400B   	;
        inx         	; <
        cpx #192    	; there are currently 192 music entries 
        bne noreset 	; skip setting X to zero if it's less than 192
        ldx #$00

noreset:
        stx <$02        ; store X at $02 for future use

noplay:
        ldx <$06        ; load the value of X from $06 stored before this 
        rts         	; sound function executed

spriter:
        lda #$00    	; Routine for initializing a sprite.. Just writes 
        sta $2003   	; values to Sprite Ram via registers
        lda #135
        sta $2004
        sta <$04
        lda #$0F
        sta $2004
        lda #$00
        sta $2004
        lda #232
        sta $2004
        sta <$05
        rts

joya:               	; Detect A button press by setting the A register to 0 or 1
        lda #$01    	;
        sta $4016   	; Reset joystick.. see NES documentation for details
        lda #$00    	;
        sta $4016   	;
        lda $4016   	; The first read will have the A button status in it's first bit
        and #$01    	; Set A to 1 if pressed ; 0 if not
        rts

joyb:
        lda #$01	; See joystick A routine
        sta $4016
        lda #$00
        sta $4016
        lda $4016
        lda $4016		; The second read will have the B button status
        and #$01
        rts

joysel:
        lda #$01
        sta $4016
        lda #$00
        sta $4016
        lda $4016
        lda $4016
        lda $4016		; 3 reads for select
        and #$01
        rts

joyst:
        lda #$01
        sta $4016
        lda #$00
        sta $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016	; 4 reads for start
        and #$01
        rts

joyup:
        lda #$01
        sta $4016
        lda #$00
        sta $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016     	; 5 reads for up
        and #$01
        rts

joydown:
        lda #$01
        sta $4016
        lda #$00
        sta $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016     	; 6 reads for down
        and #$01
        rts

joyleft:
        lda #$01
        sta $4016
        lda #$00
        sta $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016    	; 7 reads for left
        and #$01
        rts

joyright:
        lda #$01
        sta $4016
        lda #$00
        sta $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016
        lda $4016     	; 8 reads for down
        and #$01
        rts

movesprite:
        lda #$00       	; writes to sprite RAM to move sprite #0 to the coordinates
        sta $2003      	; in the X and Y registers
        sty $2004
        lda #$03
        sta $2003
        stx $2004
        rts

mover:
        jsr joyup     	; This routine handles moving the sprite based on input
        beq aa         	; It's rather complex to document.. see if you can figure
        ldx <$05        ; it out :) .. all the jsr calls are just for the sake of
        ldy <$04        ; slowing down the function enough to make each frame
                       	; of
        dey            	; movement visible.. each movement moves eight
                       	; spaces to
        jsr pause      	; keep the sprite in-line with name table entries..
                       	; and just
        dey            	; to make things more confusing, the sprite coordinates
                       	; are
        jsr pause      	; updated in the pause routine.. Have fun deciphering
                       	; this one
        dey
        jsr pause
        dey
        jsr pause
        dey
        jsr pause
        dey
        jsr pause
        dey
        jsr pause
        dey
        jsr pause
        sty <$04
        jsr beep

aa:
        jsr joydown
        beq bb
        ldx <$05
        ldy <$04
        iny
        jsr pause
        iny
        jsr pause
        iny
        jsr pause
        iny
        jsr pause
        iny
        jsr pause
        iny
        jsr pause
        iny
        jsr pause
        iny
        jsr pause
        sty <$04
        jsr beep

bb:
        jsr joyleft
        beq cc
        ldx <$05
        ldy <$04
        dex
        jsr pause
        dex
        jsr pause
        dex
        jsr pause
        dex
        jsr pause
        dex
        jsr pause
        dex
        jsr pause
        dex
        jsr pause
        dex
        jsr pause
        stx <$05
        jsr beep

cc:
        jsr joyright
        beq dd
        ldx <$05
        ldy <$04
        inx
        jsr pause
        inx
        jsr pause
        inx
        jsr pause
        inx
        jsr pause
        inx
        jsr pause
        inx
        jsr pause
        inx
        jsr pause
        inx
        jsr pause
        stx <$05
        jsr beep

dd:
        rts

timehog:
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        rts

time:
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        jsr timehog
        rts

pause:
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr time
        jsr movesprite
        rts

music:                 		; music data.. each line goes with a set of values for all three music channels
    .db $B4,$10,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $A0,$20,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $A9,$20,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $8E,$10,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $A0,$10,$EF,$40,$B4,$40
    .db $B4,$10,$EF,$40,$B4,$40
    .db $A9,$10,0,0,$7F,$40
    .db $B4,$10,0,0,$78,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $A0,$20,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $A9,$20,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $8E,$10,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $A0,$10,$D4,$40,$A0,$40
    .db $B4,$10,$D4,$40,$A0,$40
    .db $A9,$10,0,0,$7F,$40
    .db $B4,$10,0,0,$78,$40

maze:                                   ; maze data.. the first value represents contiguous blocks.. the second value represents contiguous empty space.. and it alternates like this
    .db 64
    .db 3,1,14,1,5,1,5,2
    .db 3,1,14,1,5,1,5,3
    .db 2,1,2,10,2,1,2,1,2,1,2,1,2,3
    .db 2,1,5,1,5,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,5,1,5,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,5,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,1,5,1,2,1,2,1,2,3
    .db 2,1,2,1,2,1,2,1,2,7,2,1,2,1,2,3
    .db 5,1,5,1,14,1,2,3
    .db 5,1,5,1,14,1,2,34

    .bank 3
    .org  $fffa
    .dw   nmi
    .dw   main

    .bank 4
    .org    $0000
    .incbin "junkdemo.chr"

