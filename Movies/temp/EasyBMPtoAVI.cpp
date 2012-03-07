/**************************************************************
*                                                             *
*  EasyBMPtoAVI Movie Creator                                 * 
*                                                             *
*  Author: Paul Macklin                                       *
*   email: macklin01@users.sourceforge.net                    *
*     WWW: http://EasyBMPtoAVI.sourceforge.net                *
*                                                             *
*    file: EasyBMPtoAVI.cpp                                   *
*    date: 5-31-2006                                          *
* version: 0.55                                               *
*                                                             *
*   License:  BSD (modified/revised)                          *
* Copyright:  2006 by the EasyBMPtoAVI Project                *
*                                                             *
* description: Main source code for EasyBMPtoAVI. To compile  *
*              download the EasyBMP library into your project *
*              directory, and compile with the supplied       *
*              makefile. See the project website for Visual   *
*              Studio instructions.                           *
*                                                             *
**************************************************************/

#include <cstdio>
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cctype>
#include <cstring>

using namespace std;

#include "EasyBMP.h"

#ifndef _EasyBMP_Defined_WINGDI
#define ebmpWORD   WORD
#define ebmpDWORD DWORD
#define ebmpBYTE   BYTE 
#endif

#define AVIF_HASINDEX 16
#define AVIF_COPYRIGHTED 131072
#define _EasyBMPtoAVI_Version_ "0.55"

char** FlagsList;
int NumberOfFlags;
int StartFrame;
int EndFrame;

double FrameRate;

int FilenameIncrement;

int NumberOfFrames;
int NumberOfDigitsInFileNames; 
int BitsPerPixel;
char InputFileNameBase [1024];
char OutputFileName [1024];
char FileList [1024]; 
char** ListOfInputFiles;
bool SetCopyrightBit;
bool UseBigEndian;
int Width;
int Height;
int SmoothingFactor;

bool RescaleOn;
char RescaleMode;
int RescaleSize;

bool InterpolateFrames( BMP& Input1, BMP& Input2 ,int Iteration, int SmoothingFactor , BMP* Output );
bool InterleaveFrames( BMP& Input1, BMP& Input2 , int Iteration, int SmoothingFactor , BMP* Output );

bool (*InterpolationFunction)(BMP&,BMP&,int,int,BMP*);

int  DetermineFrameDataSize( void );
void InitializeFlagsList( void );
int  CheckAgainstFlags( char* Input );
bool HandleFlag( int FlagNumber, char* Input );
void ResetGlobals( void );
void DetermineNumberOfDigitsInInputFiles( void );
void DisplayHelp( void );
void WriteString( char* input, FILE* fp );
void WriteDWORD( ebmpDWORD input, FILE* fp );
void WriteWORD( ebmpWORD input, FILE* fp );
void WriteChunk( char name[4], char* input, int length, FILE* fp );
void WriteAVIH( FILE* fp );
void WriteBMIH( FILE* fp );
void WriteSTRH( FILE* fp );
void WriteAVIH( FILE* fp );

void WriteFrame( BMP& Input, ebmpDWORD ImageSize, FILE* fp );
void DisplayProgress( int StartFrame, int CurrentFrame, int EndFrame );
void CreateFilename( char* base, int Number, int NumberOfPlaces, char* OutputBuffer );

size_t WriteBufferToFile( char* Buffer, int BufferLength, FILE* fp );
size_t ReadFileToBuffer( char* Buffer, int BufferLength, FILE* fp );
bool   InvertBufferOrder( char* Buffer, int BufferLength );

