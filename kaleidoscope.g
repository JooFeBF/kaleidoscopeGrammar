start: expression;

// function: 'def' '.+' '\(' argumentos '\)' '{' (expression ';')+ '}';
// argumentos: variable | variable ',' argumentos;
// variable: '[a-zA-Z_\.][\w_]*';
expression: term | expression ('\+'|'-'| conjuncion | disyuncion) term;

term: factor | term '\*' factor | term '/' factor;

factor: numeroentero | bool | '-' factor | '¬' factor | '~' factor | '\(' expression '\)';
bool: 'true' | 'false';
conjuncion: '&&';
disyuncion: '\|\|';
negacion: '¬' | '~';
numerononegativo: '[0]' | '[1-9][0-9]*';
numeroentero: '[0]|(\-|\+)?[1-9][0-9]*';
numeroflotante: '[0]|(\-|\+)?[1-9][0-9]*(\.)?[0-9]+';

WS: '[ \t\r\n]+' (%ignore);
