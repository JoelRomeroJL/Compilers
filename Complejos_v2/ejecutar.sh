#!/bin/bas
lex lexico.l
yacc -d reglas.y
gcc lex.yy.c y.tab.c -o complejo
