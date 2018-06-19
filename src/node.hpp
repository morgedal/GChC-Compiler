#ifndef NODE_HPP
#define NODE_HPP

#include <iostream>
#include <string>
#include <vector>
#include <functional>

class Node
{
  public:
    Node( const char* _value );
    Node( std::string _value );
    Node( std::function<std::string(void)> _genCode );
    Node( const Node& node );
    Node(std::initializer_list<Node> _children, std::function<std::string(Node)> _genCode);
    ~Node();

    //std::string (*GenCode)();
    std::function<std::string(void)> GenCode;
    std::function<std::string(Node)> GenCode2;

    //int token;
    std::string* value;
    std::vector<Node> children;
};


#endif  //NODE_HPP