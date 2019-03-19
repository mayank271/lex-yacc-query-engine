%{
//Parser file
#include<stdio.h>
#include<stdlib.h>
%}
%token AND COMMA DELETE FROM GET ID INSERT INTO NUM OR SET SPACE TO UPDATE WHERE EQUAL NE GT GE LT LE
%%
stmt: S GET S FIELDS S FROM S ID S WHERE S CONDITIONS S {char* fname=malloc(sizeof(char)*(strlen($8)+4); strcpy(fname, $8); strcat(fname, '.txt'); printf("%s", fname);}
  | S INSERT S FIELDS S INTO S ID S {/**/}
  | S UPDATE S ID S SET S ID S TO S NEWVAL S WHERE S CONDITIONS S {/**/}
  | S DELETE S FROM S ID S WHERE S CONDITIONS S {/**/}
  ;
FIELDS: FIELDS S COMMA S ID {/**/}
  | ID {/**/}
  ;
NEWVAL: ID {/**/}
  | NUM {/**/}
  ;
CONDITIONS: CONDITIONS S AND S CONDITION {/**/}
  | CONDITIONS S OR S CONDITION {/**/}
  | CONDITION {/**/}
  ;
CONDITION: ID S EQUAL S ID {/**/}
  | ID S NE S ID {/**/}
  | ID S EQUAL S NUM {/**/}
  | ID S NE S NUM {/**/}
  | ID S GT S NUM {/**/}
  | ID S GE S NUM {/**/}
  | ID S LT S NUM {/**/}
  | ID S LE S NUM {/**/}
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
