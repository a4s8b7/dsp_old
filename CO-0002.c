/* counter-output.c -Jason's header placed into Andy's file */
/* VER 00.00.03	LAST UPDATE= 11-25-2001  */

#include <stdio.h>
#include <stdlib.h> /* for exit() */

#define MAX 92

int main() /* declaired as integer, must return a value */
{    /* 1 open: start main */
    int win[12], i=0, r=0;
    char buffer[MAX], pg[12][12], t_data[7], intro[MAX], t_end[9],
outro[23], ch;
FILE *stream, *handle;

stream=fopen("counters.dat", "r");
if(!stream) exit(1); /* if stream doesn't exist */
else { /* 2 open: start 1st if */

  handle = fopen("Counter_Report.htm", "w");
    if(!handle) { /* 3 open: start 2nd if */
    
    sprintf(buffer, "error 406, Data input file not
found");
              fwrite(buffer, sizeof(buffer), 1, handle);
              exit(EXIT_FAILURE);  /* end the program */
          } /* 2 open: end 2nd if */
          else { /* 3 open: start else */
      while(i<12) { /* 4 open: start while */
      pg[i][0]='\0'; /* 1st charactor of the
array equals end of line */
      i++;
      } /* 3 open: end while */
  } /* 2 open: end else  */
  if((fgets(pg[1], sizeof(char), stream))==NULL) { /* 3
open: if */
         perror("Unable to read from file counters.dat");
              exit(EXIT_FAILURE);
          }         /* 2 open: end if */
          else { /* 3 open: else */
          i=0;           
          while(i<12) {       /* 4 open: while */
          ch=getc(stream); /* gets one char at a time
from *stream */
          if(ch!='\n') {  /* 5 open: if ch */ /* if that
char is not equal to hard return *new line* */
          pg[i][r]=ch; /* pass the value off to a
specific char possition *r* in current array *i* */
          r++;
          }   /* 4 open: end if
ch */
          else {   /* 5 open: else   ch */
              pg[i][r]='\0'; /* add End of Line comment
to the end of the Array */
              /* debug: show us the info */
              /* printf("%i:%s\n", i, pg[i]); */
              i++;
              r=0;
              } /* 4 open: end else ch */
          } /* 3 open: end
while */

          }          /* 2 open: end if */
  sprintf(t_data, "<tr><td>");
  sprintf(t_end, "</td></tr>");
  sprintf(intro, "<HTML><HEAD><TITLE>Counter Report</TITLE><BODY><P align=center>");
  fwrite(intro, 63, 1, handle);
  sprintf(intro, "<table border=0 cellspacing=0 cellpadding=0>\n");
  fwrite(intro, 45, 1, handle);
  sprintf(buffer, "%s<font size=2>Counter 1: %s%s%s<font size=2>Counter 2: %s%s\n", t_data, pg[0], t_end, t_data, pg[1], t_end);
  fwrite(buffer, 87, 1, handle);
  sprintf(buffer, "%s<font size=2>Counter 3: %s%s%s<font size=2>Counter 4: %s%s\n", t_data, pg[2], t_end, t_data, pg[3], t_end);
  fwrite(buffer, 87, 1, handle);
  sprintf(buffer, "%s<font size=2>Counter 5: %s%s%s<font size=2>Counter 6: %s%s\n", t_data, pg[4], t_end, t_data, pg[5], t_end);
  fwrite(buffer, 88, 1, handle);
  sprintf(buffer, "%s<font size=2>Counter 7: %s%s%s<font size=2>Counter 8: %s%s\n", t_data, pg[6], t_end, t_data, pg[7], t_end);
  fwrite(buffer, 87, 1, handle);
  sprintf(buffer, "%s<font size=2>Counter 9: %s%s%s<font size=2>Counter 10: %s%s\n", t_data, pg[8], t_end, t_data, pg[9], t_end);
  fwrite(buffer, 88, 1, handle);
  sprintf(buffer, "%s<font size=2>Counter 11: %s%s%s<font size=2>Counter 12: %s%s\n", t_data, pg[10], t_end, t_data, pg[11], t_end);

  fwrite(buffer, 89, 1, handle);       
  sprintf(outro, "</P></table></BODY></HTML>");
  fwrite(outro, 26, 1, handle);

/* oooooooooooooooooooooooooooooo Find highest value oooooooooooooooooooooooooooooooo */
/* oooooooooooooooooooooooooooooooooooo round one ooooooooooooooooooooooooooooooooooo */
{
if(pg[1] > pg[2]) win[1] = pg[1];
             else win[1] = pg[2];  

if(pg[3] > pg[4]) win[2] = pg[3];
             else win[2] = pg[4];  

if(pg[5] > pg[6]) win[3] = pg[5];
             else win[3] = pg[6]; 

if(pg[7] > pg[8]) win[4] = pg[7];
             else win[4] = pg[8]; 

if(pg[9] > pg[10]) win[5] = pg[9];
              else win[5] = pg[10]; 

if(pg[11] > pg[12]) win[6] = pg[11];
               else win[6] = pg[12];

/* ooooooooooooooooooooooooooooooooo round two oooooooooooooooooooooooooooooooooooo */
if(win[1] > win[2]) win[7] = win[1];
               else win[7] = win[2]; 

if(win[3] > win[4]) win[8] = win[3];
               else win[8] = win[4]; 

if(win[5] > win[6]) win[9] = win[5];
               else win[9] = win[6]; 
/* ooooooooooooooooooooooooooooooooo round three oooooooooooooooooooooooooooooooooooo */
if(win[7] > win[8]) win[10] = win[7];
               else win[10] = win[8]; 

if(win[9] > win[10]) win[11] = win[9];
               else win[11] = win[10]; 

return 0;
}

sprintf(buffer, "%s<font size=2>win[1], win[2], win[3], win[4], win[5], win[6], win[7]);
  fwrite(buffer, 87, 1, handle);

sprintf(buffer, "%s<font size=2>win[8], win[9], win[10], win[11]);
  fwrite(buffer, 87, 1, handle);

highest_value = win(11)
/* oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo */


/* increment_value = highest_value / 10 */

/* ooooooooooooooooooooooooooooooooo Page One Bar Graph ooooooooooooooooooooooooooooooo */

/* ooooooooooooooooooooooooooooooooooooo END oooooooooooooooooooooooooooooooooooooooooooo */
      fclose(handle);
}        /* 1 open: end 1st if */
    fclose(stream);
    
    return 0; /* int main() :declaired as integer, must return a value */
}    /* 0 open: end main */
