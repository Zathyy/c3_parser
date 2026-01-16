module ast;

import std::collections::list;

typedef AstId = uint;

typedef SourceSpan = String[];

struct Ast 
{
	List{ Decleration } decls;
	List{ Statement } stmts;
	List{ Expression } exprs;

	Allocator alloc;
}

fn void ast_init(Ast* ast, Allocator alloc = mem)
{
	ast.decls.init(alloc);
	ast.stmts.init(alloc);
	ast.exprs.init(alloc);
	ast.alloc = alloc;
}

fn void ast_free(Ast* ast)
{
	ast.decls.free();
	ast.stmts.free();
	ast.exprs.free();
}

fn Decl* get_decl(Ast* ast, DeclHandle index) @inline
{
	assert(ast.decls.len() > index);
	return &ast.decls[index];
}

fn uint new_decl(Ast* ast)
{
	ast.decls.push({});
	return (uint)ast.decls.len() - 1;
}