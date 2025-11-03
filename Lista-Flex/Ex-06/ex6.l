%option noyywrap
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int i = 0;
    char* buffer[6];
%}

DIGITOS [0-9]

%%

R\$[ ]*{DIGITOS}+,{DIGITOS}+ {
   buffer[i] = (char*) malloc((strlen(yytext) + 1) * sizeof(char));
   strcpy(buffer[i], yytext);
   buffer[i][strlen(yytext)] = '\0';
   i++;
}

(.|\n) {}
%%

extern FILE *yyin;
extern char* buffer[];

int main(void) {
    yyin = fopen("texto.txt", "r");
    if (!yyin) {
        perror("texto.txt");
        return 1;
    }

    yylex();

    fclose(yyin);

    for (int j = 0; j < 6; j++) {
        printf("%s\n", buffer[j]);
    }

    return 0;
}