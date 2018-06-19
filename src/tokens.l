%{
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.hpp"
//#include "node.hpp"

//#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
#define SAVE_TOKEN yylval.node = new Node( yytext );
#define TOKEN(t) (yylval.token = t)
extern "C" int yywrap() { }
%}

%%

[ \t\n]                                     ;
#[a-zA-Z_ąćęłńóśźż0-9 \t\n;]*#              SAVE_TOKEN; return T_COMMENT;
[-]?[0-9]+                                  SAVE_TOKEN; return T_INT_NUMBER;
[-]?[0-9]+\.[0-9]*                          SAVE_TOKEN; return T_FLOAT_NUMBER;
\"[a-zA-Z_ąćęłńóśźż0-9 \t\n;]*\"            SAVE_TOKEN; return T_STRING; 
"="                                         SAVE_TOKEN; return T_ASSIGNMENT;
"=="                                        SAVE_TOKEN; return T_EQUAL;
"!="                                        SAVE_TOKEN; return T_NOTEQUAL;
"<"                                         SAVE_TOKEN; return T_LESS;
"<="                                        SAVE_TOKEN; return T_LESSEQ;
">"                                         SAVE_TOKEN; return T_GREATER;
">="                                        SAVE_TOKEN; return T_GREATEREQ;
"("                                         SAVE_TOKEN; return T_LBRACE;
")"                                         SAVE_TOKEN; return T_RBRACE;
"{"                                         SAVE_TOKEN; return T_LPAREN;
"}"                                         SAVE_TOKEN; return T_RPAREN;
","                                         SAVE_TOKEN; return T_COMMA;
";"                                         SAVE_TOKEN; return T_SEMICOLON;
"+"                                         SAVE_TOKEN; return T_PLUS;
"-"                                         SAVE_TOKEN; return T_MINUS;
"*"                                         SAVE_TOKEN; return T_MUL;
"/"                                         SAVE_TOKEN; return T_DIV;
"%"                                         SAVE_TOKEN; return T_MOD;
"&&"                                        SAVE_TOKEN; return T_AND;
"||"                                        SAVE_TOKEN; return T_OR;
"!"                                         SAVE_TOKEN; return T_NOT;
"--"                                        SAVE_TOKEN; return T_DEC;
"++"                                        SAVE_TOKEN; return T_INC;
"->"                                        SAVE_TOKEN; return T_RET_TYPE_OP;
"~"                                         SAVE_TOKEN; return T_PRINT_OP;
"stała"                                     yylval.node = new Node( "const" ); return T_CONST;
"zmienna"                                   yylval.node = new Node( "" ); return T_VAR;
"całkowita"                                 yylval.node = new Node( "int" ); return T_TYPEINT;
"rzeczywista"                               yylval.node = new Node( "double" ); return T_TYPEFLOAT;
"string"                                    yylval.node = new Node( "std::string" ); return T_TYPESTRING;
"fn"                                        yylval.node = new Node( "" ); return T_FUNCTION;
"dopóki"                                    yylval.node = new Node( "while" ); return T_WHILE;
"jeżeli"                                    yylval.node = new Node( "if" ); return T_IF;
"zwróć"                                     yylval.node = new Node( "return" ); return T_RETURN;
"start"                                     yylval.node = new Node( "main" ); return T_MAIN;
[a-zA-Z_ąćęłńóśźż][a-zA-Z0-9_ąćęłńóśźż]*    SAVE_TOKEN; return T_ID;
.                                           printf("Unknown token!\n"); yyterminate();

%%