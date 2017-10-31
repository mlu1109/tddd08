% Union
% Assumes A, B are sorted lists with disjunct elements
union([], [], []).
union([HA|TA], [], [HA|TA]).
union([], [HB|TB], [HB|TB]).
union([HA|TA], [HB|TB], [HA|Res]) :-
  HA @< HB,
  union(TA, [HB|TB], Res).
union([HA|TA], [HB|TB], [HB|Res]) :-
  HA @> HB,
  union([HA|TA], TB, Res).
union([H|TA], [H|TB], [H|Res]) :-
  union(TA, TB, Res).

% Intersection
% Assumes A, B are sorted lists with disjunct elements
intersection([], [], []).
intersection([_HA|_TA], [], []).
intersection([], [_HB|_TB], []).
intersection([H|TA], [H|TB], [H|Res]) :-
  intersection(TA, TB, Res).
intersection([HA|TA], [HB|TB], Res) :-
  HA @< HB,
  intersection(TA, [HB|TB], Res).
intersection([HA|TA], [HB|TB], Res) :-
  HA @> HB,
  intersection([HA|TA], TB, Res).

% Powerset
% Assumes A, B are sorted lists with disjunct elements
subset([], []).
subset([H|TA], [H|TB]) :-
  subset(TA, TB).
subset(A, [_|TB]) :-
  subset(A, TB).

powerset(A, Res) :-
  findall(SubA, subset(SubA, A), Sets),
  sort(Sets, Res).