int main( int argc, char* argv[] )
{
 char* DATE = "November 12";
 char* YEAR = "2006";
 char* AUTHOR = "Paul Macklin";
 char* LICENSE = "BSD (revised/modified)";
 char* CONTACT = "http://EasyBMPtoAVI.sourceforge.net";
 char* GROUP = "the EasyBMPtoAVI Project";

 char* temp;
 
 // spit out copyright / license information
 cout  << endl << "EasyBMPtoAVI Movie Creator Version " << _EasyBMPtoAVI_Version_ << ": " << endl
       << "========================================" << endl << endl
       << " Created on " << DATE << ", " << YEAR << " by " << AUTHOR << "." << endl
       << " Licensed under " << LICENSE << " by " << GROUP << "." << endl
       << " Contact: " << CONTACT << endl << endl 
	   << " For help, type EasyBMPtoAVI -help " << endl << endl
       << " Uses the EasyBMP library, Version " << _EasyBMP_Version_ << "." 
	   << endl << endl;
	   
 InitializeFlagsList();	   
 ResetGlobals();
 UseBigEndian = IsBigEndian();
 
 int i,j,k;
 i=0;
 while( i < argc )
 {
  j = CheckAgainstFlags( argv[i] ); 
  bool Done = false;
  if( j == -1 )
  { Done = true; }
  if( j == 0 || j == 7 )
  {
   HandleFlag( j, " " ); 
   Done = true;
  }
  if( !Done )
  { i++; HandleFlag( j , argv[i] ); }
  else
  
  i++;
 }
 
 // check to see if any information is missing
 
 if( StartFrame == -1 && strlen( FileList ) == 0 )
 { 
  cout << "Input first frame number: ";
  char TempBuffer [1024];
  cin >> TempBuffer;
  StartFrame = (int) strtod( TempBuffer, NULL );
 }
 if( EndFrame == -1 && strlen( FileList ) == 0 )
 { 
  cout << "Input last frame number: ";
  char TempBuffer [1024];
  cin >> TempBuffer;
  EndFrame = (int) strtod( TempBuffer, NULL );
 }
 NumberOfFrames = 0;
 int TemporaryFilenameCounter = StartFrame;
 while( TemporaryFilenameCounter <= EndFrame )
 {
  NumberOfFrames += 1;
  TemporaryFilenameCounter += FilenameIncrement;
 }
 if( strlen( InputFileNameBase ) == 0 &&
     strlen( FileList ) == 0 ) 
 {
  cout << "Input input filename base (e.g., frame for files like frame000.bmp): ";
  cin >> InputFileNameBase; 
 }
 if( FrameRate < 0 )
 {
  cout << "Input frame rate: ";
  char TempBuffer [1024];
  cin >> TempBuffer;
  FrameRate = strtod( TempBuffer, NULL );
 }
 if( strlen( OutputFileName ) == 0 )
 {
  cout << "Input output movie filename (e.g., output.avi): ";
  cin >> OutputFileName; 
 }
 // create the list of input files
 if( strlen( InputFileNameBase ) > 0 )
 {
  FileList[0] = '\0';
  ListOfInputFiles = new char* [NumberOfFrames];
  DetermineNumberOfDigitsInInputFiles();
  for( k=0 ; k < NumberOfFrames ; k++ )
  {
   ListOfInputFiles[k] = new char[ (int) strlen(InputFileNameBase)+5 
                                    + NumberOfDigitsInFileNames ];
   CreateFilename( InputFileNameBase, StartFrame+k*FilenameIncrement, 
                   NumberOfDigitsInFileNames, ListOfInputFiles[k] );
  }
 }
 if( strlen( FileList ) > 0 )
 {
  InputFileNameBase[0] = '\0';
  // count the number of entries
  NumberOfFrames = 0;
  ifstream FileListBuffer( FileList, ios::in );  
  while( !FileListBuffer.eof() )
  {
   char InputBuffer [1024];
   InputBuffer[0] = '\0';
   FileListBuffer >> InputBuffer;
   if( strlen( InputBuffer ) > 0 )
   { NumberOfFrames++; }
  }
  FileListBuffer.close();

  StartFrame = 1;
  EndFrame = NumberOfFrames;

  ListOfInputFiles = new char* [NumberOfFrames];

  ifstream FileListBuffer2( FileList, ios::in );
  for( k=0 ; k < NumberOfFrames ; k++ )
  {
   char InputBuffer [1024];
   InputBuffer[0] = '\0';
   FileListBuffer2 >> InputBuffer;
   ListOfInputFiles[k] = new char [ (int) strlen(InputBuffer) + 1 ];
   strcpy( ListOfInputFiles[k] , InputBuffer );
  }
  FileListBuffer2.close();
 }

 BMP TempFrame;
 TempFrame.ReadFromFile( ListOfInputFiles[0] );
 
 // adjust the framerate and number of frames according 
 // to the smoothing factor
 
 FrameRate *= SmoothingFactor;
 
 cout << endl << "Summary of options: " << endl
      << "=================== " << endl;
 if( SmoothingFactor > 1 )
 {
  cout << "Number of frames  : " << SmoothingFactor*(NumberOfFrames-1)+1 
       << " (includes smoothing factor)" << endl;
 } 
 else
 {
  cout << "Number of frames  : " << SmoothingFactor*(NumberOfFrames-1)+1 << endl; 
 }
 if( strlen( FileList ) == 0 )	  
 {
  cout << "First frame number: " << StartFrame << endl
	   << "Last  frame number: " << EndFrame << endl;
 }	   
 if( SmoothingFactor > 1 )
 {
  cout << "Frame rate (FPS)  : " << FrameRate << " (includes smoothing factor)" << endl;
 }
 else
 {
  cout << "Frame rate (FPS)  : " << FrameRate << endl;
 }
 cout << "Typical filename  : " << ListOfInputFiles[0] << endl
	  << "Output filename   : " << OutputFileName << endl << endl;

 cout << "Copyright bit     : ";
 if( SetCopyrightBit )
 { cout << "TRUE" << endl; }
 else
 { cout << "FALSE" << endl;}
 cout << "Smoothing Factor  : ";
 if( SmoothingFactor > 1 )
 { cout << SmoothingFactor << endl; }
 else
 { cout << "OFF" << endl;}
 cout << "Interleaving      : ";
 if( SmoothingFactor > 1 && InterpolationFunction == InterleaveFrames )
 { cout << "TRUE" << endl << endl; }
 else
 { cout << "FALSE" << endl << endl;}
 
 if( RescaleOn )
 { 
  if( !Rescale( TempFrame , RescaleMode, RescaleSize ) )
  { RescaleOn = false; cout << endl; }
 }
	  
 Width     = TempFrame.TellWidth();
 Height    = TempFrame.TellHeight();

 BitsPerPixel  = 24;
 if( BitsPerPixel != 24 )
 { BitsPerPixel = 24; }
 
 int FrameNumber = StartFrame;

 //
 // Determine the sizes of the individual pieces
 //

 ebmpDWORD IndexSize = (SmoothingFactor*(NumberOfFrames-1)+1)*16; // should be correct
 ebmpDWORD MoviSize = 4+(SmoothingFactor*(NumberOfFrames-1)+1)*( DetermineFrameDataSize()+8); // need to fill in
 ebmpDWORD SecondListSize = 4+64+48; // should be correct for strh and strf only 
 ebmpDWORD FirstListSize = (4+64) + (8+SecondListSize); // should be correct
 ebmpDWORD FileSize = 8+(8+IndexSize) + (8+FirstListSize) + (4+MoviSize);

 // ensure that we don't hit the 2 GB barrier!
 
 unsigned int MaxFileSize = 2048; // MB
 long double OutputSize = FileSize / (1024.0*1024.0); // MB
 if( OutputSize > MaxFileSize )
 {
  cout << "Error: Maximum supported file size is 2 GB." << endl
       << "       Aborting operation ... " << endl << endl;
  exit(-1);
 }
 
 cout.precision(5);
 cout << "Movie width       : " << Width << endl
      << "Movie height      : " << Height << endl
	  << "Projected output file size: " << ((FileSize+0.0)/( 1024.0*1024.0)) << " MB" << endl << endl;

 // 
 // write the main header information
 //

 FILE* fp = fopen( OutputFileName , "wb" ); 
 if( !fp )
 {
  cout << "Error: Could not open file " << OutputFileName << " for output." << endl
       << "       Aborting operation ... " << endl << endl;
  exit(-1);
 }
 
 WriteString( "RIFF" , fp );
 WriteDWORD( FileSize, fp );
 WriteString( "AVI ", fp );
 WriteString( "LIST", fp );
 WriteDWORD( FirstListSize, fp ); 
 WriteString( "hdrl" , fp );
 WriteString( "avih", fp );
 WriteDWORD( 56, fp );
 WriteAVIH( fp );
 
 //
 // write the various headers 
 //
 
 WriteString( "LIST", fp );
 WriteDWORD( SecondListSize, fp );
 WriteString("strl", fp );
 WriteSTRH( fp );
 WriteString( "strf" , fp );
 WriteDWORD( 40 , fp );
 WriteBMIH( fp );
 
 //
 // write the frames section of the file
 //
 
 cout << "Writing movie frames ... ";
 
 WriteString( "LIST" , fp );
 WriteDWORD( MoviSize, fp );
 WriteString( "movi" , fp );
 cout << endl;
 
 int FrameSize = DetermineFrameDataSize();
 FrameNumber = 0;
 while( FrameNumber < NumberOfFrames )
 {
  DisplayProgress( 0, FrameNumber, NumberOfFrames-1 );
 
  BMP Frame0;
  Frame0.ReadFromFile( ListOfInputFiles[FrameNumber] );
  if( RescaleOn )
  { Rescale( Frame0 , RescaleMode, RescaleSize ); }
 
  BMP Frame1;
  if( SmoothingFactor > 1 && FrameNumber < NumberOfFrames-1 )
  {
   Frame1.ReadFromFile( ListOfInputFiles[FrameNumber+1] );
   if( RescaleOn )
   { Rescale( Frame1 , RescaleMode, RescaleSize ); }

   BMP Output;
   Output.SetSize( Frame0.TellWidth() , Frame0.TellHeight() );
   
   for( int Interp = 0 ; Interp < SmoothingFactor ; Interp++ )
   {
    InterpolationFunction( Frame0, Frame1,Interp,SmoothingFactor, &Output );
	WriteFrame( Output, FrameSize, fp );
   }
  }  
  else
  {
   WriteFrame( Frame0, FrameSize, fp ); 
  }
  FrameNumber++;
 }
 cout << " ......... done!" << endl << endl;
  
 //
 // write the index section of the file 
 //
 
 WriteString( "idx1" , fp );
 WriteDWORD( IndexSize, fp );
 int ChunkOffset = 4;
 
 cout << "Writing frame index ... " << endl;
 
 
 
 for( FrameNumber = 1 ; FrameNumber <= SmoothingFactor*(NumberOfFrames-1)+1 ; FrameNumber++ )
 { 
  DisplayProgress( 1,FrameNumber, SmoothingFactor*(NumberOfFrames-1)+1 );
 
  // This is to prevent appending an extra index frame to the end
  if( FrameNumber == EndFrame && 1 == 0 )
  { SmoothingFactor = 1; }
  
  for( int Interp = 0 ; Interp < SmoothingFactor ; Interp++ )
  {
   WriteString( "00db" , fp );
   WriteDWORD( 16, fp ); // keyframe
   WriteDWORD( ChunkOffset , fp );
   ChunkOffset += FrameSize+8; 
   WriteDWORD( FrameSize, fp );
  }
  
 }
 cout << " ......... done!" << endl << endl;

 cout << "Writing file ...";
 fclose( fp );
 cout << "......... done!" << endl << endl;
}

