#include "node.hpp"

Node::Node(const char *_value)
{
    value = new std::string(_value);
}

Node::Node( std::string _value)
{
    value = new std::string(_value);
}

Node::Node(const Node &node)
{
    value = new std::string( *(node.value) );
}

Node::~Node()
{
    delete value;
}

Node* rootNode = nullptr;