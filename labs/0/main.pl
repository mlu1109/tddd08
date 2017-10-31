% Not part of the course. These are exercises found on the internet.
% Recursions and Lists http://www-users.york.ac.uk/~sjh1/courses/L334css/complete/complete2su6.html

% Exercise 4
is_list([]).
is_list([_|T]) :-
  is_list(T).

% Exercise 5
cons(Add, List, Res) :-
  Res = [Add|List].

% Exercise 6
delete(_, [], []).
delete(Del, [Del|T], T).
delete(Del, [H0, H1|T], [H0|Res]) :-
  delete(Del, [H1|T], Res).

% Exercise 7
delete_all(_, [], []).
delete_all(Del, [Del|T], Res) :-
  delete_all(Del, T, Res).
delete_all(Del, [H|T], [H|Res]) :-
  Del \= H,
  delete_all(Del, T, Res).

% Exercise 8
reverse([], List, List).
reverse([H|T], List, Res) :-
  reverse(T, [H|List], Res).
reverse(List, Res) :-
  reverse(List, [], Res).

% Exercise 9
inFrench(is, est).
inFrench(an, un).
inFrench(idiot, imbecile).
inFrench('John', 'Jean').

translate([], []).
translate([H|Words], [X|French]) :-
  inFrench(H, X),
  translate(Words, French).

% Atithmetic in Prolog http://www-users.york.ac.uk/~sjh1/courses/L334css/complete/complete2su8.html

% Exercise 10
square(X, Res) :-
  Res is X * X.

% Exercise 11
power(_, 0, Res) :-
  Res is 1.
power(X, Pow, Res) :-
  Pow < 0,
  IncPow is Pow + 1,
  power(X, IncPow, SubRes),
  Res is SubRes / X.
power(X, Pow, Res) :-
  Pow > 0,
  DecPow is Pow - 1,
  power(X, DecPow, SubRes),
  Res is SubRes * X.
