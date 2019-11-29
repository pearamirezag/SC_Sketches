s.boot;

(

x = {
	BPF.ar(
		Pulse.ar(
			Array.rand(5, 0, 10), ExpRand(60,5000))* XLine.kr(1, 0.01, 5, doneAction:2))
}.play;
)

s.scope;


1200.rand.range(50,200)
1200.rand

ExpRand


Array.rand(2,5,10); //LLenar un arreglo de números. El primer valor es la cantidad, min y max respectivamente



{ x = BPF.ar(Pulse.ar(Array.rand(9, 1.0, 10.0))* XLine.kr(1, 0.01, 10.rand, doneAction:2),ExpRand(60, 5000))}.play;


Array.rand(9, 1, 10);
do
