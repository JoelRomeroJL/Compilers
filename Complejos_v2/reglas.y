%{
	#include "complejo_cal.h";
%}
%token CNUMBER
%left '+' '-'
%left '*' '/'

%%
list:	/* nada */
			| list '\n'
			| list exp '\n' {imprimirC($2);}
			;
exp:  CNUMBER   
     | exp '+' exp {$$ = Complejo_add($1, $3);}
     | exp '-' exp {$$ = Complejo_sub($1, $3);}
     | exp '*' exp {$$ = Complejo_mul($1, $3);}
     | exp '/' exp {$$ = Complejo_div($1, $3);}
     | '(' exp ')' {$$ = $2;}
    ;
%%

#include <stdio.h>
#include <ctype.h>

int main() { return yyparse(); }

int yyerror(const char* s) { 
  printf("%s\n", s); 
  return 0; 
}

Complejo *creaComplejo(int real, int img){
   Complejo *nvo = (Complejo*)malloc(sizeof(Complejo));
   nvo -> real = real;
   nvo -> img = img;
   return nvo;
}

Complejo *Complejo_add(Complejo *c1, Complejo *c2){
  return creaComplejo(c1->real + c2->real, c1->img + c2->img);
}

Complejo *Complejo_sub(Complejo *c1, Complejo *c2){
  return creaComplejo(c1->real - c2->real, c1->img - c2->img);
}

Complejo *Complejo_mul(Complejo *c1, Complejo *c2){
  return creaComplejo( c1->real*c2->real - c1->img*c2->img,
                       c1->img*c2->real + c1->real*c2->img);
}

Complejo *Complejo_div(Complejo *c1, Complejo *c2){
   double d = c2->real*c2->real + c2->img*c2->img;
   return creaComplejo( (c1->real*c2->real + c1->img*c2->img) / d,
                        (c1->img*c2->real - c1->real*c2->img) / d);
}

void imprimirC(Complejo *c){
   if(c->img != 0)
      printf("%f%+fi\n", c->real, c->img);
   else
      printf("%f\n", c->real);
}