void WriteString( char* input, FILE* fp )
{ fwrite( input, 1, strlen(input), fp ); }

void WriteDWORD( ebmpDWORD input, FILE* fp )
{
 if( !UseBigEndian )
 {
  fwrite( (char*) &input, 1, 4, fp ); 
  return; 
 }
 ebmpDWORD TempDWORD = FlipDWORD( input );
 fwrite( (char*) &TempDWORD, 1, 4, fp );
}

void WriteWORD( ebmpWORD input, FILE* fp )
{
 if( !UseBigEndian )
 {
  fwrite( (char*) &input, 1, 2, fp ); 
  return;
 }
 ebmpWORD TempWORD = FlipWORD( input );
 fwrite( (char*) &TempWORD, 1, 2, fp ); 
}

void WriteChunk( char name[4], char* input, int length, FILE* fp )
{
 fwrite( name, 1, 4 , fp );
 ebmpDWORD size = (ebmpDWORD) length;
 WriteDWORD( size, fp );
 if( !UseBigEndian )
 {
  fwrite( input, 1, length, fp );
  return;
 }
 char* TempBuffer;
 TempBuffer = new char [length];
 strncpy( TempBuffer, input, length );
 InvertBufferOrder( TempBuffer, length );
 fwrite( TempBuffer, 1, length, fp );
}

