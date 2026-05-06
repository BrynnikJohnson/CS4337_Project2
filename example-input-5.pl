employee(ophelia).
employee(peter).
employee(ximena).
employee(venessa).
employee(bob).
employee(jack).
employee(alice).
employee(iris).
employee(nick).
employee(ryan).
employee(kimberly).
employee(charlie).
employee(harry).

workstation(1,1,6).

workstation_idle(_,_) :- fail.

avoid_workstation(_,_) :- fail.

avoid_shift(ophelia, morning).
