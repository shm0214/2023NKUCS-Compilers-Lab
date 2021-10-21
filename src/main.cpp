#include <iostream>
#include <fstream>
#include <string.h>
#include <unistd.h>
#include "Ast.h"
using namespace std;

Ast ast;
extern FILE *yyin;

int yyparse();

char outfile[256] = "a.out";

int main(int argc, char *argv[])
{
    int opt;
    while ((opt = getopt(argc, argv, "o:")) != -1)
    {
        switch (opt)
        {
        case 'o':
            strcpy(outfile, optarg);
            break;
        default:
            fprintf(stderr, "Usage: %s [-o outfile] infile\n", argv[0]);
            exit(EXIT_FAILURE);
            break;
        }
    }
    if (optind >= argc)
    {
        fprintf(stderr, "no input file\n");
        exit(EXIT_FAILURE);
    }
    if (!(yyin = fopen(argv[optind], "r")))
    {
        fprintf(stderr, "%s: No such file or directory\nno input file\n", argv[optind]);
        exit(EXIT_FAILURE);
    }
    ofstream fout(outfile, ios_base::out);
    if (fout.fail())
    {
        fprintf(stderr, "%s: fail to open output file\n", outfile);
        exit(EXIT_FAILURE);
    }
    yyparse();
    ast.output(fout);
    fout.close();
    return 0;
}