void WriteBMIH( FILE* fp )
{
 if( BitsPerPixel != 24 )
 { BitsPerPixel = 24; }
 
 ebmpDWORD biSize          = 40;
 ebmpDWORD biWidth         = Width;
 ebmpDWORD biHeight        = Height;
 ebmpWORD  biPlanes        = 1;
 ebmpWORD  biBitCount      = BitsPerPixel;
 ebmpDWORD biCompression   = 0;
 ebmpDWORD biSizeImage     = (ebmpDWORD) DetermineFrameDataSize();
 ebmpDWORD biXPelsPerMeter = DefaultXPelsPerMeter;
 ebmpDWORD biYPelsPerMeter = DefaultYPelsPerMeter;
 ebmpDWORD biClrUsed       = 0;
 ebmpDWORD biClrImportant  = 0; 

 // fix default biSize in BMIH in EasyBMP!

 WriteDWORD( biSize, fp );
 WriteDWORD( biWidth, fp );
 WriteDWORD( biHeight, fp );
 WriteWORD(  biPlanes, fp );
 WriteWORD(  biBitCount, fp );
 WriteDWORD( biCompression, fp );
 WriteDWORD( biSizeImage, fp );
 WriteDWORD( biXPelsPerMeter, fp );
 WriteDWORD( biYPelsPerMeter, fp );
 WriteDWORD( biClrUsed , fp );
 WriteDWORD( biClrImportant, fp );
 
 return;
}

