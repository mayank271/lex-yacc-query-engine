%{
//Lex file: returns token to the parser
#include "y.tab.h"
%}
AND [aA][nN]dD]
COLON [;]
DELETE [dD][eE][lL][eE][tT][eE][ ][rR][eE][cC][oO][rR][dD][ ][fF][rR][oO][mM]
FROM [fF][rR][oO][mM]
GET [gG][eE][tT]
ID [_A-Za-z][_A-Za-z0-9$]*
INSERT [iI][nN][sS][eE][rR][tT][ ][rR][eE][cC][oO][rR][dD][(]
INTO [)][iI][nN][tT][oO]
NUM [1-9][0-9]*
OR [oO][rR]
SET [sS][eE][tT]
TO [tT][Oo]
UPDATE [uU][pP][dD][aA][tT][eE][ ][rR][eE][cC][oO][rR][dD][ ][iI][nN]
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
{DELETE} return DELETE;
{FROM} return FROM;
{GET} return GET;
{INSERT} return INSERT;
{INTO} return INTO;
{NUM} return NUM;
{OR} return OR;
{SET} return SET;
{TO} return TO;
{UPDATE} return UPDATE;
{WHERE} return WHERE;
{EQUAL} return EQUAL;
{NE} return NE;
{GT} return GT;
{GE} return GE;
{LT} return LT;
{LE} return LE;
{ID} return ID;
. return yytext[0];
