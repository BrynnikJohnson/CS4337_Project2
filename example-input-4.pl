employee(ginny).
employee(daniel).
employee(sarah).
employee(mira).
employee(nick).
employee(charlie).
employee(erica).
employee(kimberly).
employee(ryan).
employee(tim).
employee(alice).
employee(quinn).
employee(ulysses).
employee(harry).
employee(iris).
employee(yusuf).
employee(bob).
employee(larry).
employee(zoey).
employee(jack).
employee(frank).

workstation(1,2,6).
workstation(2,1,1).
workstation(3,1,5).
workstation(4,2,7).

workstation_idle(_,_) :- fail.

avoid_workstation(daniel, 4).
avoid_workstation(daniel, 3).
avoid_workstation(iris, 2).
avoid_workstation(iris, 3).
avoid_workstation(iris, 1).
avoid_workstation(jack, 3).

avoid_shift(sarah, night).
avoid_shift(ulysses, morning).
