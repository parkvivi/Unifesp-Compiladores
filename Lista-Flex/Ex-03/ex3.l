%option noyywrap
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int contVogais      = 0; 
    int contConsoantes  = 0;
%}

VOGAIS [a|e|i|o|u|A|E|I|O|U]
LETRAS [a-zA-Z]

%%
{VOGAIS} {
    contVogais++;
}

{LETRAS} {
    contConsoantes++;
}

(.|\n|\t) {}
%%

extern FILE *yyin;
extern int contVogais, contConsoantes;

int main(void) {
    yyin = fopen("texto.txt", "r");
    if (!yyin) {
        perror("texto.txt");
        return 1;
    }

    yylex();

    fclose(yyin);

    printf("%d\tvogais\n%d\tconsoantes\n", contVogais, contConsoantes);
    return 0;
}