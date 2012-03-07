/* counter-output.c -Jason */

#include <stdio.h>

int main()
{    /* 1 open */
    int win[12], pg[12];
FILE *stream, *handle;

if ((stream = fopen("counters.dat", "rt")) == NULL) { /* 2 open */
      if(fopen("counters.dat", "r")==NULL)
  { /* 3 open */

  handle = fopen("Counter_Report.htm", "w");
    if(!handle) printf("error 406, Data output file not
found\n");

/*    fwrite(" error 406, Data input file not found "); */
      fclose(handle); 
          printf("error 406, Data input file not found\n");          
    } /* 2 open */
}      /* 1 open */
    fclose(stream);
    
    return 0;
}    /* 0 open */