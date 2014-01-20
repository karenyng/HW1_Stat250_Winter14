/* 
  This is a reasonably simple program that counts 
  lines which contain single words from a given known set 

 cut -f17 -d, ~/Data/Airline/Airlines/1998.csv | egrep 'LAX|SFO|OAK|SMF' | simpleCounter 
 table(readLines(pipe("cut -f17 -d, ~/Data/Airline/Airlines/1998.csv | egrep 'LAX|SFO|OAK|SMF' ")))

 We have hard-coded the names of the airports, i.e. the contents of the lines.
 We also hard-coded the number of airports.

 How would we make this flexible so that the caller could specify the names
 either on the command line or via a file?

 See testData for a small sample input file.

 */
#include <stdio.h>
#include <string.h>
#include "csvSampler.h"

SEXP
R_csv_sample(SEXP r_filename, SEXP r_rows)
{
    FILE *f;
    char line[100000];
    int i = 1, cur = 0;
    SEXP ans;
    int *rows;

    int last, n;

    f = fopen(CHAR(STRING_ELT(r_filename, 0)), "r");
    if(!f) {
	PROBLEM "cannot open file %s", CHAR(STRING_ELT(r_filename, 0))
	    ERROR;
    }

    rows = INTEGER(r_rows);
    n = LENGTH(r_rows);
    last = rows[n - 1];
    PROTECT(ans = NEW_CHARACTER( n ));

    while(fgets(line, sizeof(line)/sizeof(line[0]), f)) {

        if(i == rows[cur]) {
	    line[strlen(line)] = '\0'; /* kill off the new line */
	    SET_STRING_ELT(ans, cur, mkChar(line));
	    cur++;
	}

	if(i >= last) {
	    break;
	}
	i++;
    }
    UNPROTECT(1);
    fclose(f);

    return(ans);
}

