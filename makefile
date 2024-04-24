grammar: grammar.y grammar.lex
	bison -d grammar.y
	flex  -o grammar.lex.c grammar.lex
	gcc  -o grammar grammar.lex.c grammar.tab.c -lfl -lm