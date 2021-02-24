puzzle(Table) :-
    Table = [[930,	P1,	F1,	W1],
			[1020,	P2,	F2,	W2],
			[1400,	P3,	F3,	W3],
			[2000,	P4,	F4,	W4],
			[2290,	P5,	F5,	W5]],
    permutation(['Keith', 'Juliana', 'Gary', 'Leslie', 'Myles'], [P1, P2, P3, P4, P5]),
    permutation(['Cranberries', 'Limes', 'Pineapples', 'Strawberries', 'Cherries'], [F1, F2, F3, F4, F5]),
    permutation(['Chablis', 'Chianti', 'Shiraz', 'Burgundy', 'Bordeaux'], [W1, W2, W3, W4, W5]),
	rule8(Table),
    rule7(Table),
    rule2(Table),
	rule5(Table),
    rule4(Table),
    rule6(Table),
    rule3(Table),
    rule1(Table),
    rule9(Table),
    rule10(Table),
    true.


%1. The wine enthusiast who specializes in chablis doesn't grow cherries.
rule1(Table) :- forall(member([ _, _, Fruit, 'Chablis'], Table), Fruit \= 'Cherries').

%2. The person who grows limes is Juliana.
rule2(Table) :- forall(member([_, 'Juliana', Fruit, _], Table), Fruit = 'Limes').

%3. The wine enthusiast who specializes in bordeaux owes more money than the person who grows strawberries.
rule3(Table) :- forall( (	member([M1, _, 	_, 'Bordeaux'], Table),
                       		member([M2, _, 'Strawberries', _], Table)),
    						M1 > M2).

%4. Of Leslie and the person who grows pineapples, one has the $2000 hospital bill and the other has the $1400 hospitalbill.
rule4(Table) :- forall( (  	member([M1, 'Leslie', _, _], Table),
                       		member([M2, _, 'Pineapples', _], Table)),
                       		permutation([M1, M2], [2000, 1400])).

%5. Either the wine enthusiast who specializes in chianti or the wine enthusiast who specializes in shiraz grows limes.
rule5(Table) :- forall(   	member(   [_, _, 'Limes', W1], Table),
                            W1='Chianti'; W1='Shiraz').
      
%6. The patient with the $930 hospital bill doesn't grow strawberries.
rule6(Table) :- forall(   member(   [930, _, F1, _], Table), F1\='Strawberries').
      
%7. The 5 people were  the patient with the $1020 hospital bill, the person who grows strawberries, Myles, 
%the wine enthusiast who specializes in chablis,  and the patient with the $1400 hospital bill.
rule7(Table) :- forall(   	(member( [1020, P1, F1, W1], Table),
                       		member(	[M2, 'Myles', F2, W2], Table),
                       		member(	[M3, P3, 'Strawberries', W3], Table),
                       		member(	[M4, P4, F4, 'Chablis'], Table),
                       		member(	[1400, P5, F5, W5], Table)),
                       		(P1\=P3,P1\=P4,P1\=P5,P3\=P4, P3\=P5, P4\=P5,
                       		M2\=M3,M2\=M4,M3\=M4,
                       		F1\=F2,F1\=F4,F1\=F5,F2\=F4,F2\=F5,F4\=F5,
                       		W1\=W2,W1\=W3,W1\=W5,W2\=W3,W2\=W5,W3\=W5)).
      
%8. Juliana owes less money than Myles.
rule8(Table) :- forall((   	member(	[M1, 'Juliana', _, _], Table),
                       		member(	[M2, 'Myles', _, _], Table)),
                       		M1< M2).
      
%9. The patient with the $1400 hospital bill specializes in shiraz.
rule9(Table) :- forall(   	member(   [1400, _, _, W1], Table), W1='Shiraz').
      
%10. The wine enthusiast who specializes in chianti owes more money than Keith.
rule10(Table) :- forall((	member([M1, _, _, 'Chianti'], Table),
                           	member([M2, 'Keith', _, _], Table)),
                        	M1 > M2).

correct([	6[930,	'Keith',	'Cranberries',	'Chablis'],
			[1020,	'Juliana',	'Limes',	'Chianti'],
			[1400,	'Gary',		'Pineapples',	'Shiraz'],
			[$2000,	'Leslie',	'Strawberries',	'Burgundy'],
			[$2290,	'Myles',	'Cherries',	'Bordeaux']	]).

%check :- time(	(aggregate_all(count, (puzzle(Table)), Count))),(   correct(_CT), puzzle(_CT), format('Correct~n')).
:- use_rendering(table).

