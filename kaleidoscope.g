start: program;

program: (function | functioncall | classfunction)+;
function: 'def' funcname '\(' arguments? '\)' '{' (expression | conditionals | classcall)+ '}';
classfunction: 'clase' funcname '{' classbody+ '}';

conditionals: 'condicional' '\(' expression '\)' '{' expression '}' ('else' '{' expression '}')?;

arguments: argv | argv ',' arguments;
callarguments: arguments | expression | expression ',' callarguments | arguments ',' callarguments;
functioncall: funcname '\(' callarguments? '\)';
classcall: 'nuevo' funcname '\(' callarguments? '\)';
classbody: (variable '\.' variable '=' expression) | (variable '\.' variable '\(' callarguments? '\)') | (variable '\.' variable) | function | expression | conditionals;

expression: negation expression | negativesign expression | term | (term | expression)  (operations | negativesign) (term | expression) | '\(' expression '\)';
// list: '\'' '\(' term | term ',' | null ')';
term: positivenumber | floatnumber | variable | '\(' term '\)' | bool | functioncall; 

operations: '[+/*]' | logic;
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



WS: '[ \t\r\n]+' (%ignore);
