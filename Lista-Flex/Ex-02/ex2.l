%option noyywrap
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int contMaiusculas  = 0; 
    int contMinusculas  = 0; 
    int contDigitos     = 0; 
%}

MAIUSCULAS [A-Z]
MINUSCULAS [a-z]
DIGITOS [0-9]

%%
{MAIUSCULAS} {
    contMaiusculas++;
}

{MINUSCULAS} {
    contMinusculas++;
}

{DIGITOS} {
    contDigitos++;
}

(.|\n|\t) {}
%%

extern FILE *yyin;
extern int contMaiusculas, contMinusculas, contDigitos;

int main(void) {
    yyin = fopen("texto.txt", "r");
    if (!yyin) {
        perror("texto.txt");
        return 1;
    }

    yylex();

    fclose(yyin);

    printf("%d\tmaiúsculas\n%d\tminúsculas\n%d\tdígitos\n", contMaiusculas, contMinusculas, contDigitos);
    return 0;
}