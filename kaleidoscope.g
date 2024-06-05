start: function | expression;

function: '(def)$' '([a-zA-Z_]+)$' '\(' argumentos '\)' '{' (expression)+ '}';
argumentos: variable | variable ',' argumentos;
expression: term | expression ('\+'|'-'| conjuncion | disyuncion) term;

term: factor | term '\*' factor | term '/' factor;

factor: numeroentero | variable | bool | '-' factor | '¬' factor | '~' factor | '\(' expression '\)';
bool: 'true' | 'false';
conjuncion: '&&';
disyuncion: '\|\|';
negacion: '¬' | '~';
numerononegativo: '[0]' | '[1-9][0-9]*';
numeroentero: '[0]|(\-|\+)?[1-9][0-9]*';
numeroflotante: '[0]|(\-|\+)?[1-9][0-9]*(\.)?[0-9]+';
variable: '[a-zA-Z_\.][\w_]*';

WS: '[ \t\r\n]+' (%ignore);
