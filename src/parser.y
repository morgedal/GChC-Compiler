%{
#include<string>
#include "node.hpp"
int yyerror(const char *s);
extern int yylex(void);
%}

%token<node> T_VAR T_COMMENT T_FLOAT_NUMBER T_STRING T_INT_NUMBER T_ASSIGNMENT
%token<node> T_EQUAL T_NOTEQUAL T_LESS T_LESSEQ T_GREATER T_GREATEREQ T_LPAREN 
%token<node> T_RPAREN T_LBRACE T_RBRACE T_COMMA T_SEMICOLON T_PLUS T_MINUS T_MUL
%token<node> T_DIV T_MOD T_AND T_OR T_NOT T_DEC T_INC T_RET_TYPE_OP T_CONST
%token<node> T_TYPEINT T_TYPEFLOAT T_TYPESTRING T_FUNCTION T_WHILE T_IF T_ID
%token<node> T_RETURN T_MAIN T_PRINT_OP

%type<node> program constant mainFunction function typedArgList value functionBody
%type<node> expression variableDeclaration loop condition conditionalExpression
%type<node> returnExpression functionCall argList arithmeticExpression factor
%type<node> binaryOperator unaryOperator type printExpression

%union {
    std::string *string;
    int token;
    Node* node;
    //int int_val;
    //double float_val;
}

%start program

%%

program : function program  
            { $$ = new Node(                 
                    *($1->value) + *( new std::string(" ") ) + *($2->value) + *( new std::string(" ") )
            ); 
            std::cout<<*($$->value)<<std::endl<<std::endl;
            }
    | constant program      
            { $$ = new Node(  
                *($1->value) + *( new std::string(" ") ) + *($2->value) + *( new std::string(" ") ) 
            );
            std::cout<<*($$->value)<<std::endl<<std::endl;
            }
    | T_COMMENT program     
            { $$ = new Node(   
                    *($2->value) + *( new std::string(" ") ) 
            ); 
            std::cout<<*($$->value)<<std::endl<<std::endl;
            }
    | mainFunction          
            { $$ = new Node(   
                    *($1->value) + *( new std::string(" ") )
            ); 
            std::cout<<*($$->value)<<std::endl<<std::endl;
            }
    ;

type : T_TYPEINT            
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") )
        ); }
    | T_TYPEFLOAT
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") )
        ); }
    | T_TYPESTRING
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") )
        ); }
    ;

constant : T_CONST type T_ID T_ASSIGNMENT value T_SEMICOLON
        { 
           std::string str = "";

            str += *($1->value) + *( new std::string(" ") );
            str += *($2->value) + *( new std::string(" ") );
            str += *($3->value) + *( new std::string(" ") );
            str += *($4->value) + *( new std::string(" ") );
            str += *($5->value) + *( new std::string(" ") );
            str += *($6->value) + *( new std::string(" ") );

            $$ = new Node( str ); 
        }
    ;

mainFunction : T_FUNCTION T_MAIN T_LBRACE T_RBRACE T_LPAREN functionBody T_RPAREN
        { 
           std::string str = "";

            str += "int ";
            str += *($2->value) + *( new std::string(" ") );
            str += *($3->value) + *( new std::string(" ") );
            str += *($4->value) + *( new std::string(" ") );
            str += *($5->value) + *( new std::string(" ") );
            str += *($6->value) + *( new std::string(" ") );
            str += *($7->value) + *( new std::string(" ") ); 
            
            $$ = new Node( str );
        }
    ;

