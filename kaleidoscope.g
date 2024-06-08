start: program;

program: (function | functioncall | class | expressions | conditionals)+;
function: 'def' funcname '\(' separatedargument? '\)' '{' (expressions | conditionals | createobject | listoperations)+ '}';
class: 'class' funcname '{' classbody+ '}';

conditionals: 'condicional' '\(' expressions '\)' '{'  (expressions | conditionals | createobject  | listoperations)+ '}' elseconditional?;
elseconditional:  'else' '{'  (expressions | conditionals | createobject | list | listoperations)+  '}';
objectproperty: 'this.' variable '=' variable;
funcconstructor:  'def' 'constructor' '\(' separatedargument? '\)' '{' objectproperty+ '}';
separatedargument: arguments;
arguments: argv | argv comma arguments;
separatedcallarguments: callarguments;
callarguments: arguments | expression | expression comma callarguments | arguments comma callarguments;
functioncall: funcname '\(' separatedcallarguments? '\)';
createobject: 'nuevo' funcname '\(' separatedcallarguments? '\)';
classbody: funcconstructor;

expressions: expression;
expression: negation expression | negativesign expression | term | (term | expression)  (operations | negativesign) (term | expression) | openparenthesis expression closeparenthesis;
list: '\'' '\(' listbody '\)';
listbody:  term | null | term comma listbody | null comma listbody;
term: positivenumber | floatnumber | variable | bool | functioncall; 
listoperations: car | cdr | empty;


car: 'car' '\(' list '\)';
cdr: 'cdr' '\(' list '\)';
empty: 'empty' '\(' list '\)';
operations: '[+/*%]' | logic;
negation: '~' | '¬';
negativesign: '-';
logic: '<' | '<=' | '==' | '>' | '>=' | '!=' | '&&' | '\|\|';
variable: '\w+';
argv: '\w+';
funcname: '\w+';
floatnumber: positivenumber '\.' afterdotnumber;
afterdotnumber: '\d+';
positivenumber: '[0]|[1-9]\d*';
bool: 'true' | 'false';
null: 'nil';
openparenthesis: '\(';
closeparenthesis:  '\)';
comma: ',';

COMMENT: '/\*' '.*' '\*/'  (%ignore);
WS: '[ \t\r\n]+' (%ignore);