void WriteFrame( BMP& Input, ebmpDWORD ImageSize, FILE* fp )
{
 WriteString( "00db", fp );
 WriteDWORD( ImageSize, fp );
  
 int i,j,k;

 int BytesPerRow = ImageSize / Input.TellHeight();

 char* LineBuffer;
 LineBuffer = new char [BytesPerRow];
 
 for( j=Input.TellHeight()-1; j > -1 ; j-- )
 {
  LineBuffer[0] = '\0';
  k=0;
  for( i=0 ; i < Input.TellWidth() ; i++ )
  {
   *(LineBuffer+k) = ( Input(i,j)->Blue );  k++;
   *(LineBuffer+k) = ( Input(i,j)->Green ); k++;
   *(LineBuffer+k) = ( Input(i,j)->Red );   k++;
  }
  WriteBufferToFile( LineBuffer, BytesPerRow, fp );
 }
 return;
}

void WriteSTRH( FILE* fp )
{
 WriteString("strh", fp );
 WriteDWORD(56, fp);
 WriteString("vids", fp );
 WriteString("DIB ", fp ); 
 WriteDWORD(0, fp ); // flags
 WriteDWORD(0, fp ); // priority
 WriteDWORD(0, fp ); // initial frames
 ebmpDWORD dwMicroSecPerFrame = (ebmpDWORD) ( 1000000.0 / FrameRate );
 WriteDWORD( dwMicroSecPerFrame, fp ); // dwScale
 WriteDWORD( 1000000, fp ); // dwRate
 WriteDWORD(0, fp ); // dwStart
 WriteDWORD( NumberOfFrames, fp ); // dwLength
 ebmpDWORD dwSuggestedBufferSize  = (ebmpDWORD) DetermineFrameDataSize();
 WriteDWORD( dwSuggestedBufferSize , fp ); // dwSuggestedBufferSize
 WriteDWORD(0, fp ); // dwQuality
 WriteDWORD(0, fp ); // dwSampleSize 
 WriteDWORD(0, fp );
 WriteWORD( Width , fp );
 WriteWORD( Height, fp );
}

void DisplayProgress( int StartFrame, int CurrentFrame, int EndFrame )
{
 char DisplayText [1024];
 double Percent = 100.0*(CurrentFrame-StartFrame+0.0) / (EndFrame-StartFrame+0.0);
 sprintf( DisplayText, "Progress: %-3.1f%%", Percent );
 
 if( CurrentFrame > StartFrame )
 { 
  cout   << "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b";
 };
 cout << DisplayText; 
}

