module ast;

// Statement -> (Control flow)

typedef StmtHandle = uint;

enum StmtKind : uint (String name)
{
	BODY = "BODY"
	RETURN = "RETURN",
}

struct Stmt 
{
	StmtKind kind;

	union 
	{
		BodyStmt body;
		ReturnStmt return;
	}
}

// Body scope: { ... }
struct BodyStmt 
{

}

// return: return foo;
struct ReturnStmt 
{

}