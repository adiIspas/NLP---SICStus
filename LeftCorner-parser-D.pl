% --left-corner parser with extended grammar, features, result tree and skip for empty production rules

parse(Constituent, [Cuvant|SirRamas], S, Numar, ArboreR) :- 
	cuvant(W, Numar, Cuvant),
	completeaza(W, Constituent, SirRamas, S, Numar, [W, [Cuvant]], ArboreR).
	
completeaza(W, W, S, S, _, Arb, Arb).
completeaza(W, Constituent, SirRamas, S, Nr, Arbore, ArboreR) :-
	regula(Parinte, NrParinte, [Nr | Numere], [W | Rest]),
	skip_pp(Rest, SkipRest),
	parse_lista(SkipRest, SirRamas, S1, Numere, Arbore1),
	completeaza(Parinte, Constituent, S1, S, NrParinte, [Parinte, [Arbore | Arbore1]], ArboreR).

parse_lista([C|Constituenti], S1, S, [Nr | Numere], [Arbore1 | Arbore2]) :-
	parse(C, S1, S2, Nr, Arbore1),
	parse_lista(Constituenti, S2, S, Numere, Arbore2).
parse_lista([], S, S, _, []).

skip_pp([], []).
skip_pp([P | Y], Z) :- regula(P, _, [], []), skip_pp(Y, Z).
skip_pp([P | Y], [P | Z]) :- skip_pp(Y, Z).

regula(s, _, [Nr, Nr], [np, vp]).
regula(np, Nr, [Nr, Nr, _], [det, n, pp]).
regula(vp, Nr, [Nr, _], [v, np]).
regula(pp, Nr, [_, Nr], [p, np]).
regula(pp, _, [], []).

cuvant(det, _, the).
cuvant(det, plur, all).
cuvant(det, sing, every).
cuvant(p, _, near).
cuvant(conj, _, and).
cuvant(n, sing, dog).
cuvant(n, plur, dogs).
cuvant(n, sing, cat).
cuvant(n, plur, cats).
cuvant(n, sing, elephant).
cuvant(n, plur, elephants).
cuvant(v, plur, chase).
cuvant(v, sing, chases).
cuvant(v, plur, see).
cuvant(v, sing, sees).
cuvant(v, plur, amuse).
cuvant(v, sing, amuses).

parse_s(X, Arbore) :- parse(s, X, [], _, Arbore).
