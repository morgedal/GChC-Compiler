#ifndef NODE_HPP
#define NODE_HPP

#include <iostream>
#include <string>
#include <vector>
#include <functional>


/*
* Now this class is little overkill, but it can be helpful when adding
* some more advanced stuff
*/
class Node
{
  public:
    Node( const char* _value );
    Node( std::string _value );
    Node( const Node& node );
    ~Node();

    std::string* value;
};

#endif  //NODE_HPP