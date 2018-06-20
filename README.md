# GChC - Great Chrząszcz Compiler

Simple compiler created to pass compiler university course. Compiles custom defined language to C++. Lexer and parser are generated using Flex and Bison. 
The syntax is based on C with some little modifications, and adapted to polish language to make it easier for people that can't speak english. 

## Build and run instructions

In /src there are already generated .cpp and .hpp files, to build from it only command needed is

```
g++ -std=c++11 *.cpp -o <<your destination and name>>
```

if you make some changes in flex or bison files you have to generate code from them

```
flex -o lex.yy.cpp tokens.l

bison -tvd parser.y -o parser.tab.cpp

```

You have to put line ' #include "node.hpp" ' in generated .hpp file after bison code generating before compiling( Sorry, I didn't find out how to generate it from bison ). Note that you have to install flex and bison first.

To run compiler use GChC from /bin catalogue ( or build by yourself and use created file )

To see output on standart out type

```
./GChC <<input file>>
```

You can simply create output file with generated code typing

```
./GChC <<input file>> > <<output file>>.cpp 
```

## Language specification

Start symbol is 'program'. By self-defined convention all non-terminal symbols are written lowercase and all terminal symbols ( tokens ) starts from T_ and are written only using capital letters. Grammar is defined in 'parser.y' ( bison file ) and tokens are in 'tokens.l' ( Flex file ).  

### Grammar

```
program -> function program | constant program | T_COMMENT program | mainFunction

type -> T_TYPEINT | T_TYPEFLOAT | T_TYPESTRING

constant -> T_CONST type T_ID T_ASSIGNMENT value T_SEMICOLON

mainFunction -> T_FUNCTION T_MAIN T_LBRACE T_RBRACE T_LPAREN functionBody T_RPAREN

function -> T_FUNCTION T_ID T_LBRACE typedArgList T_RBRACE T_LPAREN functionBody T_RPAREN
		 | T_FUNCTION T_ID T_LBRACE typedArgList T_RBRACE T_RET_TYPE_OP type T_LPAREN functionBody T_RPAREN

typedArgList -> type T_ID | type T_ID T_COMMA typedArgList

value -> T_STRING | T_INT_NUMBER | T_FLOAT_NUMBER

functionBody -> expression T_SEMICOLON | expression T_SEMICOLON functionBody | T_COMMENT functionBody

expression -> variableDeclaration | loop | conditionalExpression | arithmeticExpression | returnExpression
			| functionCall | printExpression
			
variableDeclaration -> T_VAR type T_ID | T_VAR type T_ID T_ASSIGNMENT factor

loop -> T_WHILE T_LBRACE condition T_RBRACE T_LPAREN functionBody T_RPAREN

conditionalExpression -> T_IF T_LBRACE condition T_RBRACE T_LPAREN functionBody T_RPAREN

condition -> functionCall | arithmeticExpression

returnExpression -> T_RETURN factor | T_RETURN

functionCall -> T_ID T_LBRACE argList T_RBRACE

argList -> factor | factor T_COMMA argList

arithmeticExpression -> factor binaryOperator factor | unaryOperator factor

factor -> T_ID | value | T_LBRACE arithmeticExpression T_RBRACE | functionCall

binaryOperator -> T_PLUS | T_MINUS | T_MUL | T_DIV | T_MOD | T_AND | T_OR | T_GREATER
				| T_GREATEREQ | T_LESS | T_LESSEQ | T_EQUAL | T_NOTEQUAL | T_ASSIGNMENT
				
unaryOperator -> T_NOT | T_INC | T_DEC

printExpression -> T_PRINT_OP factor
```

### Tokens

```
#[a-zA-Z_ąćęłńóśźż0-9 \t\n;]*#              T_COMMENT;
[-]?[0-9]+                                  T_INT_NUMBER;
[-]?[0-9]+\.[0-9]*                          T_FLOAT_NUMBER;
\"[a-zA-Z_ąćęłńóśźż0-9 \t\n;]*\"            T_STRING; 
"="                                         T_ASSIGNMENT;
"=="                                        T_EQUAL;
"!="                                        T_NOTEQUAL;
"<"                                         T_LESS;
"<="                                        T_LESSEQ;
">"                                         T_GREATER;
">="                                        T_GREATEREQ;
"("                                         T_LBRACE;
")"                                         T_RBRACE;
"{"                                         T_LPAREN;
"}"                                         T_RPAREN;
","                                         T_COMMA;
";"                                         T_SEMICOLON;
"+"                                         T_PLUS;
"-"                                         T_MINUS;
"*"                                         T_MUL;
"/"                                         T_DIV;
"%"                                         T_MOD;
"&&"                                        T_AND;
"||"                                        T_OR;
"!"                                         T_NOT;
"--"                                        T_DEC;
"++"                                        T_INC;
"->"                                        T_RET_TYPE_OP;
"~"                                         T_PRINT_OP;
"stała"                                     T_CONST;
"zmienna"                                   T_VAR;
"całkowita"                                 T_TYPEINT;
"rzeczywista"                               T_TYPEFLOAT;
"string"                                    T_TYPESTRING;
"fn"                                        T_FUNCTION;
"dopóki"                                    T_WHILE;
"jeżeli"                                    T_IF;
"zwróć"                                     T_RETURN;
"start"                                     T_MAIN;
[a-zA-Z_ąćęłńóśźż][a-zA-Z0-9_ąćęłńóśźż]*    T_ID;

```

## Examples

Some example codes can be found in /res folder, you can compile it using GChC from /bin and run after compiling generated file with C++ compiler.

## License

https://www.youtube.com/watch?v=g2cF4-tHvqI



