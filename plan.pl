:- use_module(library(aggregate)).
:- use_module(library(apply)).
:- use_module(library(lists)).

plan(plan(Morning, Evening, Night)) :-
    findall(E, employee(E), AllEmps),
    findall(ws(S,Min,Max), workstation(S,Min,Max), AllWSs),

    get_active(morning, AllWSs, MWSs),
    get_active(evening, AllWSs, EWSs),
    get_active(night,   AllWSs, NWSs),

    % Decide exactly how many employees go to each shift
    length(AllEmps, Total),
    total_bounds(MWSs, MMin, MMax),
    total_bounds(EWSs, EMin, EMax),
    total_bounds(NWSs, NMin, NMax),
    between(MMin, MMax, MCount),
    between(EMin, EMax, ECount),
    NCount is Total - MCount - ECount,
    NCount >= NMin, NCount =< NMax,

get_active(Shift, All, Active) :-
    include(ws_active(Shift), All, Active).
ws_active(Shift, ws(S,_,_)) :-
    \+ workstation_idle(S, Shift).

total_bounds(WSs, Min, Max) :-
    maplist([ws(_,N,_),N]>>true, WSs, Mins),
    maplist([ws(_,_,N),N]>>true, WSs, Maxs),
    sumlist(Mins, Min),
    sumlist(Maxs, Max).

order_employees(Emps, Sorted) :-
    maplist(emp_key, Emps, Pairs),
    keysort(Pairs, KSorted),
    pairs_values(KSorted, Sorted).

emp_key(Emp, K-Emp) :-
    aggregate_all(count, avoid_shift(Emp,_), SC),
    aggregate_all(count, avoid_workstation(Emp,_), WC),
    K is -(SC + WC).