void CreateFilename( char* base, int Number, int NumberOfPlaces, char* OutputBuffer )
{ 
 char Instruction [1024];
 sprintf( Instruction, "%s%%0%ii.bmp" , base, NumberOfPlaces ); 
 sprintf( OutputBuffer, Instruction, Number );
 return;
}

void InitializeFlagsList( void )
{
 NumberOfFlags = 12;
 FlagsList = new char* [NumberOfFlags];
 
 FlagsList[0] = "help";
 FlagsList[1] = "framerate";
 FlagsList[2] = "start";
 FlagsList[3] = "end";
 FlagsList[4] = "filebase";
 FlagsList[5] = "output";
 FlagsList[6] = "filelist";
 FlagsList[7] = "copyright";
 FlagsList[8] = "smooth";
 FlagsList[9] = "interleave";
 
 FlagsList[10] = "increment";
 FlagsList[11] = "rescale";

 return;
}

int CheckAgainstFlags( char* Input )
{
 int i=0;
 if( Input[0] != '-' )
 { return -1; }
 while( i < NumberOfFlags )
 {
  int j=0;
  bool IsAMatch = true;
  while( j < strlen( Input ) && j < strlen( FlagsList[i] ) )
  { if( Input[j+1] != FlagsList[i][j] ){ IsAMatch = false; } j++; }  
  if( strlen( Input ) != strlen( FlagsList[i] ) + 1 )
  { IsAMatch = false; }
  if( IsAMatch == true )
  { return i; }
  i++;
 }

 return -1;
}

bool HandleFlag( int FlagNumber, char* Input )
{
 if( FlagNumber >= NumberOfFlags || FlagNumber < 0 )
 { return false; }
 
 if( FlagNumber == 0 )
 { DisplayHelp(); return true; }
 if( FlagNumber == 1 )
 { FrameRate = strtod( Input , NULL ); }
 if( FlagNumber == 2 )
 { 
  if( !isdigit( Input[0] ) )
  { 
   int i= (int) strlen(Input)-5;
   bool SearchDone = false;
   // find the end of the file base
   while( i > -1 && !SearchDone )
   {
    if( isdigit(Input[i]) )
    { i--; }
    else
    { SearchDone = true; }
   }
   // copy the file base
   int j=0;
   while( j <= i )
   { InputFileNameBase[j] = Input[j]; j++; }
   InputFileNameBase[j] = '\0'; 
   // get the first and last frame numbers 
   j=0;
   while( j <= i )
   { Input[j] = ' '; j++; }
   StartFrame = (int) strtod( Input , NULL );
  }
  else
  { StartFrame = (int) strtod( Input , NULL ); }
  return true;
 }
 if( FlagNumber == 3 )
 { 
  if( !isdigit( Input[0] ) )
  { 
   int i= (int) strlen(Input)-5;
   bool SearchDone = false;
   // find the end of the file base
   while( i > -1 && !SearchDone )
   {
    if( isdigit(Input[i]) )
    { i--; }
    else
    { SearchDone = true; }
   }
   // copy the file base
   int j=0;
   while( j <= i )
   { InputFileNameBase[j] = Input[j]; j++; }
   InputFileNameBase[j] = '\0'; 
   // get the first and last frame numbers 
   j=0;
   while( j <= i )
   { Input[j] = ' '; j++; }
   EndFrame = (int) strtod( Input , NULL );
  }
  else
  { EndFrame = (int) strtod( Input , NULL ); }
  return true;
 }
 if( FlagNumber == 4 )
 { InputFileNameBase[0] = '\0'; strcpy( InputFileNameBase , Input ); return true; }
 if( FlagNumber == 5 )
 { OutputFileName[0] = '\0'; strcpy( OutputFileName, Input ); return true; }
 if( FlagNumber == 6 )
 { FileList[0] = '\0'; strcpy( FileList, Input ); return true; }
 if( FlagNumber == 7 )
 {
  SetCopyrightBit = true; 
  cout << endl << "Notice: Copyright bit will be set in output file." << endl; 
  return true;
 }
 if( FlagNumber == 8 )
 {
  SmoothingFactor = (int) strtod( Input, NULL ); 
  if( SmoothingFactor < 1 ) 
  { SmoothingFactor = 1; }
  return true;
 }
 if( FlagNumber == 9 )
 {
  InterpolationFunction = InterleaveFrames;
  cout << endl << "Notice: Using experimental frame interleaving " 
               << "instead of interpolation." << endl; 
  return true;
 }
 if( FlagNumber == 10 )
 { 
  FilenameIncrement = (int) strtod( Input, NULL ); 
  if( FilenameIncrement < 1 ) 
  { FilenameIncrement = 1; }
  return true;
 }
 if( FlagNumber == 11 )
 {
  RescaleOn = true;
  RescaleMode = Input[0];
  Input[0] = ' ';
  RescaleSize = (int) strtod( Input , NULL );
  return true; 
 }
 

 return true;
}

