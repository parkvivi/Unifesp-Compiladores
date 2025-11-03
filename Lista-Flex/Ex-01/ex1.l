%option noyywrap
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int cont = 0; 
%}

MAIUSCULAS [A-Z]
LETRAS [a-zA-Z]

%%
{MAIUSCULAS}{LETRAS}* {
    cont++;
}

(.|\n|\t) {}
%%

extern FILE *yyin;
extern int cont;

int main(void) {
    yyin = fopen("texto.txt", "r");
    if (!yyin) {
        perror("texto.txt");
        return 1;
    }

    yylex();

    fclose(yyin);

    printf("%d palavras.\n", cont);
    return 0;
}