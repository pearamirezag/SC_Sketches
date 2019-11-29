s.boot;


(
	x = { arg freq = 220;
	var sig, outs;
	freq = MouseY.kr(0, 50, lag: 0.8);
	sig = Resonz.ar(Dust.ar(freq, mul:0.8), MouseX.kr(100, 8000));



}.play;

)

y = x.play;

x.set( "freq", 120);

x.free;