void DisplayHelp( void )
{
 cout << endl << "EasyBMPtoAVI Help:" << endl
              << "=================" << endl
 << "Usage scenario 1: " << endl
 << "----------------" << endl
 << "Convert frame000.bmp ... frame123.bmp to out.avi at framerate 13 fps: " << endl
 << "EasyBMPtoAVI -filebase frame -start 0 -end 123 -framerate 13 -output out.avi" << endl
 << endl
 << "Usage scenario 2: " << endl
 << "----------------" << endl
 << "Convert frame00.bmp ... frame13.bmp to out.avi at framerate 13 fps: " << endl
 << "EasyBMPtoAVI -start frame00.bmp -end frame13.bmp -framerate 13 -output out.avi" << endl
 << endl
 << "Usage scenario 3: " << endl
 << "----------------" << endl
 << "Convert files listed in FileList.txt to out.avi at framerate 13 fps: " << endl
 << "EasyBMPtoAVI -filelist FileList.txt -framerate 13 -output out.avi" << endl
 << endl
 << "Additional flags:" << endl
 << "----------------" << endl
 << "-increment N Assumes the filenames increment by N instead of 1" << endl
 << "-copyright   Set the copyright bit in the output file" << endl
 << "-smooth N    Smooth the output (temporally) by a factor of N" << endl
 << "-interleave  Smooth by interleaving the frames instead. This should " << endl
 << "             be faster than interpolation. Must be used with the " << endl
 << "             -smooth flag." << endl
 << "-rescale <mode><size>" << endl
 << "             Resizes the input images as follows:" << endl
 << "             -rescale p300    Rescales images to 300% of original size" << endl
 << "             -rescale w300    Rescales proportionally to new width 300" << endl
 << "             -rescale h300    Rescales proportionally to new height 300" << endl
 << "             -rescale f300    Rescales to fit inside a 300 x 300 square." << endl 
 << "-help        Access this help screen" << endl << endl;

 exit(-1);
}

void ResetGlobals( void )
{
 StartFrame = -1;
 EndFrame = -1;
 FrameRate = -1;
 NumberOfDigitsInFileNames = -1;
 SetCopyrightBit = false;
 
 FilenameIncrement = 1;
 
 InputFileNameBase[0] = '\0';
 OutputFileName[0] = '\0';
 FileList[0] = '\0';
 ListOfInputFiles = NULL;
 
 InterpolationFunction = InterpolateFrames;
 
 SmoothingFactor = 1;
 
 RescaleOn = false;
 RescaleMode = 'P';
 RescaleSize = 100;
 
 return; 
}

void DetermineNumberOfDigitsInInputFiles( void )
{
 FILE* fpTemp = NULL;
 while( !fpTemp && NumberOfDigitsInFileNames < 500 )
 {
  NumberOfDigitsInFileNames++;
  char TempFileNameBuffer [1024];
  CreateFilename( InputFileNameBase, StartFrame, NumberOfDigitsInFileNames, TempFileNameBuffer );
  fpTemp = fopen( TempFileNameBuffer , "rb" );
 }
 if( NumberOfDigitsInFileNames == 500 )
 {
  cout << "Error: Cannot find any such file " << InputFileNameBase 
       << StartFrame << ".bmp." << endl
	   << "       Be sure to double-check that you gave the correct" << endl
	   << "       range of files, file base, etc.!" << endl << endl;
  exit(-2);
  return; 
 }
 fclose( fpTemp );
}

