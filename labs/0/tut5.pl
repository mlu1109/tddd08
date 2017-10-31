% 1
rev([], Acc, Acc).
rev([H|T], Acc, Rev) :-
  rev(T, [H|Acc], Rev).

palindrome(L) :-
  rev(L, [], LRev),
  LRev == L.

% 2
thi([], []).
thi([_|L], S) :-
  thi1(L, S).

thi1([], []).
thi1([H|L], [H|S]) :-
  thi2(L, S).

thi2([], []).
thi2([_|L], S) :-
  thi(L, S).

% 3
b