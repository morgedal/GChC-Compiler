/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#include "node.hpp"

#ifndef YY_YY_PARSER_TAB_HPP_INCLUDED
# define YY_YY_PARSER_TAB_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_VAR = 258,
    T_COMMENT = 259,
    T_FLOAT_NUMBER = 260,
    T_STRING = 261,
    T_INT_NUMBER = 262,
    T_ASSIGNMENT = 263,
    T_EQUAL = 264,
    T_NOTEQUAL = 265,
    T_LESS = 266,
    T_LESSEQ = 267,
    T_GREATER = 268,
    T_GREATEREQ = 269,
    T_LPAREN = 270,
    T_RPAREN = 271,
    T_LBRACE = 272,
    T_RBRACE = 273,
    T_COMMA = 274,
    T_SEMICOLON = 275,
    T_PLUS = 276,
    T_MINUS = 277,
    T_MUL = 278,
    T_DIV = 279,
    T_MOD = 280,
    T_AND = 281,
    T_OR = 282,
    T_NOT = 283,
    T_DEC = 284,
    T_INC = 285,
    T_RET_TYPE_OP = 286,
    T_CONST = 287,
    T_TYPEINT = 288,
    T_TYPEFLOAT = 289,
    T_TYPESTRING = 290,
    T_FUNCTION = 291,
    T_WHILE = 292,
    T_IF = 293,
    T_ID = 294,
    T_RETURN = 295,
    T_MAIN = 296,
    T_PRINT_OP = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 21 "parser.y" /* yacc.c:1909  */

    std::string *string;
    int token;
    Node* node;

#line 103 "parser.tab.hpp" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_HPP_INCLUDED  */
