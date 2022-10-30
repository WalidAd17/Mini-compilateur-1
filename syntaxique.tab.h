
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_program = 258,
     mc_pdec = 259,
     mc_pinst = 260,
     deuxpts = 261,
     pvg = 262,
     mc_define_cst = 263,
     aff_cst = 264,
     ou_variables_log = 265,
     mc_begin = 266,
     mc_end = 267,
     affectation = 268,
     somme = 269,
     soustraction = 270,
     produit = 271,
     mc_for = 272,
     mc_while = 273,
     mc_do = 274,
     mc_endfor = 275,
     mc_if = 276,
     mc_else = 277,
     par_ouv = 278,
     par_ferm = 279,
     mc_endif = 280,
     idf = 281,
     mc_pint = 282,
     mc_pfloat = 283,
     division = 284,
     cst_rel = 285,
     cst_ent = 286,
     et_logique = 287,
     negation = 288,
     inf_eg = 289,
     inf = 290,
     diff = 291,
     egale = 292,
     sup_eg = 293,
     sup = 294
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 21 "syntaxique.y"

int num;
char* str;
float reel;



/* Line 1676 of yacc.c  */
#line 99 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


