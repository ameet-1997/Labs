%{
	#include <stdio.h>
	#include <string.h>
	#include "parse.tab.h"
%}

%%
[ \t\n]		{;}
[0-9]+		{return NUM;}
\+			{return PLUS;}
\-			{return MINUS;}
\*			{return MUL;}
\/			{return DIV;}
[[a-z]|[A-Z]][[0-9]|[a-z]|[A-Z]] 	{return ID;}
\( 			{return OPEN;}
\)			{return CLOSE;}
;			{return SEMICOLON;}
=			{return EQUALS;}
%%
