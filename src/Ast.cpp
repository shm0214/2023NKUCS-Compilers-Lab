#include "Ast.h"
#include "SymbolTable.h"
#include "Type.h"
#include <iomanip>

int Node::counter = 0;

Node::Node()
{
    seq = counter++;
}

void Ast::output(std::ofstream &out)
{
    out << "program" << std::endl;
    if(root != nullptr)
        root->output(out, 4);
}

void BinaryExpr::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "BinaryExpr\top: ";
    switch(op)
    {
        case ADD:
            out << "add";
            break;
        case SUB:
            out << "sub";
            break;
        case AND:
            out << "and";
            break;
        case OR:
            out << "sub";
            break;
        case LESS:
            out << "less";
            break;
    }
    out << std::endl;
    expr1->output(out, level + 4);
    expr2->output(out, level + 4);
}

void Constant::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "IntegerLiteral\tvalue: ";
    out << symbolEntry->toStr()
        << "\ttype: " << symbolEntry->getType()->toStr() << std::endl;
}

void Id::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "Id\tname: ";
    out << symbolEntry->toStr();
    out << "\tscope: " << dynamic_cast<IdentifierSymbolEntry*>(symbolEntry)->getScope() 
        << "\ttype: " << symbolEntry->getType()->toStr() << std::endl;
}

void CompoundStmt::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "CompoundStmt" << std::endl;
    stmt->output(out, level + 4);
}

void SeqNode::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "Sequence" << std::endl;
    stmt1->output(out, level + 4);
    stmt2->output(out, level + 4);
}

void DeclStmt::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "DeclStmt" << std::endl;
    id->output(out, level + 4);
}

void IfStmt::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "IfStmt" << std::endl;
    cond->output(out, level + 4);
    thenStmt->output(out, level + 4);
}

void IfElseStmt::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "IfElseStmt" << std::endl;
    cond->output(out, level + 4);
    thenStmt->output(out, level + 4);
    elseStmt->output(out, level + 4);
}

void ReturnStmt::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "ReturnStmt" << std::endl;
    retValue->output(out, level + 4);
}

void AssignStmt::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ' << "AssignStmt" << std::endl;
    lval->output(out, level + 4);
    expr->output(out, level + 4);
}

void FunctionDef::output(std::ofstream&out, int level)
{
    out << std::setw(level) << ' ';
    out << "FunctionDefine function name: " << se->toStr();
    out << "\ttype: " << se->getType()->toStr() << std::endl;
    stmt->output(out, level + 4);
}
