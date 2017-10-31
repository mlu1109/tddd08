% For every element in the second list, make a new entry with that element infront of the elements in the first list
expand(_X, [], []).
expand(X, [Y|Z], [[Y|X]|W]) :-
  expand(X, Z, W).

bfsPath([CurBranch|_Branches], Goal, Path) :-
  CurBranch = [Goal|Branch],
  nonmember(Goal, Branch),
  Path = CurBranch.
bfsPath([CurBranch|Branches], Goal, Path) :-
  CurBranch = [Leaf|Branch],
  member(Leaf, Branch),
  bfsPath(Branches, Goal, Path).
bfsPath([CurBranch|Branches], Goal, Path) :-
  CurBranch = [Leaf|Branch],
  nonmember(Leaf, Branch),
  findall(X, edge(Leaf, X), Adjacent),
  expand(CurBranch, Adjacent, Expanded),
  append(Branches, Expanded, NewBranches),
  bfsPath(NewBranches, Goal, Path).

bfs(Path) :- 
  Start = [3:3,left,0:0],
  Goal  = [0:0,right,3:3],
  bfsPath([[Start]], Goal, Path).