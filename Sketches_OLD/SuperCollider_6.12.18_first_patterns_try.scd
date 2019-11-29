(
SynthDef.new(\ohboy,
	{
	arg freq = 440, out = 1;
	var onda, friki;
	friki = LFTri.kr(ExpRand(0.2, 60),0,0.2,1);
	freq = freq * friki;
	onda = Saw.ar(freq);
	onda = onda * EnvGen.kr(Env.perc, doneAction: 2);
		Out.ar(out, Pan2.ar(GVerb.ar(onda), SinOsc.kr(ExpRand(2, 50))));
}).add;
)

s.plotTree;

(
Pbind(
	\instrument, \ohboy,
	\freq, Pwhite(20, 1200, inf),
	\dur, Pexprand(0.01024, 2.0, inf)
).trace.play
)


Env.shapeNames;

s.boot;


Platform.userExtensionDir


(
SynthDef.new(\ohboy2,
	{
	arg freq = 440, out = 1;
	var onda, friki, friki2;
	friki = LFTri.kr(ExpRand(0.2, 60),0,0.2,1);
	friki2 = LFTri.kr(ExpRand(0.2, 60),0,0.2,1)*6;
	freq = freq * friki;
	onda = Blip.ar(freq, 500);
	onda = onda * EnvGen.kr(Env.perc, doneAction: 2);
		Out.ar(out, Pan2.ar(HPF.ar(onda, 1000, ), SinOsc.kr(ExpRand(2, 50))));
}).add;
)


(
Pbind(
	\instrument, \ohboy2,
	\freq, Pwhite(1200, 6000, inf),
	\dur, Pexprand(0.01024, 1.0, inf)
).trace.play
)

x = { SinOsc.ar(60, 0, 0.2) }.play;
x.free;