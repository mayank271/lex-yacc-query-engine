%{
//Parser file
#include<stdio.h>
#include<stdlib.h>
%}
%token AND COLON DELETE FROM GET ID INSERT INTO NUM OR SET UPDATE WHERE EQUAL NE GT GE LT LE
%%
stmt: GET FROM ID COLON
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
