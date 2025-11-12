%{
#include <stdio.h>
%}

%%
.*\.com$    { printf("Line ending with .com: %s\n", yytext); }  
.*\n        ;   // ignore other lines
%%

int yywrap() { return 1; }

int main() {
    printf("Enter text (Ctrl+D to end):\n");
    yylex();
    return 0;
}



lex find_dotcom.l
gcc lex.yy.c -o find_dotcom
./find_dotcom