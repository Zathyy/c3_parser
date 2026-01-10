module ast;

import std::collections::list;

struct Ast 
{
	List{ Decl } decls;	
	List{ Expr } exprs;
	List{ Stmt } stmts;
}