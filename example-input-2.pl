employee(walter).
employee(ryan).
employee(bob).
employee(yusuf).
employee(alice).
employee(tim).
employee(peter).
employee(frank).
employee(daniel).
employee(harry).
employee(ximena).
employee(sarah).
employee(mira).
employee(ginny).
employee(larry).
employee(jack).
employee(ulysses).
employee(zoey).
employee(erica).

workstation(1,1,6).
workstation(2,2,6).
workstation(3,1,9).
workstation(4,3,4).
workstation(5,3,1).
workstation(6,2,2).

workstation_idle(_,_) :- fail.

avoid_workstation(_,_) :- fail.

avoid_shift(_,_) :- fail.
