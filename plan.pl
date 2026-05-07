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

    % Partition employees into shift groups
    order_employees(AllEmps, Sorted),
    partition_shifts(Sorted, MCount, ECount, NCount, MEmps, EEmps, NEmps),

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

% partition_shifts: assign each employee to morning, evening, or night

partition_shifts([], 0, 0, 0, [], [], []).

partition_shifts([Emp|Rest], MC, EC, NC, [Emp|ME], EE, NE) :-
    MC > 0,
    \+ avoid_shift(Emp, morning),
    MC1 is MC - 1,
    partition_shifts(Rest, MC1, EC, NC, ME, EE, NE).

partition_shifts([Emp|Rest], MC, EC, NC, ME, [Emp|EE], NE) :-
    EC > 0,
    \+ avoid_shift(Emp, evening),
    EC1 is EC - 1,
    partition_shifts(Rest, MC, EC1, NC, ME, EE, NE).

partition_shifts([Emp|Rest], MC, EC, NC, ME, EE, [Emp|NE]) :-
    NC > 0,
    \+ avoid_shift(Emp, night),
    NC1 is NC - 1,
    partition_shifts(Rest, MC, EC, NC1, ME, EE, NE).