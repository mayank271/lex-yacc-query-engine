%{
//Parser file
#include<stdio.h>
#include<stdlib.h>
%}
%token AND COMMA DELETE FROM GET ID INSERT INTO NUM OR SET SPACE TO UPDATE WHERE EQUAL NE GT GE LT LE S FIELDS CONDITIONS CONDITIONS NEWVAL
%%
stmt: S GET S FIELDS S FROM S ID S WHERE S CONDITIONS S
  | S INSERT S FIELDS S INTO S ID S
  | S UPDATE S ID S SET S ID S TO S NEWVAL S WHERE S CONDITIONS S
  | S DELETE S FROM S ID S WHERE S CONDITIONS S
  ;
FIELDS: S ID S COMMA S FIELDS S
  | S ID S
  ;
NEWVAL: S ID S
  | S NUM S
  ;
CONDITIONS: S CONDITION S AND S CONDITIONS S
  | S CONDITION S OR S CONDITIONS S
  | S CONDITION S
  ;
CONDITION: S ID S EQUAL S ID S
  | S ID S NE S ID S
  | S ID S EQUAL S NUM S
  | S ID S NE S NUM S
  | S ID S GT S NUM S
  | S ID S GE S NUM S
  | S ID S LT S NUM S
  | S ID S LE S NUM S
  ;
S: SPACE
  |
  ;
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
