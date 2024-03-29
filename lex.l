%{
#include<stdio.h>
#include<stdlib.h>
//Lex file: returns token to the parser
#include "y.tab.h"
%}
AND [aA][nN][dD]
COLON [;]
COMMA [,]
DELETE [dD][eE][lL][eE][tT][eE][ ]*[rR][eE][cC][oO][rR][dD]
FROM [fF][rR][oO][mM]
GET [gG][eE][tT]
ID [_A-Za-z][_A-Za-z0-9$]*
INSERT [iI][nN][sS][eE][rR][tT][ ]*[rR][eE][cC][oO][rR][dD][ ]*[(]
INTO [)][ ]*[iI][nN][tT][oO]
NUM [0-9]+
OR [oO][rR]
SET [sS][eE][tT]
SPACE [ ]+
TO [tT][Oo]
UPDATE [uU][pP][dD][aA][tT][eE][ ]*[rR][eE][cC][oO][rR][dD][ ]*[iI][nN]
VALUE [\"][^\"]*[\"]
WHERE [wW][hH][eE][rR][eE]
EQUAL [=]
NE (!=)
GT [>]
GE (>=)
LT [<]
LE (<=)
%%
[\t\n]
{AND} return AND;
{COLON} return 0;
{COMMA} return COMMA;
{DELETE} return DELETE;
{FROM} return FROM;
{GET} return GET;
{INSERT} return INSERT;
{INTO} return INTO;
{NUM} {yylval.ival = atoi(yytext); return NUM;}
{OR} return OR;
{SET} return SET;
{TO} return TO;
{UPDATE} return UPDATE;
{VALUE} { char *res = (char *)malloc(sizeof(char)*(strlen(yytext) + 1));
	strcpy(res, yytext);
	yylval.sval = res;
	return VALUE;
	}
{WHERE} return WHERE;
{EQUAL} return EQUAL;
{SPACE} return SPACE;
{NE} return NE;
{GT} return GT;
{GE} return GE;
{LT} return LT;
{LE} return LE;
{ID} {  char *res = (char *)malloc(sizeof(char)*(strlen(yytext) + 1));
	strcpy(res, yytext);
	yylval.sval = res;
	return ID;
         }
. return yytext[0];
