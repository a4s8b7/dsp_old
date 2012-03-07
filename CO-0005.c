/* counter-output.c -Jason's header placed into Andy's file */
/* VER 00.00.04	LAST UPDATE= 12-30-2004  */

#include <stdio.h>
#include <stdlib.h> /* for exit() */

#define MAX 92

int main() /* declaired as integer, must return a value */
{    /* 1 open: start main */
    int win[12], pag[12], i=0, r=0;
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
  if((fgets(pg[1], sizeof(char), stream))!=NULL) { /* 3
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
  } /* 1 open ? */

  fclose(stream);
  fclose(handle);

  stream=fopen("counters.dat", "r");
  if(!stream) exit(1); /* if stream doesn't exist */
  else { 

    i=0;
    while(i<12) {  
      win[i]=0;
      i++;
    }
    i=0;
    while(i<12) {  
      pag[i]=0;
      i++;
    }
 /* Debugging... 

    i=0;
    while(i<12) { 
      printf("%i\n", win[i]);
      i++;
    }

*/
/* Get the values from file */

    i=0;
    while(i<12) {
      fscanf(stream, "%i", &pag[i]);
      i++;
    }


    fclose(stream);

/*  Debugging... */

    i=0;
    while(i<12) {
      printf("%i\n", pag[i]);
      i++;
    }
 
  }  /* from if stream exit */ 

 /*   round one, fight */

  if(pag[0]>pag[1]){
	 win[0] = pag[0];
 	 /* printf("The Winner for match #1 is (%i) \n", win[0]); */
	 }
               else {
		win[0] = pag[1];
		/* printf("The Winner for match #1 is (%i) \n", win[0]); */
		}

  if(pag[2]>pag[3]){
	 win[1] = pag[2];
	 /* printf("The Winner for match #2 is (%i) \n", win[1]); */
	 }
               else {
		win[1] = pag[3]; 
		/* printf("The Winner for match #2 is (%i) \n", win[1]); */
		}

  if(pag[4]>pag[5]){
  	 win[2] = pag[4];
	 /* printf("The Winner for match #3 is 5 (%i) \n", win[2]); */
	 }
               else {
		win[2] = pag[5];
		/* printf("The Winner for match #3 is 6 (%i) \n", win[2]); */
		}

  if(pag[6]>pag[7]){
	 win[3] = pag[6];
	 /* printf("The Winner for match #4 is 7 (%i) \n", win[3]); */
	 }
               else {
		win[3] = pag[7];
		/* printf("The Winner for match #4 is 8 (%i) \n", win[3]); */
		}

  if(pag[8]>pag[9]){
	 win[4] = pag[8];
	 /* printf("The Winner for match #5 is 9 (%i) \n", win[4]); */
	 }
               else {
		win[4] = pag[9];
		/* printf("The Winner for match #5 is 10 (%i) \n", win[4]); */
		}

  if(pag[10]>pag[11]){
	 win[5] = pag[10];
	 /* printf("The Winner for match #6 is 11 (%i) \n", win[5]); */
	 }
               else {
		win[5] = pag[11];
		/* printf("The Winner for match #6 is 12 (%i) \n", win[5]); */
		}

/* end of round one, Starting Round 2 */

  if(win[0]>win[1]){
         win[6] = win[0];
         /* printf("The Winner for match #7 is (%i) \n", win[6]); */
         }
               else {
                win[6] = win[1];
                /* printf("The Winner for match #7 is (%i) \n", win[6]); */
                }

  if(win[2]>win[3]){
         win[7] = win[2];
         /* printf("The Winner for match #8 is (%i) \n", win[7]); */
         }
               else {
                win[7] = win[3];
                /* printf("The Winner for match #8 is (%i) \n", win[7]); */
                }

  if(win[4]>win[5]){
         win[8] = win[4];
         /* printf("The Winner for match #9 is (%i) \n", win[8]); */
         }
               else {
                win[8] = win[5];
                /* printf("The Winner for match #9 is (%i) \n", win[8]); */
                }

/* round three fight */

  if(win[6]>win[7]){
         win[9] = win[6];
         /* printf("The Winner for match #10 is (%i) \n", win[9]); */
         }
               else {
                win[9] = win[7];
                /* printf("The Winner for match #10 is (%i) \n", win[9]); */
                }

if(win[9]>win[8]){
         win[10] = win[9];
         /* printf("The Winner for match #11 is (%i) \n", win[10]); */
         }
               else {
                win[10] = win[8];
                /* printf("The Winner for match #11 is (%i) \n", win[10]); */
                }

/* OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO */
	
	printf(" And the Highest value is (%i) \n", win[10]);

int highest_value = win[10]


  return 0;
} /* zero open, end main */
