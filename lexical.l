%{

int yylex();
#include <stdio.h>
#include<string.h>
#include "syntaxique.tab.h" 
#include "fonction.h"
extern YYSTYPE yylval;
int ligne=1;
int col=0;

%}

lettres [a-zA-Z]
chiffres [0-9]
chiffres_pos [1-9]
CONSTANTE_ENT ([+-]?{chiffres_pos}{chiffres}*|0)
CONSTANTE_REELE ({CONSTANTE_ENT}"."({chiffres_pos}{chiffres}*))|0"."0
IDENTIFICATEUR ({lettres}(({lettres}|{chiffres}|_)*({lettres}|{chiffres})+)*)
COMMENTAIRE_PLUS_LIGN "/*"([^*]|\*+[^*/])*\*+\/
COMMENTAIRE_UNE_LIGN "//"[^\n]*"\n"

%%

Program {col=col+yyleng;
         return mc_program;
}
PDEC {col=col+yyleng;
      return mc_pdec;
}
PINST {col=col+yyleng;
       return mc_pinst;
}
Pint {col=col+yyleng;
        return mc_pint;
}
Pfloat {col=col+yyleng;
        return mc_pfloat;
}
@define {col=col+yyleng;
         yylval.str=strdup(yytext);
         return mc_define_cst;
}


FOR {col=col+yyleng;
     return mc_for;
}
WHILE {col=col+yyleng;
       return mc_while;
}
DO {col=col+yyleng;
        return mc_do;
}
ENDFOR {col=col+yyleng;
        return mc_endfor;
}


IF {col=col+yyleng;
        return mc_if;
}
ELSE {col=col+yyleng;
        return mc_else;
}
ENDIF {col=col+yyleng;
        return mc_endif;
}

Begin {col=col+yyleng;
       return mc_begin;
}
End {col=col+yyleng;
     return mc_end;
}
{IDENTIFICATEUR} {if (yyleng<=12) {yylval.str=strdup(yytext);
                                   return idf;
                                   col=col+yyleng;
                 }
                else printf("- Identificateur trop long(>12) :",ligne,col);
}

{CONSTANTE_ENT} {   if((atoi(yytext)>-32768)&&(atoi(yytext)<32767)){
                        col=col+yyleng;
                        yylval.num=atoi(yytext);
                        return cst_ent;
                    }
                    else{printf("- Un entier doit etre entre -32768 & 32767 :",ligne,col);}
}

{CONSTANTE_REELE} {col=col+yyleng;
             yylval.reel=atoi(yytext);
             return cst_rel;
}
{COMMENTAIRE_PLUS_LIGN} {col=col+yyleng;}
{COMMENTAIRE_UNE_LIGN} {col=col+yyleng;}
: {col=col+yyleng;return deuxpts;}
"(" {col=col+yyleng;return par_ouv;}
")" {col=col+yyleng;return par_ferm;}
";" {col=col+yyleng;return pvg;}
"=" {col=col+yyleng;return aff_cst;}
"|" {col=col+yyleng;return ou_variables_log;}
"<-" {col=col+yyleng;return affectation;}

"&" {col=col+yyleng;return et_logique;}
"!" {col=col+yyleng;return negation;}

">" {col=col+yyleng;return sup;}
">=" {col=col+yyleng;return sup_eg;}
"==" {col=col+yyleng;return egale;}
"!=" {col=col+yyleng;return diff;}
"<" {col=col+yyleng;return inf;}
"<=" {col=col+yyleng;return inf_eg;}

"+" {col=col+yyleng;return somme;}
"-" {col=col+yyleng;return soustraction;}
"*" {col=col+yyleng;return produit;}
"/" {col=col+yyleng;
     yylval.str=strdup(yytext);
     return division;
}


[ \t] {col=col+yyleng;}
\n {col=0;ligne++;}
. printf("- Erreur lexicale a la ligne %d la colonne %d avec l'entite '%s'\n",ligne,col,yytext);
