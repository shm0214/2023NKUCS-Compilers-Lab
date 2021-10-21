%{
    #include <iostream>
    #include <assert.h>
    #include "Ast.h"
    #include "SymbolTable.h"
    #include "Type.h"
    #define YYSTYPE void *
    extern Ast ast;
    int yylex();
    int yyerror( char const * );
%}
%defines

%start Program
%token ID INTEGER
%token IF ELSE
%token INT VOID
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON
%token ADD SUB OR AND LESS ASSIGN
%token RETURN

%precedence THEN
%precedence ELSE
%%
Program
    : Stmts {
        ast.setRoot((Node*)$1);
    }
    ;
Stmts
    : Stmt {$$=$1;}
    | Stmts Stmt{
        $$ = new SeqNode((StmtNode*)$1, (StmtNode*)$2);
    }
    ;
Stmt
    : AssignStmt {$$=$1;}
    | BlockStmt {$$=$1;}
    | IfStmt {$$=$1;}
    | ReturnStmt {$$=$1;}
    | DeclStmt {$$=$1;}
    | FuncDef {$$=$1;}
    ;
LVal
    : ID {
        SymbolEntry *se;
        se = identifiers->lookup((char*)$1);
        if(se == nullptr)
        {
            fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
            delete [](char*)$1;
            assert(se != nullptr);
        }
        $$ = new Id(se);
        delete [](char*)$1;
    }
    ;
AssignStmt
    :
    LVal ASSIGN Exp SEMICOLON {
        $$ = new AssignStmt((ExprNode*)$1, (ExprNode*)$3);
    }
    ;
BlockStmt
    :   LBRACE 
        {identifiers = new SymbolTable(identifiers);} 
        Stmts RBRACE 
        {
            $$ = new CompoundStmt((StmtNode*)$3);
            SymbolTable *top = identifiers;
            identifiers = identifiers->getPrev();
            delete top;
        }
    ;
IfStmt
    : IF LPAREN Cond RPAREN Stmt %prec THEN {
        $$ = new IfStmt((ExprNode*)$3, (StmtNode*)$5);
    }
    | IF LPAREN Cond RPAREN Stmt ELSE Stmt {
        $$ = new IfElseStmt((ExprNode*)$3, (StmtNode*)$5, (StmtNode*)$7);
    }
    ;
ReturnStmt
    :
    RETURN Exp SEMICOLON{
        $$ = new ReturnStmt((ExprNode*)$2);
    }
    ;
Exp
    :
    AddExp {$$ = $1;}
    ;
Cond
    :
    LOrExp {$$ = $1;}
    ;
PrimaryExp
    :
    LVal {
        $$ = $1;
    }
    | INTEGER {
        SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::intType, atoi((char*)$1));
        $$ = new Constant(se);
        delete [](char*)$1;
    }
    ;
AddExp
    :
    PrimaryExp {$$ = $1;}
    |
    AddExp ADD PrimaryExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::ADD, (ExprNode*)$1, (ExprNode*)$3);
    }
    |
    AddExp SUB PrimaryExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::SUB, (ExprNode*)$1, (ExprNode*)$3);
    }
    ;
RelExp
    :
    AddExp {$$ = $1;}
    |
    RelExp LESS AddExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::LESS, (ExprNode*)$1, (ExprNode*)$3);
    }
    ;
LAndExp
    :
    RelExp {$$ = $1;}
    |
    LAndExp AND RelExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::AND, (ExprNode*)$1, (ExprNode*)$3);
    }
    ;
LOrExp
    :
    LAndExp {$$ = $1;}
    |
    LOrExp OR LAndExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::OR, (ExprNode*)$1, (ExprNode*)$3);
    }
    ;
Type
    : INT {
        $$ = TypeSystem::intType;
    }
    | VOID {
        $$ = TypeSystem::voidType;
    }
    ;
DeclStmt
    :
    Type ID SEMICOLON {
        SymbolEntry *se;
        se = new IdentifierSymbolEntry((Type*)$1, (char*)$2, identifiers->getLevel());
        identifiers->install((char*)$2, se);
        $$ = new DeclStmt(new Id(se));
        delete [](char*)$2;
    }
    ;
FuncDef
    :
    Type ID {
        Type *funcType;
        funcType = new FunctionType((Type*)$1,{});
        SymbolEntry *se = new IdentifierSymbolEntry(funcType, (char*)$2, identifiers->getLevel());
        identifiers->install((char*)$2, se);
        delete [](char*)$2;
        $2 = se;
        identifiers = new SymbolTable(identifiers);
    }
    LPAREN RPAREN
    BlockStmt
    {
        $$ = new FunctionDef((SymbolEntry*)$2, (StmtNode*)$6);
        SymbolTable *top = identifiers;
        identifiers = identifiers->getPrev();
        delete top;
    }
    ;
%%

int yyerror(char const* message)
{
    std::cerr<<message<<std::endl;
    return -1;
}
