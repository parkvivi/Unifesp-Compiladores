%option noyywrap
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int contBytes       = 0; 
    int contPalavras    = 0;
    int contLinhas      = 1;
%}

LETRAS [a-zA-Z]
DIGITOS [0-9]

%%

{LETRAS}+{DIGITOS}+ {
    contBytes += strlen(yytext);
}

{DIGITOS}+{LETRAS}+ {
    contBytes += strlen(yytext);
}

{DIGITOS}+{LETRAS}+{DIGITOS}+ {
    contBytes += strlen(yytext);
}

{LETRAS}+ {
    contPalavras++;
    contBytes += strlen(yytext);
}

\n {
    contBytes++;
    contLinhas++;
}

. {
    contBytes++;
}
%%

extern FILE *yyin;
extern int contBytes, contPalavras, contLinhas;

int main(void) {
    yyin = fopen("texto.txt", "r");
    if (!yyin) {
        perror("texto.txt");
        return 1;
    }

    yylex();

    fclose(yyin);

    printf("%d\tbytes\n%d\tpalavras\n%d\tlinhas", contBytes, contPalavras, contLinhas);
    return 0;
}