append_dl(X-Y, Y, X).

empty_dl(L-L).
/*
append_dl([a, b|X]-X, [c, d|Y]-Y, O).
*/

ee([_|_], [], []).
ee([], [_|_], []).
ee([], [], []).
ee([H|L1],[H|L2],[H|Res]) :-
    ee(L1, L2, Res).
ee([H1|L1], [H2|L2], Res) :-
    dif(H1, H2),
    ee(L1, L2, Res).