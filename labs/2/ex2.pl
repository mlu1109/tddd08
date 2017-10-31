append1([],L,L). 
append1([H|T],L2,[H|L3])  :-  append(T,L2,L3).

% Permutation 1
middle1(X, [X]).
middle1(X, [First|Xs]) :-
  append1(Middle, [Last], Xs),
  middle1(X, Middle).

% Permutation 2
middle2(X, [First|Xs]) :-
  append1(Middle, [Last], Xs),
  middle2(X, Middle).
middle2(X, [X]).

% Permutation 3
middle3(X, [X]).
middle3(X, [First|Xs]) :-
  middle3(X, Middle),
  append1(Middle, [Last], Xs).

% Permutation 4
middle4(X, [First|Xs]) :-
  middle4(X, Middle),
  append1(Middle, [Last], Xs).
middle4(X, [X]).