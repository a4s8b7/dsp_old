/* 

counter-output.c 
This program contains an error somewhere.  
It prints a bunch of shit that it shouldn't.

You'll see what I mean when you run it! -Jason

 */

#include <stdio.h>
#include <stdlib.h> /* for exit() */

#define MAX 80

int main()
{    /* 1 open: start main */
    int win[12], pg[12], i=0;
    char buffer[MAX];
FILE *stream, *handle;

if ((stream = fopen("counters.dat", "rt")) == NULL) { /* 2 open:
start 1st if */
      if(fopen("counters.dat", "r")==NULL)
  { /* 3 open: start 2nd if */

  handle = fopen("Counter_Report.htm", "w");
    if(!handle) { /* 4 open: start 3rd if */
    
    sprintf(buffer, "error 406, Data input file not
found");
              fwrite(buffer, sizeof(buffer), 1, handle);
              exit(0);  /* end the program */
          } /* 3 open: end 3rd if */
          else { /* 4 open: start else */
      while(i<12) { /* 5open: start while */
      pg[i]=0;
      i++;
      } /* 4 open: end while */
      buffer[0]='\0'; /* null the buffer */
      sprintf(buffer, "<HTML><HEAD><TITLE>Counter
Report</TITLE><BODY><table border=0 celspacing=0 cellpadding=0><tr><td>\n");
      fwrite(buffer, sizeof(buffer), 1, handle);
      sprintf(buffer, "<tr><td><fontsize=2>%i</td></tr><tr><td><font size=2>%i</td></tr>\n", pg[0], pg[1]);
      fwrite(buffer, sizeof(buffer), 1, handle);
      sprintf(buffer, "<tr><td><fontsize=2>%i</td></tr><tr><td><font size=2>%i</td></tr>\n", pg[2], pg[3]);  
      fwrite(buffer, sizeof(buffer), 1, handle);
      sprintf(buffer, "<tr><td><fontsize=2>%i</td></tr><tr><td><font size=2>%i</td></tr>\n", pg[4], pg[5]);
      fwrite(buffer, sizeof(buffer), 1, handle);
      sprintf(buffer, "<tr><td><fontsize=2>%i</td></tr><tr><td><font size=2>%i</td></tr>\n", pg[6], pg[7]);
      fwrite(buffer, sizeof(buffer), 1, handle);
      sprintf(buffer, "<tr><td><fontsize=2>%i</td></tr><tr><td><font size=2>%i</td></tr>\n", pg[8], pg[9]);
      fwrite(buffer, sizeof(buffer), 1, handle);
      sprintf(buffer, "<tr><td><fontsize=2>%i</td></tr><tr><td><font size=2>%i</td></tr>\n", pg[10], pg[11]);
      fwrite(buffer, sizeof(buffer), 1, handle);
      sprintf(buffer, "</table></BODY></HTML>");
      fwrite(buffer, sizeof(buffer), 1, handle);
          fclose(handle);
      } /* 3 open: end else */
    } /* 2 open: end 2nd if */
}        /* 1 open: end 1st if */
    fclose(stream);
    
    return 0;
}    /* 0 open: end main */