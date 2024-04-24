%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
%}

%token INTEGER FLOAT STRING IDENTIFIER
%token IF ELSE ELIF WHILE FOR IN DEF CLASS
%token EQ NE GT GE LT LE PLUS MINUS TIMES DIVIDE EQUALS
%token LPAREN RPAREN COLON COMMA NEWLINE
%token INDENT DEDENT

%start program

%%

program:
        | program statement
        ;

statement:
        | compound_statement
        | simple_statement
        ;

compound_statement:
        | if_stmt
        | while_stmt
        | for_stmt
        | func_def
        | class_def
        | simple_stmt
        ;

simple_statement:
        | expr_stmt
        | assignment_stmt
        | NEWLINE
        ;

if_statement:
        | IF expr COLON suite
        | IF error { yyerror("Expected ':' after 'if'"); YYABORT; }
        | IF expr COLON suite ELSE COLON suite
        | IF expr COLON suite elif_clause
        ;

elif_clause:
        | ELIF expr COLON suite
        | ELIF expr COLON suite elif_clause
        | ELIF expr COLON suite ELSE COLON suite
        ;

while_statement:
        | WHILE expr COLON suite
        ;

for_statement:
        | FOR IDENTIFIER IN expr COLON suite
        ;

func_def:
        | DEF IDENTIFIER LPAREN RPAREN COLON suite
        ;

class_def:
        | CLASS IDENTIFIER COLON suite
        ;

suite:
        | simple_stmt
        | NEWLINE INDENT program DEDENT
        ;

expr_statement:
        | expr
        ;

assignment_statement:
        | IDENTIFIER EQUALS expr
        ;

expr:
        | INTEGER
        | FLOAT
        | STRING
        | IDENTIFIER
        | expr PLUS expr
        | expr MINUS expr
        | expr TIMES expr
        | expr DIVIDE expr
        | LPAREN expr RPAREN
        | expr EQ expr
        | expr NE expr
        | expr GT expr
        | expr GE expr
        | expr LT expr
        | expr LE expr
        ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyin = stdin;
    if (yyparse()) {
        printf("Parsing failed\n");
    }
    return 0;
}
