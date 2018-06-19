#include "node.hpp"

Node::Node(const char *_value)
{
    value = new std::string(_value);
}

Node::Node( std::string _value)
{
    value = new std::string(_value);
}

Node::Node( std::function<std::string(void)> _genCode) : GenCode(_genCode)
{
}

Node::Node(std::initializer_list<Node> _children, std::function<std::string(Node)> _genCode ) :
    children( _children ), GenCode2( _genCode )
{
}

Node::Node(const Node &node)
{
    GenCode = node.GenCode;
    value = new std::string( *(node.value) );
    children = node.children;
}

Node::~Node()
{
    delete value;
    value = nullptr;
}