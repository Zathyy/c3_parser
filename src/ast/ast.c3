<*
	-- AST --

	# The core idea
	- Full data oriented design, everything is just indices into arrays

	TODO: 
		- add debug to print a single ast nod
		- add debug file to dump the whole ast to a json file
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

struct Param
{
	uint name;   // IDENT token index
	uint type;    // index into Expr list
	TokenRange range;
}

struct Ast 
{
	List{ Decl } decls;	
	List{ Param } params;
	List{ Expr } exprs;
	List{ Stmt } stmts;
	Allocator alloc;
}

fn void ast_init(Ast* ast, Allocator alloc = mem)
{
	ast.decls.init(alloc);
	ast.params.init(alloc);
	ast.exprs.init(alloc);
	ast.stmts.init(alloc);
	ast.alloc = alloc;
}

fn void ast_free(Ast* ast)
{
	ast.decls.free();
	ast.params.free();
	ast.exprs.free();
	ast.stmts.free();
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