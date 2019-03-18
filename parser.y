%{
//Parser file
#include<stdio.h>
#include<stdlib.h>
%}
%token AND COMMA DELETE FROM GET ID INSERT INTO NUM OR SET SPACE TO UPDATE WHERE EQUAL NE GT GE LT LE
%%
stmt: GET ' ' FROM ' ' ID
%%
void main()
{
printf("enter statement : \n");
yyparse();
printf("valid statement");
exit(0);
}
void yyerror()
{
  printf("invalid statement");
exit(0);
}
