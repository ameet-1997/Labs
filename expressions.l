%{
	#include <stdio.h>
	#include <string.h>
	#include "expressions.tab.h"
%}

%%
[ \t\n]		{;}
[0-9]+		{return NUM;}
\+			{return PLUS;}
\-			{return MINUS;}
\*			{return MUL;}
\/			{return DIV;}
[a-zA-Z][a-zA-Z0-9]* 	{return ID;}
\( 			{return OPEN;}
\)			{return CLOSE;}
\;			{return SEMICOLON;}
=			{return EQUALS;}

%%