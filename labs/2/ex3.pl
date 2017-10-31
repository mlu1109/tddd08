% Binding Environment
bind(id(I), num(N), [], [[I, N]]).
bind(id(I), num(N), [[I, _]|Rest], [[I, N]|Rest]).
bind(I, N, [[HI, HN]|Si], [[HI, HN]|Sj]) :-
  bind(I, N, Si, Sj).
  
% Arithmetic expressions
eval(Si, id(I), num(Val)) :-
  member([I, Val], Si).
eval(_, num(Val), num(Val)).
eval(Si, (A+B), num(Val)) :-
  eval(Si, A, num(VA)),
  eval(Si, B, num(VB)),
  Val is VA + VB.
eval(Si, (A-B), num(Val)) :-
  eval(Si, A, num(VA)),
  eval(Si, B, num(VB)),
  Val is VA - VB.
eval(Si, (A*B), num(Val)) :-
  eval(Si, A, num(VA)),
  eval(Si, B, num(VB)),
  Val is VA * VB.

% Boolean expressions
eval(Si, (A>B), tt) :-
  eval(Si, A, num(VA)),
  eval(Si, B, num(VB)),
  VA > VB.
eval(Si, (A>B), ff) :-
  eval(Si, A, num(VA)),
  eval(Si, B, num(VB)),
  VA =< VB.
eval(Si, (A<B), tt) :-
  eval(Si, A, num(VA)),
  eval(Si, B, num(VB)),
  VA < VB.
eval(Si, (A<B), ff) :-
  eval(Si, A, num(VA)),
  eval(Si, B, num(VB)),
  VA > VB.

% Commands
execute(Si, skip, Si).
execute(Si, set(I, E), Sj) :-
  eval(Si, E, Val),
  bind(I, Val, Si, Sj).
execute(Si, if(Cond, Exec, _), Sj) :-
  eval(Si, Cond, tt),
  execute(Si, Exec, Sj).
execute(Si, if(Cond, _, Exec), Sj) :-
  eval(Si, Cond, ff),
  execute(Si, Exec, Sj).
execute(Si, seq(First, Second), Sk) :-
  execute(Si, First, Sj),
  execute(Sj, Second, Sk).
execute(Si, while(Cond, Exec), Sk) :-
  eval(Si, Cond, tt),
  execute(Si, Exec, Sj),
  execute(Sj, while(Cond, Exec), Sk).
execute(Si, while(Cond, _), Si) :-
  eval(Si, Cond, ff).