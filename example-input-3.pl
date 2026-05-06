employee(zoey).
employee(ophelia).
employee(ulysses).
employee(kimberly).
employee(erica).
employee(sarah).
employee(jack).
employee(ginny).
employee(ximena).
employee(walter).
employee(quinn).
employee(iris).
employee(tim).
employee(larry).
employee(daniel).
employee(mira).
employee(frank).

workstation(1,1,5).
workstation(2,2,3).

workstation_idle(_,_) :- fail.

avoid_workstation(tim, 2).

avoid_shift(ulysses, evening).
avoid_shift(erica, evening).
avoid_shift(daniel, morning).
avoid_shift(daniel, evening).
