%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int ligne;
extern int col;

int yyparse();
int yyerror(char* msg);
int yylex();	

char sauvetype[20];
char sauvetype1[20];
char sauvetypeidf[20];
char tp[20];
char sauveopdiv[20];
int sauvConst,temp;
char sauveidf[20];
%}
%union {
int num;
char* str;
float reel;
}

%start S
%token mc_program mc_pdec mc_pinst deuxpts pvg mc_define_cst aff_cst ou_variables_log
	mc_begin mc_end affectation somme soustraction produit mc_for mc_while mc_do
       mc_endfor mc_if mc_else par_ouv par_ferm mc_endif

%token <str>idf <str>mc_pint <str>mc_pfloat <str>division
%token <reel>cst_rel
%token <num>cst_ent

%left ou_variables_log
%left et_logique
%left negation
%left sup sup_eg egale diff inf inf_eg
%left somme soustraction
%left produit division

%%

S: mc_program idf mc_pdec PARTIE_DECLARATION mc_pinst mc_begin PARTIE_INSTRUCTION mc_end { inserer($2,"/","/"); 
                                                                                           printf("- syntaxe correcte !!");YYACCEPT ;
                                                                                           }
;

PARTIE_DECLARATION: PARTIE_DEC_VAR PARTIE_DECLARATION
		    | PARTIE_DEC_CONST PARTIE_DECLARATION
	           |
;

PARTIE_DEC_VAR: LISTE_IDF deuxpts TYPE pvg {insererType(sauvetype);}
;

LISTE_IDF: idf ou_variables_log LISTE_IDF {      if(recherche($1)== -1){
                                                         inserer($1," ","Variable"); 
                                                 }else{
                                                        printf("- Double declaration de %s , la ligne %d et la colonne %d \n",$1,ligne,col);
                                                 }
                                          }

	  | idf {     if(recherche($1)== -1){
                            inserer($1," ","Variable");
                     }else{
                            printf("- Double declaration de %s , la ligne %d et la colonne %d\n",$1,ligne,col);
                     }
              }
;

PARTIE_DEC_CONST: mc_define_cst TYPE idf aff_cst CTE pvg {     if(recherche($3)== -1){
                                                                      inserer($3,sauvetype,"Constante");
                                                               }else{
                                                                      printf("- Double declaration de %s , la ligne %d et la colonne %d\n",$3,ligne,col);
                                                               }
                                                               if(incompatibiliteType(sauvetype,sauvetype1)==1){
                                                                      printf("- Incompatibilite de type , la ligne %d et la colonne %d\n",ligne,col);
                                                               }
                                                        }
;

CTE: cst_ent {strcpy(sauvetype1,"Entier"); sauvConst=$1;} 
   | cst_rel {strcpy(sauvetype1,"Reel"); sauvConst=$1;}
;

TYPE: mc_pint {strcpy(sauvetype,"Entier");}
    | mc_pfloat {strcpy(sauvetype,"Reel");}
;

PARTIE_INSTRUCTION: INSTRUCTION PARTIE_INSTRUCTION
		    | 
;

INSTRUCTION: AFFECTATION
           |BOUCLE
           |CONDITION
;

AFFECTATION: idf affectation EXPRESSION_AR pvg { if(recherche($1) == -1){printf("- Non declaration de %s , la ligne %d et la colonne %d\n",$1,ligne,col);}
                                                 else{
                                                        if(return_nature($1)==1){
                                                               printf("- Modification de la constante %s , la ligne %d et colonne %d\n",$1,ligne,col);
                                                        }else{
                                                               if(temp==1){
                                                                      if(incompatibiliteType(return_types($1),sauvetypeidf)==1){
                                                                             printf("- Incompatibilite de type (idf<-idf) a la ligne %d et la colonne %d\n",ligne,col );
                                                                      }                 
                                                               }else if(temp==0){
                                                                      if(incompatibiliteType(return_types($1),sauvetype1)==1){
                                                                             printf("- Incompatibilite de type (idf<-cst) a la ligne %d et la colonne %d\n",ligne,col );
                                                                      }
                                                               }
                                                        }
                                                 }
                                           }
;

EXPRESSION_AR: EXPRESSION_AR OPERATEUR_ARITHMETIQUE OPERAND {  if(( strcmp(sauveopdiv,"/") ==0 && sauvConst==0) && ( strcmp(sauveopdiv,"/") ==0 && atoi(sauveidf)==0)){
                                                                      printf("- Division par zero , la ligne %d\n", ligne);
                                                               }
                                                        }
                             					
              | OPERAND
;

OPERATEUR_ARITHMETIQUE: somme
                      | soustraction
                      | produit
                      | division {strcpy(sauveopdiv, $1);}
;

OPERAND: idf {       if(recherche($1)==-1){
                            printf("- Non declaration de %s , la ligne %d et la colonne %d\n",$1,ligne,col);
                     }else{
                            temp=1;
                            if(return_type($1)==0){
                                   strcpy(sauvetypeidf,"Entier");
                            }else if(return_type($1)==1){
                                   strcpy(sauvetypeidf,"Reel");
                            }
                            strcpy(sauveidf,$1);
                     }
              }
       | CTE {temp=0;}
;

BOUCLE: mc_for idf affectation EXPRESSION_AR mc_while EXPRESSION_AR mc_do INSTRUCTION mc_endfor {
                                                        if(recherche($2) == -1){
                                                               printf("- Non declaration de %s , la ligne %d et la colonne %d\n",$2,ligne,col);
                                                        }else{
                                                               if(return_nature($2)==1){
                                                                      printf("- Modification de la constante %s , la ligne %d et colonne %d\n",$2,ligne,col);
                                                               }
                                                        }
                                                 }
;

CONDITION: mc_do INSTRUCTION mc_if deuxpts par_ouv COND par_ferm NOTCOND mc_endif
;

COND: EXPRESSION_COMP OPERATEUR_COMP EXPRESSION_COMP
;

EXPRESSION_COMP: EXPRESSION_COMP OPERATEURS OPERAND
                | OPERAND
;

OPERATEUR_COMP: sup
              | sup_eg
              | egale
              | diff
              | inf
              | inf_eg 
;

OPERATEURS: OPERATEUR_ARITHMETIQUE
           | OPERATEUR_LOGIQUE 
;

OPERATEUR_LOGIQUE: ou_variables_log
                 | et_logique
                 | negation
;

NOTCOND: mc_else INSTRUCTION
       | 
;


%%
int yyerror(char* msg)
{printf("%s a la ligne %d et la colonne %d",msg,ligne,col);

}

main()
{yyparse(); afficher();
}
yywrap()
{}
