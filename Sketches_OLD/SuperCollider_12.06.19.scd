(
   x = { arg freq = 220;
	var sig;

	sig =  BPF.ar((PinkNoise.ar(XLine.kr(0.1, 1.5, 1, doneAction: 2)!2 , 0)), ExpRand(200, 2000),ExpRand(0.01,2));

}.play;

)

x.play;
y.free;
