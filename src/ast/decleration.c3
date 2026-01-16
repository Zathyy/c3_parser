module ast;

// Decleration -> (Top-level things)

typedef DeclHandle = uint;

enum DeclKind : uint (String name)
{
	FUNCTION = "FUNCTION",
	
}

struct Decl
{
	DeclKind kind;

	union 
	{
		FunctionDecl function;
	}
}

struct FunctionDecl
{

}