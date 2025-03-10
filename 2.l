%option noyywrap
%{ 
int COMMENT=0; 
%} 

identifier[a-zA-Z][a-zA-Z0-9]* 

%% 
#.* {printf("\n %s is a preprocessor directive",yytext); } 
 int |float | void | main | if | else | printf | scanf | for | 
char | getch | 
while {printf("\n %s is a keyword",yytext);}"/*" {COMMENT=1;} 
"*/" {COMMENT=0;} 
{identifier}\( {if(!COMMENT)printf("\n Function:\t %s",yytext);} 
\{ {if(!COMMENT)printf("\n Block begins");} 
\} {if(!COMMENT)printf("\n Block ends");} 
{identifier}(\[[0-9]*\])? {if(!COMMENT)printf("\n %s is an Identifier",yytext);} 
\".*\" {if(!COMMENT)printf("\n %s is a string",yytext);} 
[0-9]+ {if(!COMMENT)printf("\n %s is a number",yytext);} 
\)(\;)? {if(!COMMENT)printf("\t");ECHO;printf("\n");} 
\(ECHO; 
= {if(!COMMENT)printf("\n %s is an Assignment operator",yytext);} 
\<= | 
\>= | 
\< | 
== {if(!COMMENT)printf("\n %s is a relational operator",yytext);} 
.|\n 
%% 
int main(int argc, char **argv) 
{ 
 if(argc>1) 
	{ 
	FILE*file;  
	file=fopen(argv[1],"r"); if(!file) 
	{ 
	printf("\n Could not open the file:%s ",argv[1]); exit(0); 
	} 
	yyin=file; 
	} 
yylex(); printf("\n\n"); 
return 0; 
} 

 
int yywrap() 
{
   return 1;
}
