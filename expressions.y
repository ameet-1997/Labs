%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <limits.h>
	
	// #define YYSTYPE int
	extern int yylex();

	typedef struct identifier_{
		char* a;
		int value;
		struct identifier_ *next;
	} identifier;

	identifier* head = NULL;
	identifier* tail = NULL;

	void add_node(int value, char* name)
	{	
		identifier *temp;
		identifier *gen = head;

		while(gen != NULL)
		{
			if(strcmp(gen->a, name) == 0)
			{
				temp->value = value;
				return;
			}
			gen = gen->next;
		}
		
		temp = (identifier*) malloc(sizeof(identifier));
		temp->value = value;
		temp->a = (char *) malloc(strlen(name)+1);
		strcpy(temp->a, name);
		
		if(head == NULL)
		{
			head = temp;
			tail = temp;
			tail->next = NULL;
		}
		else
		{
			tail->next = temp;
			tail = tail->next;
			tail->next = NULL;
		}

		return;
	}

	int get_value(char* a)
	{
		identifier *temp = head;

		while(temp != NULL)
		{
			if(strcmp(temp->a, a) == 0)
			{
				return temp->value;
			}
			temp = temp->next;
		}
	}

%}

%union{
	int integer;
	char* str;
}

%token<integer> NUM 
%token<str> ID
%token<integer> PLUS MINUS MUL DIV OPEN CLOSE SEMICOLON EQUALS

%type <integer> expr term factor

%start goal

%%

goal:	series
;
series:	assignment SEMICOLON series | assignment SEMICOLON | expr SEMICOLON {printf("The value of the expression is: %d\n", $1);}
;
assignment:	ID EQUALS expr {add_node($3, $1);}
;
expr:	OPEN expr CLOSE | expr PLUS term {$$ = $1+$3;}| expr MINUS term {$$ = $1-$3;} | term {$$ = $1;}
;
term:	term MUL factor {$$ = $1*$3;} | term DIV factor {$$ = $1/$3;} | factor {$$ = $1;}
;
factor:	ID {$$ = get_value($1);} | NUM {$$ = $1;} 
;

%%
int yywrap() {return 1;}
int yyerror(char* s) {fprintf(stderr,"Parse error\n");}
int main()
{
	yyparse();
	exit(0);
	return 0;
}
