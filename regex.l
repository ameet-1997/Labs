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
\*			{return PRODUCT;}
\/			{return DIV;}
%%