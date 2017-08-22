%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <limits.h>
	
	#define YYSTYPE int
	extern int yylex();

	typedef struct identifier_{
		char* a;
		int value;
		identifier *next;
	} identifier;

	identifier* head = NULL, tail = NULL;
	void add_node(int value, char* name, identifier *head, identifier *tail)
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
	}

	int get_value(char* a, identifier *head)
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

		return INT_MIN;
	}

	bool exists()

%}

%union{
	int integer;
	char* str;
}

%token<integer> PLUS MINUS MUL DIV NUM OPEN CLOSE SEMICOLON EQUALS
%token<str> ID

%start goal

%%

goal:	series
series:	assignment SEMICOLON series | assignment SEMICOLON
assignment:	ID EQUALS expr {add_node($3, $1, head, tail);}
expr:	OPEN expr CLOSE | expr PLUS term {$$ = $1+$3;}| expr MINUS term {$$ = $1-$3;} | term
term:	term MUL factor {$$ = $1*$3;} | term DIV factor {$$ = $1/$3;} | factor
factor:	ID {return get_value($1, head);} | NUM {return $1;}

%%
int yywrap() {return 1;}
int yyerror(char* s) {fprintf(stderr,"Parse error\n");}
main()
{

	yyparse();
	exit(0);
}