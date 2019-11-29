s.boot;
s.meter;
s.plotTree;

{ Crackle.ar(MouseX.kr(1,2), 0.5) }.scope(1);


(
SynthDef.new(\crook, {
	arg out, den = 150;
	var sig ;
	sig = Dust2.ar(den, mul:0.6);
	Out.ar(out, sig);
}).add;
)

(
SynthDef.new(\reverb, {
	arg in, out=0, mix = 0.33, room = 0.2;
	var sig;
	sig = In.ar(in,1);
	sig = FreeVerb.ar(sig, mix, room)!2;
	Out.ar(out, sig);
}).add;
)


x = Synth(\crook);
y = Synth(\reverb);
x.set(\den, 5);
y.set(\mix, 0.6);
y.set(\room, 0.9);

x.free;
x.freeAll;