EasyBMPtoAVI Movie Creator
Version 0.55

Author:  Paul Macklin
Website: http://EasyBMPtoAVI.sourceforge.net

Intro:
EasyBMPtoAVI is a simple, easy-to-use, cross-platform 
utility for creating an avi movie file from a series 
of windows bitmap (BMP) images. Some features:

1) Support for reading all bit-depths supported by 
   EasyBMP. At the present time, this includes 1, 
   4, 8, 16, 24, and 32-bpp bitmap images.

2) Can create files up to 2GB in size.

3) Output is uncompressed, so you can choose your own 
   compression without loss of quality. 

4) Cross-platform compatible (Linux, Unix, Windows, 
   Macintosh, Solaris, ...)

5) Cross-compiler compatible (supports compiling in 
   MS Visual Studio, g++, MinGW, Intel's icc, 
   and the lousy Borland compiler)

6) Easy user interface even helps you if you forget 
   to specify crucial information. 
   
7) Endian-safe as of Version 0.52, so it will work 
   on things like PowerPC, Sparc, etc.    
   
8) 64-bit compatible

9) EasyBMP Version 1.05 or higher is required 

Use:
EasyBMPtoAVI needs to know a few things to run: the 
naming scheme of your bitmap files (along with the 
first and last files), your desired framerate, and 
the name of the output video file. This information 
is supplied as command-line arguments:

-framerate
-start
-filebase
-filelist
-end
-output

To see how to use EasyBMPtoAVI Movie Creator, 
type 

EasyBMPtoAVI -help

Here's the current help:

EasyBMPtoAVI Help:
=================
Usage scenario 1:
----------------
Convert frame000.bmp ... frame123.bmp to out.avi at framerate 13 fps: 
EasyBMPtoAVI -filebase frame -start 0 -end 123 -framerate 13 -output out.avi
EasyBMPtoAVI -filebase gf -start 14 -end 41 -framerate 30 -output gf.avi

Usage scenario 2:
----------------
Convert frame00.bmp ... frame13.bmp to out.avi at framerate 13 fps:
EasyBMPtoAVI -start frame00.bmp -end frame13.bmp -framerate 13 -output out.avi

Usage scenario 3:
----------------
Convert files listed in FileList.txt to out.avi at framerate 13 fps:
EasyBMPtoAVI -filelist FileList.txt -framerate 13 -output out.avi

Additional flags:
----------------
-increment N Assume that filenames are incremented by N, rather than 1. 
-copyright   Set the copyright bit in the output file
-help        Access this help screen
-smooth N    Smooths (temporally) by a factor of N. Useful for low-fps animations.
-interleave  Uses interleaving rather than interpolation for slightly faster 
             smoothing. Most be used with the -smooth option. 
-rescale <mode><dimension>
             Rescales the input images as follows:

 -rescale p300   Rescales images to 300% of original size
 -rescale w300   Rescales proportionally to new width 300
 -rescale h300   Rescales proportionally to new height 300
 -rescale f300   Rescales to fit inside a 300 x 300 square. 

Additional notes:

1) We note that EasyBMPtoAVI can automatically detect 
   the number of digits in your frame numbering scheme, 
   i.e., don't worry if you have frame000000.bmp instead.

2) We note that in the third usage scenario, your input image 
   files don't have to be sequentially numbered. For instance, 
   files.txt could look like this:

   Bob.bmp
   BobLooksDumb.bmp
   BobSaysHuh.bmp
   BobSaysStopUsingHimAsAnExample.bmp
   Darn.bmp

3) EasyBMPtoAVI Movie Creator supports filebases that 
   include numbers and symbols. For instance, this is fine:

   Sample001_test1_000.bmp
   Sample001_test1_001.bmp
   Sample001_test1_002.bmp
   Sample001_test1_003.bmp
   Sample001_test1_004.bmp

4) When EasyBMPtoAVI doesn't have enough information 
   to do its job, it will interactively quiz you 
   to fill in the blanks. User-friendly, no? :-)

5) As compiled, EasyBMPtoAVI is compatible with pentium3 
   processors and up. If support for a lower-end processor 
   is required, then you'll need to grab the source and 
   recompile it.
   
6) You can set the copyright bit by using the -copyright 
   flag.

7) This readme may be out of date. For more current information 
   use "EasyBMPtoAVI -help". 
   
