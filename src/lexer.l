%option noyywrap
%option nounput
%option noinput
%top{
    #include <stdarg.h>
    #include "common.h"
}
%{
    extern dump_type_t dump_type;

    inline void dump_tokens(const char* format, ...){
        va_list args;
        va_start(args, format);
        if (dump_type == TOKENS)
            vfprintf(yyout, format, args);
        va_end(args);
    }

    /* Your code here, if desired (lab3). */
%}

/* definitions section */
DECIMIAL ([1-9][0-9]*|0)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
/*  Your code here (lab3). */

%%
    /* rules section */
"int" {
    dump_tokens("INT\t%s\n", yytext);
}

"void" {
    dump_tokens("VOID\t%s\n", yytext);
}

"if" {
    dump_tokens("IF\t%s\n", yytext);
}

"else" {
    dump_tokens("ELSE\t%s\n", yytext);
}

"return" {
    dump_tokens("RETURN\t%s\n", yytext);
}

"=" {
    dump_tokens("ASSIGN\t%s\n", yytext);
}

"<" {
    dump_tokens("LESS\t%s\n", yytext);
}

"+" {
    dump_tokens("ADD\t%s\n", yytext);
}

";" {
    dump_tokens("SEMICOLON\t%s\n", yytext);
}

"(" {
    dump_tokens("LPAREN\t%s\n", yytext);
}

")" {
    dump_tokens("RPAREN\t%s\n", yytext);
}

"{" {
    dump_tokens("LBRACE\t%s\n", yytext);
}

"}" {
    dump_tokens("RBRACE\t%s\n", yytext);
}

{DECIMIAL} {
    int decimal;
    decimal = atoi(yytext);
    dump_tokens("DECIMAL\t%s\t%d\n", yytext, decimal);
}

{ID} {
    dump_tokens("ID\t%s\n", yytext);
}

{EOL} yylineno++;

{WHITE}

    /*  Your code here (lab3). */
%%
/* user code section */
