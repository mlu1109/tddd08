term(id(X)) -->
  [id(X)],
  {atom(X)}.
term(num(X)) -->
  [num(X)],
  {number(X)}.

factor(X + Y) -->
  term(X), 
  [+],
  factor(Y).
factor(X) --> 
  term(X).

expr(X * Y) -->
  factor(X),
  [*],
  expr(Y).
expr(X) -->
  factor(X).

bool(X < Y) -->
  expr(X),
  [<],
  expr(Y).
bool(X > Y) -->
  expr(X),
  [>],
  expr(Y).

cmd(skip) --> 
  [skip].
cmd(set(id(I), E)) -->
  term(id(I)),
  [:=],
  expr(E).

cmd(if(B, C1, C2)) -->
  [if],
  bool(B),
  [then],
  pgm(C1),
  [else],
  pgm(C2),
  [fi].
cmd(while(B, C)) -->
  [while],
  bool(B),
  [do],
  pgm(C),
  [od].

pgm(C) --> cmd(C).
pgm(seq(C1, C2)) -->
  cmd(C1),
  [;],
  pgm(C2).

parse(Tokens, AbstStx) :- 
  pgm(AbstStx, Tokens, []).

run(In, String, Out) :-
  scan(String, Tokens),
  parse(Tokens, AbstStx),
  execute(In, AbstStx, Out).