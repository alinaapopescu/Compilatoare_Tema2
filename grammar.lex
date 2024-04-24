%{
#include "grammar.tab.h"
%}
%option yylineno


%%

"if"               { printf("Token: IF\n"); return IF; }
"else"             { printf("Token: ELSE\n"); return ELSE; }
"elif"             { printf("Token: ELIF\n"); return ELIF; }
"while"            { printf("Token: WHILE\n"); return WHILE; }
"for"              { printf("Token: FOR\n"); return FOR; }
"in"               { printf("Token: IN\n"); return IN; }
"def"              { printf("Token: DEF\n"); return DEF; }
"class"            { printf("Token: CLASS\n"); return CLASS; }
"=="               { printf("Token: EQ\n"); return EQ; }
"!="               { printf("Token: NE\n"); return NE; }
">"                { printf("Token: GT\n"); return GT; }
">="               { printf("Token: GE\n"); return GE; }
"<"                { printf("Token: LT\n"); return LT; }
"<="               { printf("Token: LE\n"); return LE; }
"+"                { printf("Token: PLUS\n"); return PLUS; }
"-"                { printf("Token: MINUS\n"); return MINUS; }
"*"                { printf("Token: TIMES\n"); return TIMES; }
"/"                { printf("Token: DIVIDE\n"); return DIVIDE; }
"="                { printf("Token: EQUALS\n"); return EQ; }
"("                { printf("Token: LPAREN\n"); return LPAREN; }
")"                { printf("Token: RPAREN\n"); return RPAREN; }
":"                { printf("Token: COLON\n"); return COLON; }
","                { printf("Token: COMMA\n"); return COMMA; }
"{"                { printf( "Syntax Error: Unexpected '{' at line %d\n", yylineno); exit(EXIT_FAILURE); }
"}"                { printf( "Syntax Error: Unexpected '}' at line %d\n", yylineno); exit(EXIT_FAILURE); }
[0-9]+             { printf("Token: INTEGER (%s)\n", yytext); return INTEGER; }
[0-9]*\.[0-9]+     { printf("Token: FLOAT (%s)\n", yytext); return FLOAT; }
\"[^\"]*\"         { printf("Token: STRING (%s)\n", yytext); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Token: IDENTIFIER (%s)\n", yytext); return IDENTIFIER; }
[ \t]+             { /* skip whitespace */ }
\n                 { /* handle new lines for INDENT/DEDENT tokens */ printf("Token: NEWLINE\n"); }
.                  { printf("END\n"); exit(EXIT_FAILURE); }


%%