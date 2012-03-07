#
#  EasyBMPtoAVI Movie Createor 
#                                                
#  Author: Paul Macklin                          
#   email: macklin01@users.sourceforge.net       
# support: http://EasyBMPtoAVI.sourceforge.net        
#          file: makefile                
#    date added:   05-19-2006                      
# date modified:   11-12-2006                      
#       version:   0.55                          
#                                                
#   License: BSD (revised/modified)              
# Copyright: 2006 by the EasyBMPtoAVI Project        
#                                                
# description: makefile to compile EasyBMPtoAVI
#

CC = g++
# CC = icc

ARCH = pentium3
# ARCH = pentium4
# ARCH = pentium

EXTRA_OPTIMIZATIONS = -mmmx -msse -mfpmath=sse # pentium3
# EXTRA_OPTIMIZATIONS = -mmmx -msse -msse2 -mfpmath=sse # pentium4
# EXTRA_OPTIMIZATIONS = -mmmx                           # pentium 

# use this line for g++ / mingw on pentium or up

CFLAGS = -O3 -mtune=$(ARCH) -march=$(ARCH) \
 $(EXTRA_OPTIMIZATIONS) -pipe -fomit-frame-pointer -funroll-all-loops -s 

# Use this line for Intel's icc compiler on a pentium 4

# CFLAGS = -axW 

EasyBMPtoAVI: EasyBMP.o EasyBMPtoAVI.o
	$(CC) $(CFLAGS) EasyBMP.o EasyBMPtoAVI.o -o EasyBMPtoAVI
	
EasyBMP.o: EasyBMP.cpp EasyBMP*.h
	$(CC) $(CFLAGS) -c EasyBMP.cpp

EasyBMPtoAVI.o: EasyBMPtoAVI.cpp
	$(CC) $(CFLAGS) -c EasyBMPtoAVI.cpp

clean: 
	rm -f *.o
	rm -f EasyBMPtoAVI EasyBMPtoAVI.exe
