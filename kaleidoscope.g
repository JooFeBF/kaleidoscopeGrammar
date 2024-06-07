start: program;

program: ((function)+ | (expression)+)+;

function: define arg expr;

define: 'def';

arg: name '\(' argumentos '\)';

expr: '{' (expression)+ '}';

argumentos: variable | variable ',' argumentos;
expression: term | expression ('\+'|'-'| conjuncion | disyuncion) term;

term: factor | term '\*' factor | term '/' factor;

factor: numeroentero | variable | bool | '-' factor | '¬' factor | '~' factor | '\(' expression '\)' | variable '\(' argumentos '\)' | '[{},\(\)]';
bool: 'true' | 'false';
conjuncion: '&&';
disyuncion: '\|\|';
negacion: '¬' | '~';
numerononegativo: '[0]' | '[1-9][0-9]*';
numeroentero: '[0]|(\-|\+)?[1-9][0-9]*';
numeroflotante: '[0]|(\-|\+)?[1-9][0-9]*(\.)?[0-9]+';
variable: '[a-zA-Z_\.][\w_]*';
name: '[a-zA-Z_\.][\w_]*';

WS: '[ \t\r\n]+' (%ignore);
