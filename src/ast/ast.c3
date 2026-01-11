<*
	-- AST --

	# The core idea
	- Full data oriented design, everything is just indices into arrays
*>
module ast;

import std::collections::list;


typedef AstId = uint;

<*
	which tokens produce this statement.
	struct Foo { int a; }
	^start              ^end
*>
struct TokenRange 
{
	uint start;
	uint end;
}

struct Ast 
{
	List{ Decl } decls;	
	List{ Expr } exprs;
	List{ Stmt } stmts;
	Allocator alloc;
}

fn Decl* get_decl(Ast* ast, uint index) @inline
{
	assert(ast.decls.len() > index);
	return &ast.decls[index];
}

fn uint new_decl(Ast* ast)
{
	ast.decls.push({});
	return (uint)ast.decls.len() - 1;
}