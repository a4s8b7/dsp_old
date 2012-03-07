
/* Dingen Studeos 10-18-2004, By Andrew S. Buczko */
/* this program is to keep track of 12 counters for the Dungen Studeos web Page */

#include <stdio.h>
#include <io.h>

 int main(char *page)
 int counter(1 to 12)

/* oooooooooooooooo LOAD VALUES FROM DATA FILE (start-up) ooooooooooooooooooooo */
}

   /* set var = to Data File name */
   FILE *supercounter.dat;

   /* open Data File and load counters values */
   if ((handle = fopen("supercounter.dat", "r")) == -1)
}
{
   /* if Error then make htm output as (404-not-found.html), using fprint for now */ 
   printf("Error opening file\n");
   exit(1);
}
   {
	for(int ctr=1; ctr < 12;ctr++)
	    {	
		/* load file data into counter array */
		fread(counter(ctr), 12, , handle);
	    }
	do
   }
/* oooooooooooooooooooooooooo CALCULATIONS oooooooooooooooooooooooooooooooooooo */

{

   /*increment the counter that needs to be incremented */

/*	select case "page" */
		case = "1"
			counter(1)++
		case = "2"
			counter(2)++
		case = "3"
			counter(3)++
		case = "4"
			counter(4)++
		case = "5"
			counter(5) = conter(1) + 1
		case = "6"
			counter(6) = conter(1) + 1
		case = "7"
			counter(7) = conter(1) + 1
		case = "8"
			counter(8) = conter(1) + 1
		case = "9"
			counter(9) = conter(1) + 1
		case = "10"
			counter(10) = conter(1) + 1
		case = "11"
			counter(11) = conter(1) + 1
		case = "12"
			counter(12) = conter(1) + 1
	end select

}

/* ooooooooooooooooooooooo RE-WRITE DATA FILE (new values) oooooooooooooooooooo */
{
	/* write the new data to the data file, overwriting the old file */





end