size_t WriteBufferToFile( char* Buffer, int BufferLength, FILE* fp )
{ return fwrite( Buffer, 1, BufferLength, fp ); }
size_t ReadFileToBuffer( char* Buffer, int BufferLength, FILE* fp )
{ return  fread( Buffer, 1, BufferLength, fp ); }
bool InvertBufferOrder( char* Buffer, int BufferLength )
{
 int k;
 for( k=0 ; k < BufferLength/2 ; k++ )
 {
  int j = BufferLength - k - 1;
  char Temp = Buffer[k];
  Buffer[k] = Buffer[j];
  Buffer[j] = Temp;
 }
 return true;
}

void WriteAVIH( FILE* fp )
{
 ebmpDWORD dwMicroSecPerFrame = (ebmpDWORD) ( 1000000.0 / (double) FrameRate );
 ebmpDWORD dwMaxBytesPerSec   = 0;
 ebmpDWORD dwReserved1        = 0;
 ebmpDWORD dwFlags            = AVIF_HASINDEX;
 if( SetCopyrightBit )
 { dwFlags = AVIF_COPYRIGHTED | dwFlags; } 
 ebmpDWORD dwTotalFrames      = NumberOfFrames;
 ebmpDWORD dwInitialFrames    = 0;
 ebmpDWORD dwStreams          = 1; // video only 
 ebmpDWORD dwSuggestedBufferSize = (ebmpDWORD) DetermineFrameDataSize();
 ebmpDWORD dwWidth            = Width;
 ebmpDWORD dwHeight           = Height;
 ebmpDWORD dwScale            = 0;
 ebmpDWORD dwRate             = 0;
 ebmpDWORD dwStart            = 0;
 ebmpDWORD dwLength           = 0;

 WriteDWORD( dwMicroSecPerFrame , fp );
 WriteDWORD( dwMaxBytesPerSec , fp );
 WriteDWORD( dwReserved1 , fp );
 WriteDWORD( dwFlags , fp );
 WriteDWORD( dwTotalFrames , fp );
 WriteDWORD( dwInitialFrames , fp );
 WriteDWORD( dwStreams , fp );
 WriteDWORD( dwSuggestedBufferSize , fp );
 WriteDWORD( dwWidth , fp );
 WriteDWORD( dwHeight , fp );
 WriteDWORD( dwScale , fp );
 WriteDWORD( dwRate , fp );
 WriteDWORD( dwStart , fp );
 WriteDWORD( dwLength , fp ); 
}

int DetermineFrameDataSize( void )
{
 int BytesPerRow = (int) ( Width*BitsPerPixel / 8.0 );
 while( BytesPerRow % 4 )
 { BytesPerRow++; }
 return BytesPerRow*Height;
}

bool InterpolateFrames( BMP& Input1, BMP& Input2 , int Iteration, int SmoothingFactor , BMP* Output )
{
 double t = (double) Iteration / (double) SmoothingFactor;

 for( int j=0 ; j < Output->TellHeight() ; j++ )
 {
  for( int i=0 ; i < Output->TellWidth() ; i++ )
  {
   (*Output)(i,j)->Red = (ebmpBYTE) ( (1.0-t)* Input1(i,j)->Red + t * Input2(i,j)->Red );
   (*Output)(i,j)->Green = (ebmpBYTE) ( (1.0-t)* Input1(i,j)->Green + t * Input2(i,j)->Green );
   (*Output)(i,j)->Blue = (ebmpBYTE) ( (1.0-t)* Input1(i,j)->Blue + t * Input2(i,j)->Blue );
  }
 }

 return true;
}

bool InterleaveFrames( BMP& Input1, BMP& Input2 , int Iteration, int SmoothingFactor , BMP* Output )
{
 for( int j=0 ; j < Output->TellHeight() ; j++ )
 {
  for( int i=0 ; i < Output->TellWidth() ; i++ )
  {
   if( j % SmoothingFactor >= Iteration )
   { *(*Output)(i,j) = *Input1(i,j); }
   else
   { *(*Output)(i,j) = *Input2(i,j); }
  }
 }

 return true;
}
