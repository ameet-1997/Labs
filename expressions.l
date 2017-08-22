%{
	#include <stdio.h>
	#include <string.h>
	#include "expression.tab.h"
%}

%%
[ \t\n]		{;}
[0-9]+		{yylval.integer = atoi(yytext);return NUM;}
\+			{return PLUS;}
\-			{return MINUS;}
\*			{return MUL;}
\/			{return DIV;}
[A-Za-z][A-Za-z0-9]* 	{yylval.str = strdup(yytext);return ID;}
\( 		{return OPEN;}
\)			{return CLOSE;}
\;			{return SEMICOLON;}
\=			{return EQUALS;}
%%
