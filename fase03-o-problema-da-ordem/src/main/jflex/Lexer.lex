package br.maua.cic303;

import java_cup.runtime.Symbol;

%%

/* Configurações do JFlex para o CUP */
%class Lexer
%public
%cup
%line
%column

%{
    /* Método auxiliar para criar os objetos Symbol que o parser.cup espera */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

/* Definições Regulares */
LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
Identifier     = [a-zA-Z][a-zA-Z0-9]*
NumberLiteral  = [0-9]+(\.[0-9]+)?

%%

<YYINITIAL> {

    {WhiteSpace}    { /* Ignora */ }

    /* Palavras-chave */
    "if"            { return symbol(sym.IF); }
    "then"          { return symbol(sym.THEN); }
    "else"          { return symbol(sym.ELSE); }
    "while"         { return symbol(sym.WHILE); }

    /* Operadores Relacionais */
    "=="            { return symbol(sym.REL_OP, yytext()); }
    "!="            { return symbol(sym.REL_OP, yytext()); }
    "<="            { return symbol(sym.REL_OP, yytext()); }
    ">="            { return symbol(sym.REL_OP, yytext()); }
    "<"             { return symbol(sym.REL_OP, yytext()); }
    ">"             { return symbol(sym.REL_OP, yytext()); }

    /* Operador de Atribuição */
    "="             { return symbol(sym.ASSIGN); }

    /* Operadores Aditivos */
    "+"             { return symbol(sym.ADD_OP, yytext()); }
    "-"             { return symbol(sym.ADD_OP, yytext()); }

    /* Operadores Multiplicativos */
    "*"             { return symbol(sym.MUL_OP, yytext()); }
    "/"             { return symbol(sym.MUL_OP, yytext()); }

    /* Delimitadores */
    ";"             { return symbol(sym.SEMI); }
    "("             { return symbol(sym.LPAREN); }
    ")"             { return symbol(sym.RPAREN); }
    "{"             { return symbol(sym.LBRACE); }
    "}"             { return symbol(sym.RBRACE); }

    /* Identificadores e Números */
    {Identifier}    { return symbol(sym.ID, yytext()); }
    {NumberLiteral} { return symbol(sym.NUMBER, yytext()); }
}

[^] { 
    throw new Error("Caractere inválido <" + yytext() + "> na linha " + (yyline+1));
}