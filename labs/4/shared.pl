:- prolog_flag(toplevel_print_options, _,
 [quoted(true),numbervars(true),portrayed(true),max_depth(20)]).

% Valid states
valid(C, 0) :-
  C >= 0.
valid(C, M) :-
  M  > 0,
  M >= C,
  C >= 0.
valid([LC:LM,_,RC:RM]) :-
  valid(LC, LM),
  valid(RC, RM).

% Edges
% A cannibal from left to right
edge([LC:LM,left,RC:RM], NS) :-
  NewLC is LC - 1,
  NewRC is RC + 1,
  NS = [NewLC:LM,right,NewRC:RM],
  valid(NS).
% A missionarie from left to right
edge([LC:LM,left,RC:RM], NS) :-
  NewLM is LM - 1,
  NewRM is RM + 1,
  NS = [LC:NewLM,right,RC:NewRM],
  valid(NS).
% Two cannibals from left to right
edge([LC:LM,left,RC:RM], NS) :-
  NewLC is LC - 2,
  NewRC is RC + 2,
  NS = [NewLC:LM,right,NewRC:RM],
  valid(NS).
% Two missionaries from left to right
edge([LC:LM,left,RC:RM], NS) :-
  NewLM is LM - 2,
  NewRM is RM + 2,
  NS = [LC:NewLM,right,RC:NewRM],
  valid(NS).
% Mixed from left to right
edge([LC:LM,left,RC:RM], NS) :-
  NewRM is RM + 1,
  NewRC is RC + 1,
  NewLC is LC - 1,
  NewLM is LM - 1,
  NS = [NewLC:NewLM,right,NewRC:NewRM],
  valid(NS).

% A cannibal from right to left
edge([LC:LM,right,RC:RM], NS) :-
  NewLC is LC + 1,
  NewRC is RC - 1,
  NS = [NewLC:LM,left,NewRC:RM],
  valid(NS).
% A missionarie from right to left
edge([LC:LM,right,RC:RM], NS) :-
  NewLM is LM + 1,
  NewRM is RM - 1,
  NS = [LC:NewLM,left,RC:NewRM],
  valid(NS).
% Two cannibals from right to left
edge([LC:LM,right,RC:RM], NS) :-
  NewLC is LC + 2,
  NewRC is RC - 2,
  NS = [NewLC:LM,left,NewRC:RM],
  valid(NS).
% Two missionaries from right to left
edge([LC:LM,right,RC:RM], NS) :-
  NewLM is LM + 2,
  NewRM is RM - 2,
  NS = [LC:NewLM,left,RC:NewRM],
  valid(NS).
% Mixed from right to left
edge([LC:LM,right,RC:RM], NS) :-
  NewLM is LM + 1,
  NewLC is LC + 1,
  NewRC is RC - 1,
  NewRM is RM - 1,
  NS = [NewLC:NewLM,left,NewRC:NewRM],
  valid(NS).

printReverse([N]) :-
  write('START~>'), write(N), write('~>').
printReverse([N|Nodes]) :-
  printReverse(Nodes),
  write(N), write('~>').

printNodes(Nodes) :-
  nl,nl,
  printReverse(Nodes),
  write('~>END.'),nl,nl.