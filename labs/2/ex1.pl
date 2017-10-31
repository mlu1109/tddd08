sorted([_|[]]).
sorted([X,Y|T]) :-
  X =< Y,
  sorted([Y|T]).

% Selection Sort
smin([], Acc, Acc).
smin([H|T], [AccH|AccT], Res) :-
  H < AccH,
  smin(T, [H|[AccH|AccT]], Res).
smin([H|T], [AccH|AccT], Res) :-
  H >= AccH,
  smin(T, [AccH|[H|AccT]], Res).
smin([H|T], Res) :-
  smin(T, [H], Res).

ssort([], []).
ssort(List, [Min|SubRes]) :-
  smin(List, [Min|Rest]),
  ssort(Rest, SubRes).

% QuickSort
qpart([], _, [], []).
qpart([H|T], Pivot, [H|Smaller], Larger) :-
  H < Pivot,
  qpart(T, Pivot, Smaller, Larger).
qpart([H|T], Pivot, Smaller, [H|Larger]) :-
  H >= Pivot,
  qpart(T, Pivot, Smaller, Larger).

qsort([], []).
qsort([Pivot|Rest], Res) :-
  qpart(Rest, Pivot, Smaller, Larger),
  qsort(Smaller, ResSmaller),
  qsort(Larger, ResLarger),
  append(ResSmaller, [Pivot|ResLarger], Res).