start: program;

program: (function | functioncall | class | expression | conditionals)+;
function: 'def' funcname '\(' arguments? '\)' '{' (expression | conditionals | createobject | list | listoperations)+ '}';
class: 'class' funcname '{' classbody+ '}';

conditionals: 'condicional' '\(' expression '\)' '{'  (expression | conditionals | createobject | list | listoperations)+ '}' ('else' '{'  (expression | conditionals | createobject | list | listoperations)+  '}')?;

objectproperty: 'this.' variable '=' variable;
funcconstructor:  'def' 'constructor' '\(' arguments? '\)' '{' objectproperty+ '}';
separatedargument: arguments;
arguments: argv | argv ',' separatedargument;
separatedcallarguments: callarguments;
callarguments: arguments | expression | expression ',' callarguments | arguments ',' callarguments;
functioncall: funcname '\(' callarguments? '\)';
createobject: 'nuevo' funcname '\(' callarguments? '\)';
classbody: funcconstructor;

expressions: expression;
expression: negation expressions | negativesign expressions | term | (term | expressions)  (operations | negativesign) (term | expressions) | '\(' expressions '\)';
list: '\'' '\(' listbody '\)';
listbody:  term | null | term ',' listbody | null ',' listbody;
term: positivenumber | floatnumber | variable | '\(' term '\)' | bool | functioncall; 
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


COMMENT: '/\*' '.*' '\*/'  (%ignore);
WS: '[ \t\r\n]+' (%ignore);
