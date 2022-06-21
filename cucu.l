%{
#include<stdio.h>
#include<stdlib.h>
#include "cucu.tab.h"

void yyerror(char *s);
#define yval yylval
#define fp fprintf
%}
%%    
printf        {fp(yyout,"MAIN: %s\n",yytext);yylval.str=strdup(yytext);return print;}
"double"           {fp(yyout,"TYPE: %s\n",yytext);yylval.str=strdup(yytext);return Tp;}
scanf       {fp(yyout,"MAIN: %s\n",yytext);yylval.str=strdup(yytext);return scan;}
while        {fp(yyout,"WHILE: %s\n",yytext);yval.str=strdup(yytext);return Wil;}
struct       {fp(yyout,"Struct: %s\n",yytext);yval.str=strdup(yytext);return STRUC;}
main         {fp(yyout,"MAIN: %s\n",yytext);yval.str=strdup(yytext);return ID;}
for          {fp(yyout,"FOR: %s\n",yytext);yval.str=strdup(yytext);return For;}
else          {fp(yyout,"ELSE: %s\n",yytext);yval.str=strdup(yytext);return ELEs;}
if           {fp(yyout,"IF: %s\n",yytext);yval.str=strdup(yytext);return IFs;}
char          {fp(yyout,"TYPE: %s\n",yytext);yval.str=strdup(yytext);return Tp;}
int           {fp(yyout,"TYPE: %s\n",yytext);yval.str=strdup(yytext);return Tp;}
"#include<stdio.h>" {fp(yyout,"TYPE: %s\n",yytext);yval.str=strdup(yytext);return intro;}
"char**"          {fp(yyout,"TYPE: %s\n",yytext);yval.str=strdup(yytext);return Tp;}
"char **"          {fp(yyout,"TYPE: %s\n",yytext);yval.str=strdup(yytext);return Tp;}
"char*"          {fp(yyout,"TYPE: %s\n",yytext);yval.str=strdup(yytext);return Tp;}
"char *"          {fp(yyout,"TYPE: %s\n",yytext);yval.str=strdup(yytext);return Tp;}
"return"        {fp(yyout,"RETURN: %s\n",yytext);yval.str=strdup(yytext);return RTN;}   
[,]             {fp(yyout,"COMMA: %s\n",yytext);yval.str=strdup(yytext);return com;}
[|]             {fp(yyout,"OR: %s\n",yytext);yval.str=strdup(yytext);return ORs;}
[-]             {fp(yyout,"MINUS: %s\n",yytext);yval.str=strdup(yytext);return MINUSop;}
[+]             {fp(yyout,"PLUS: %s\n",yytext);yval.str=strdup(yytext);return PLUSop;}
[&]             {fp(yyout,"AND: %s\n",yytext);yval.str=strdup(yytext);return ANDs;}
[=]            {fp(yyout,"ASSIGN: %s\n",yytext);yval.str=strdup(yytext);return ASSIGNop;}
[(]             {fp(yyout,"LEFT_PAREN: %s\n",yytext);yval.str=strdup(yytext);return LPAR;}
[)]             {fp(yyout,"RIGHT_PAREN: %s\n",yytext);yval.str=strdup(yytext);return RPAR;}
[>]             {fp(yyout,"GREATER_THAN: %s\n",yytext);yval.str=strdup(yytext);return GrT;}
[<]             {fp(yyout,"LESS_THAN: %s\n",yytext);yval.str=strdup(yytext);return LsT;}
[\d*\d]             {fp(yyout,"MULT: %s\n",yytext);yval.str=strdup(yytext);return MULTi;}
[*]{2}            {fp(yyout,"ASTS: %s\n",yytext);yval.str=strdup(yytext);return DASTs;}
[;]           {fp(yyout,"SEMICOL: %s\n",yytext);yval.str=strdup(yytext);return SEMIC;}
[{]             {fp(yyout,"LEFT_BRACE: %s\n",yytext);yval.str=strdup(yytext);return LBRA;}
[/]             {fp(yyout,"DIVIDE: %s\n",yytext);yval.str=strdup(yytext);return DIVi;}
[}]             {fp(yyout,"RIGHT_BRACE: %s\n",yytext);yval.str=strdup(yytext);return RBRA;}
[\[]            {fp(yyout,"LEFT_SQ: %s\n",yytext);yval.str=strdup(yytext);return Lsqb;}
[\]]             {fp(yyout,"RIGHT_SQ: %s\n",yytext);yval.str=strdup(yytext);return Rsqb;}
[>][=]            {fp(yyout,"GT_EQUAL: %s\n",yytext);yval.str=strdup(yytext);return GtE;}
[<][=]            {fp(yyout,"LT_EQUAL: %s\n",yytext);yval.str=strdup(yytext);return LtE;}
[!][=]            {fp(yyout,"NOT_EQUAL: %s\n",yytext);yval.str=strdup(yytext);return NEq;}
[=]{2}            {fp(yyout,"EQUALS: %s\n",yytext);yval.str=strdup(yytext);return EQu;}
["](.*)["]       {fprintf(yyout,"D_QUOTES: %s\n",yytext);yylval.str=strdup(yytext);return str;}
[/"]               {fp(yyout,"D_QUOTES: %s\n",yytext);yval.str=strdup(yytext);return DbQ;}
\/\/.*               {;}
[a-zA-Z_][a-zA-Z0-9_]*   { 
        yylval.str=strdup(yytext);
              fp(yyout,"ID : %s\n",yytext);
               return ID;}
[0-9][0-9]*   {
         yylval.nm=atoi(yytext);
         fp(yyout,"NUMBER : %d\n",atoi(yytext));
         return NUM; }         

[ \t\n]+       ; 
.            {yyerror("");};
%%

