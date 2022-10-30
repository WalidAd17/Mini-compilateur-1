#include <stdio.h>
#include <stdlib.h>

//Table des symboles :
        // 1- declaration :
    typedef struct {
        char nomEntite[20];    //idf
        char typeEntite[20];    //soit Entier ou Reel 
        char natureEntite[20];    //soit Variable ou Constante
        int valEnt;
        float valReel;
    } typeTs;
        // 2- initialisation d'une table de 100 elements :
    typeTs ts[100];
    int cptTabSym = 0;

    //Definir fonction recherche :
    int recherche(char entite[]) {
        int i = 0;
        while(i<cptTabSym){
            if( strcmp(entite,ts[i].nomEntite)==0) return i; // si elle existe retourner sa position
            i++;
        }
        return -1; //n existe pas
    }

    //Definir fonction inserer
    void inserer(char entite[], char type[], char nature[]){
            strcpy(ts[cptTabSym].nomEntite, entite);
            strcpy(ts[cptTabSym].typeEntite, type );
            strcpy(ts[cptTabSym].natureEntite, nature);
            cptTabSym++;
    }


    //Definir fonction afficher
    void afficher() {
        printf("\n");
        printf("\n **********************TABLE DES SYMBOLES********************** \n");
        printf("         ------------------------------------------------------------\n");
        printf("\t| nomEntite         |    typeEntite     |    natureEntite    |    \n");
        printf("         ------------------------------------------------------------\n");

        int i=0;

        while(i<cptTabSym)
        {
            printf("\t|%18s |%18s |%18s |  \n",ts[i].nomEntite,ts[i].typeEntite, ts[i].natureEntite);
            i++;
        }
        }

    //Definir fonction insertion type
    void insererType(char type[]) {
        int i = 0;
        while(i<cptTabSym){
            if( strcmp(ts[i].typeEntite," ")==0){
              strcpy(ts[i].typeEntite,type);
            }
            i++;
        }
    }

    int return_nature(char entite[]){
        int pos ;
        pos =recherche(entite);
        if(strcmp( ts[pos].natureEntite ,"Variable") ==0 ) return 0  ;
        if(strcmp( ts[pos].natureEntite,"Constante") ==0 ) return 1  ;
        else return -1 ;
    }

    int incompatibiliteType(char type1[], char type2[]){
        if(strcmp(type1,type2)!=0) return 1;
        else return 0;
    }

    int return_type(char entite[]){
        int pos ;
        pos =recherche(entite);
        if(strcmp( ts[pos].typeEntite ,"Entier") ==0 ) return 0  ;
        if(strcmp( ts[pos].typeEntite,"Reel") ==0 ) return 1  ;
        else return -1 ;
    }

    char * return_types(char entite[]){
        int pos,i;
        pos =recherche(entite);
        while(i<cptTabSym){
            if( strcmp(ts[i].nomEntite,entite)==0){
                return ts[i].typeEntite;
            }else{
                i++;
            }
        }
    }

