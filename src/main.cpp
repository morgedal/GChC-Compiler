#include<iostream>
#include<stdio.h>

#define YYDEBUG 0

extern int yyparse();

int main(int argc, char **argv)
{
    if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
    {
        std::cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
        return -1;
    }

#if YYDEBUG == 1
    extern int yydebug;
    yydebug = 1;
#endif

    yyparse();

    return 0;
}
