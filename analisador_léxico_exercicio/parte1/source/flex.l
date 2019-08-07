/* 
Crie um Analisador Léxico utilizando Flex que consiga gerar os tokens
do arquivo de entrada "exercicio01.in" que consiste em um código na
linguagem C. O analisador deverá identificar todos os tokens referentes a:

1. Identificadores
2. Números Inteiros
3. Números de Ponto Flutuante
4. Palavras reservadas
5. Operadores Matemáticos e Relacionais
6. Chaves, Colchetes e Chaves

utilize os exemplos no diretório "flex" como ponto de partida.
*/

/* SEÇÃO DE DEFINIÇÕES */

%{
    /*
        Definições que estarão disponíveis 
            - variáveis
            - constantes
        O que for aqui será copiado para o arquivo *.yy.c
    
        Variáveis declaradas aqui estarão acessível nas funções yylex() e 
        main().
    */
    int contador = 0;
%}

/* Definições de Nomes */
BIBLIOTECA 		[\<][a-z]*\.[h][\>]
RESERVADAS	"typedef"|"const"|"#include"|"main"|"printf"|"scanf"|"asm"|"auto"|"break"|"continue"|"enum"|"extern"|"goto"|"register"|"return"|"signed"|"sizeof"|"static"|"union"|"void"|"volatile"
TIPOS "int"|"float"|"char"|"double"|"unsigned int"|"unsigned char"|"short int"|"long int"|"long double"|"unsigned long int"|"unsigned short int"
STRUCT "struct"|"typedef struct"
ENDERECO				[&]([_a-zA-Z][_a-zA-Z0-9]*)
OPERADOR_CONDICIONAL "if"|"else"|"else if"|"switch case"|"default"
OPERADOR_REPETICAO "for"|"while"|"do"
OPERADOR_MATEMATICO "+"|"-"|"*"|"/"|"%"
OPERADOR_LOGICO "||"|"&&"|"!"
OPERADOR_BIT "&"|"|"|"^"|"~"|">>"|"<<"
OPERADOR_COMPARACAO ">="|"<="|"!="|"=="|">"|"<"
OPERADOR_ATRIBUICAO "="|"+="|"-="|"*="|"/="|"%="|"<<="|">>="|"&="|"^="|"|="
INTEIROS [-+]?[0-9]+ 
FLOATS [-+]?[0-9]+\.?[0-9]+
SIMBOLOS "("|")"|"{"|"}"|","
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]* 
STRING 		\"([^\\\"]|\\.)*\"
CARACTER 								(\')(.)(\')
VETOR 									([_a-zA-Z][_a-zA-Z0-9]*)(\[)([0-9]+)|([a-zA-Z]+)(\])
FIM_LINHA			";"



/* FIM DA SEÇÃO DE DEFINIÇÕES */

%%
    /* SEÇAO DE REGRAS 
        Uma entrada por linha no formato:
        
        padrão  ação

    */
{OPERADOR_REPETICAO}   {printf("\n| repeticao: %s |", yytext); contador++;}
{OPERADOR_CONDICIONAL}   {printf("\n| condicionais: %s |", yytext); contador++;}
{TIPOS}   {printf("\n| tipos: %s |", yytext); contador++;}
{BIBLIOTECA}   {printf("\n| biblioteca: %s |", yytext); contador++;}
{OPERADOR_LOGICO}   {printf("\n| operador logico: %s |", yytext); contador++;}
{OPERADOR_BIT}   {printf("\n| operador bit a bit: %s |", yytext); contador++;}
{OPERADOR_COMPARACAO}   {printf("\n| operador comparacao: %s |", yytext); contador++;}
{OPERADOR_ATRIBUICAO}   {printf("\n| Operador atribuiçao: %s |", yytext); contador++;}
{STRUCT}   {printf("\n| struct: %s |", yytext); contador++;}
{OPERADOR_MATEMATICO}   {printf("\n| op_mat: %s |", yytext); contador++;}
{INTEIROS}         {printf("\n| inteiros: %s |", yytext); contador++;}
{FLOATS}   {printf("\n| float: %s |", yytext); contador++;}
{RESERVADAS}         {printf("\n| reservadas: %s |", yytext); contador++;}
{SIMBOLOS}   {printf("\n| simbolos: %s |", yytext); contador++;}
{STRING}         {printf("\n| string: %s |", yytext); contador++;}
{CARACTER}	{printf("\n| caracter: %s |", yytext); contador++;}
{IDENTIFICADOR}         {printf("\n| identificador: %s |", yytext); contador++;}
{VETOR}	{printf("\n| vetor: %s", yytext); contador++;}
{FIM_LINHA} {printf("\n| simbolo fim de linha: %s|", yytext); contador++;}
{ENDERECO}	{printf("\n| endereço: %s|", yytext); contador++;}


<<EOF>>                 return 0;
    
%%

/*
Seção de Código do Usuário
*/

int yywrap() {}
int main() {
    printf("Iniciando Análise Léxica...\n---\n");
    yylex();
    printf("Foram encontradas %d ocorrências.\n", contador);
    printf("---\nÁnalise Finalizada!\n");
    
    return 0;
}
