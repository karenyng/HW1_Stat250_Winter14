#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*    showLines sample.csv < lines  */

/* Data structure used if we read the line numbers from */
typedef struct {
    unsigned int total;
    unsigned int current;
    char **argv;
} CmdArgs;

typedef struct  {
    FILE *inputFile;
    FILE *rowFile;
    int hasHeader;
    int rowsFromCmdLine;
    CmdArgs args;
} Inputs;


void processCmdArgs(int argc, char *argv[], Inputs *in);
unsigned int getNextRow(Inputs *in);

int
main(int argc, char *argv[])
{
    FILE *f;
    unsigned int currentLine = 0;
    unsigned int nextLine = 0;
    unsigned int i;
    char line[10000];

    Inputs settings = {NULL, NULL, 1, 0};

    /* could use the options library getopt  */
    processCmdArgs(argc, argv, &settings);

    f = settings.inputFile;

    if(settings.hasHeader) {
	fgets(line, sizeof(line)/sizeof(line[0]), f);
	currentLine++;
    }

    while( (nextLine = getNextRow(&settings) ) ) {
	unsigned int jump = nextLine - currentLine;
	for(i = 0; i < jump; i++, currentLine++)
	    fgets(line, sizeof(line)/sizeof(line[0]), f);
	printf("%s", line);
    }
//    fprintf(stderr, "ending at line %d\n", currentLine);
    return(0);
}

unsigned int
getNextRow(Inputs *in)
{
    int status = 0;
    int nextLine = 0;
    if(in->rowFile) {
	status = fscanf(in->rowFile, "%d", &nextLine) != 0;
        return(status != EOF ? nextLine : 0);
    } else {
        if(in->args.current < in->args.total) {
	    nextLine = atoi(in->args.argv[in->args.current++]);
	    return(nextLine);
	} else
	    return(0);
    }
}

/* 
  Want to be able to accept
   showLines sample.csv  < lines
   showLines sample.csv  3 10 100
   showLines -H sample.csv  3 10 100
   showLines -T lines sample.csv 
   showLines -T lines 
   showLines sample.csv  -- 3 10 100
   tail -n +2 sample.csv | showLines -- 3 10 100
   tail -n +2 sample.csv | showLines -T lines
 */

void
processCmdArgs(int argc, char *argv[], Inputs *in)
{
    int i;
    for(i = 1 ; i < argc; i++) {
	if(strcmp(argv[i], "-T") == 0) {
	    in->rowFile = fopen(argv[++i], "r");
	} else if(strcmp(argv[i], "-H") == 0) {
	    in->hasHeader = !in->hasHeader;
	} else if(strcmp(argv[i], "-I") == 0) {
	    in->inputFile = fopen(argv[++i], "r");
	} else 	if(strcmp(argv[i], "--") == 0) {
	    in->rowsFromCmdLine = 1;
	    in->args.total = argc - i - 1;
	    in->args.current = 0;
	    in->args.argv = argv + i + 1;
	    break;
	} else if(argv[i][0] != '-') {
	    if(!in->inputFile) {
		in->inputFile = fopen(argv[i], "r");
		if(!in->inputFile) {
		    fprintf(stderr, "can't open file %s\n", argv[i]);
		    exit(1);
		}
	    } else {
		in->rowsFromCmdLine = 1;
		in->args.total = argc - i;
		in->args.current = 0;
		in->args.argv = argv + i;
		break;
	    }
	}
    }

    if(!in->rowFile && in->rowsFromCmdLine == 0)
	in->rowFile = stdin;
    if(!in->inputFile)
	in->inputFile = stdin;
    if(in->inputFile == stdin && in->rowFile == stdin) {
	fprintf(stderr, "both the row indices and the data are on standard input\n");
	exit(1);
    }
}
