%{
#include<stdlib.h>
#include<string.h>
#include<stdio.h>
#define fp fprintf
int yylex();

FILE *out;
int yywrap(void) {
 return 1;
} 
void yyerror(char *s) {fp(out,"Error\n");}

%}

%union{
int nm;
char *str;
}

%token<str> ID prnt  IFs  ELEs Wil LPAR RPAR ASSIGNop SEMIC PLUSop MINUSop MULTi DIVi DASTs LBRA RBRA Lsqb Rsqb GtE LtE LsT GrT EQu NEq ANDs ORs Tp com RTN  DbQ intro For str print scan STRUC
%token<nm> NUM

%%

begin : program_begins         
        | begin program_begins
        ;

program_begins : var_decl 
		| intro
                | func_decl | pr_st | sc_st
                | func_defn 
                | if_st | strt_st
                | while_st 
                | for_stmt
                | statement
                ;
pr_st : print LPAR str RPAR SEMIC
      ;
sc_st : scan LPAR str com stdp RPAR SEMIC
     ;
stdp : ANDs ID | stdp com ANDs ID
      ;            
strt_st: STRUC ID LBRA func_body RBRA SEMIC
       ;
        
var_decl: Tp ID SEMIC  {fp(out,"Local Var-%s\n",$2);} | Tp ID com ID SEMIC  {fp(out,"Local Var-%s\n",$2);} 
          | Tp ID ASSIGNop expr SEMIC  {fp(out,"Local Var-%s\n",$2);} 
          | Tp  ID Lsqb expr Rsqb  ASSIGNop expr SEMIC  {fp(out,"Identifier -%s ",$1);} 
          | Tp  ID Lsqb expr Rsqb SEMIC  {fp(out,"Identifier-%s  ",$2);} 
          ;
          
          
func_decl : Tp ID LPAR args RPAR SEMIC  {fp(out,"variable -%s ",$1);fp(out,"Function declared\n");} 
            | ID LPAR args RPAR SEMIC   {fp(out,"variable -%s ",$1);} 
            | RTN expr SEMIC   {fp(out," \nReturn ");} 
            | RTN LPAR expr RPAR SEMIC  {fp(out,"\nReturn ");}
           ;
            
func_defn : Tp ID LPAR args RPAR LBRA func_body RBRA  {fp(out,"Function CALL\n");} 
           | Tp ID LPAR  RPAR LBRA func_body RBRA  {fp(out,"Function CALL\n");} 

           ;

args : Tp ID {fp(out,"function argument-%s\n",$2);} 
      | ID   {fp(out," Variable- %s\n",$1);}
      | args com Tp ID  {fp(out," Variable- %s\n",$4);}
      ;
if_st : IFs LPAR expr RPAR LBRA func_body RBRA  {fp(out,"Identifier- if ");} |
IFs LPAR expr RPAR  statement ELEs LBRA func_body RBRA   {fp(out,"Identifier- if ");} |
IFs LPAR expr RPAR  statement ELEs statement  {fp(out,"Identifier- if ");} 
       | IFs LPAR expr RPAR LBRA func_body RBRA ELEs LBRA func_body RBRA {fp(out,"\nIdentifier- if\n");fp(out,"\nIdentifier- else\n");}
       |   IFs LPAR expr RPAR LBRA func_body RBRA ELEs statement {fp(out,"\nIdentifier- if\n");fp(out,"\nIdentifier- else\n");}
       
       ;
       
while_st : Wil LPAR expr RPAR LBRA func_body RBRA   {fp(out,"\nIdentifier - while  ");}   
         ;
         
for_stmt : For LPAR var_decl  expr SEMIC expr RPAR LBRA func_body RBRA  {fp(out,"\nIdentifier - for  ");}   
            ;

func_body : program_begins  {fp(out,"Function body\n ");}
           | func_body program_begins
           ; 

statement :     ID ASSIGNop expr SEMIC         {fp(out," Var-%s  ",$1);} 
                | expr SEMIC           
                | Tp  ID Lsqb expr Rsqb  {fp(out," Var-%s  ",$1);}
                 | statement SEMIC
          
                | RTN ID SEMIC
                ;
                
expr : prime_expr 
       | expr PLUSop expr {fp(out," %s ",$2);}
       | expr GtE expr    {fp(out," %s ",$2);}
       | expr LtE expr    {fp(out," %s ",$2);}
       | expr LsT expr    {fp(out," %s ",$2);}
       | expr GrT expr    {fp(out," %s ",$2);}
       | expr EQu expr    {fp(out," %s ",$2);}
       | expr NEq expr    {fp(out," %s ",$2);}
       | expr ANDs expr   {fp(out," %s ",$2);}
       | expr ORs expr     {fp(out," %s ",$2);}
       | expr MINUSop expr {fp(out," %s ",$2);}
       | expr DIVi expr    {fp(out," %s ",$2);}
       | expr MULTi expr   {fp(out," %s ",$2);}
       | Lsqb expr Rsqb   
       | expr com expr    | ID PLUSop PLUSop {fp(out," postfixop ");}| ID MINUSop MINUSop {fp(out," postfixop ");}
       | LPAR expr RPAR     
       | ID expr
       ;
               
prime_expr : NUM    {fp(out,"  constant: %d  ",$1);}
            | ID   {fp(out,"  variable: %s ",$1);}
            ;


%%



int main(int argc[],char *argv[]){
extern FILE *yyin,*yyout;
yyin=fopen(argv[1],"r");
yyout=fopen("Lexer.txt","w");
out=fopen("Parser.txt","w");
yyparse();

return 0;
}