function : T_FUNCTION T_ID T_LBRACE typedArgList T_RBRACE T_LPAREN functionBody T_RPAREN
        { 
            std::string str = "";

                str += "void ";
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
                str += *($4->value) + *( new std::string(" ") );
                str += *($5->value) + *( new std::string(" ") );
                str += *($6->value) + *( new std::string(" ") );
                str += *($7->value) + *( new std::string(" ") );
                str += *($8->value) + *( new std::string(" ") );

            $$ = new Node( str ); 
        }
    | T_FUNCTION T_ID T_LBRACE typedArgList T_RBRACE T_RET_TYPE_OP type T_LPAREN functionBody T_RPAREN
        { 
            std::string str = "";

                str += *($7->value) + *( new std::string(" ") ) ;
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
                str += *($4->value) + *( new std::string(" ") );
                str += *($5->value) + *( new std::string(" ") );
                str += *($8->value) + *( new std::string(" ") );
                str += *($9->value) + *( new std::string(" ") );
                str += *($10->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    ;

typedArgList : type T_ID
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") ) + *($2->value) + *( new std::string(" ") )
        ); }
    | type T_ID T_COMMA typedArgList
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") ); 
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
                str += *($4->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    ;

value : T_STRING        
        { $$ = new Node( *($1->value) ); }
    | T_INT_NUMBER      
        { $$ = new Node( *($1->value) ); }
    | T_FLOAT_NUMBER    
        { $$ = new Node( *($1->value) ); }
    ;

functionBody : expression T_SEMICOLON       
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    | expression T_SEMICOLON functionBody   
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    | T_COMMENT functionBody                
        { $$ = new Node(   
            *($2->value) + *( new std::string(" ") )
        ); }
    ;

expression : variableDeclaration    { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | loop                          { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | conditionalExpression         { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | arithmeticExpression          { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | returnExpression              { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | functionCall                  { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | printExpression               { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    ;

variableDeclaration : T_VAR type T_ID 
        { $$ = new Node(
            *($2->value) + *( new std::string(" ") ) + *($3->value) + *( new std::string(" ") )
        ); }
    | T_VAR type T_ID T_ASSIGNMENT factor
        { 
            std::string str = "";

                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
                str += *($4->value) + *( new std::string(" ") );
                str += *($5->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    ;

loop : T_WHILE T_LBRACE condition T_RBRACE T_LPAREN functionBody T_RPAREN
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
                str += *($4->value) + *( new std::string(" ") );
                str += *($5->value) + *( new std::string(" ") );
                str += *($6->value) + *( new std::string(" ") );
                str += *($7->value) + *( new std::string(" ") );
 
       
            
            $$ = new Node( str  );
        }
    ;

conditionalExpression : T_IF T_LBRACE condition T_RBRACE T_LPAREN functionBody T_RPAREN
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
                str += *($4->value) + *( new std::string(" ") );
                str += *($5->value) + *( new std::string(" ") );
                str += *($6->value) + *( new std::string(" ") );
                str += *($7->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    ;

condition : functionCall
        { $$ = new Node(   
            *($1->value) + *( new std::string(" ") )
        ); }
    | arithmeticExpression
        { $$ = new Node(   
            *($1->value) + *( new std::string(" ") )
        ); }
    ;

returnExpression : T_RETURN factor
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") ) + *($2->value) + *( new std::string(" ") )
        ); }
    | T_RETURN
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") ) 
        ); }
    ;

functionCall : T_ID T_LBRACE argList T_RBRACE
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
                str += *($4->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    ;

argList : factor 
        { $$ = new Node( *($1->value) ); }
    | factor T_COMMA argList
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    ;

arithmeticExpression : factor binaryOperator factor 
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    | unaryOperator factor
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    ;

factor : T_ID
        { $$ = new Node(  
            *($1->value) + *( new std::string(" ") ) 
        ); }
    | value 
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") ) 
        ); }
    | T_LBRACE arithmeticExpression T_RBRACE 
        { 
            std::string str = "";

                str += *($1->value) + *( new std::string(" ") );
                str += *($2->value) + *( new std::string(" ") );
                str += *($3->value) + *( new std::string(" ") );
            
            $$ = new Node( str ); 
        }
    | functionCall
        { $$ = new Node( 
            *($1->value) + *( new std::string(" ") )
        ); }
    ;

binaryOperator : T_PLUS { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_MINUS       { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_MUL         { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_DIV         { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_MOD         { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_AND         { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_OR          { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_GREATER     { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_GREATEREQ   { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_LESS        { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_LESSEQ      { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_EQUAL       { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_NOTEQUAL    { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_ASSIGNMENT  { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    ;

unaryOperator : T_NOT   { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_INC             { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    | T_DEC             { $$ = new Node(  *($1->value) + *( new std::string(" ") ) ); }
    ;

printExpression : T_PRINT_OP factor
    {
        std::string str = "";

        str += " std::cout << " ; //" 
        str += *($2->value); 
        str += " << std::endl";  //"

        $$ = new Node( str );
    }
     
%%



int yyerror(const char *s)
{
  return -1;
}

