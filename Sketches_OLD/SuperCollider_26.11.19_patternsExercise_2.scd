(
SynthDef("pluck", {arg amp = 0.1, freq = 440, decay = 5, coef = 0.1;
	var env, snd;
	env = EnvGen.kr(Env.linen(0, decay, 0), doneAction: 2);
	snd = Pluck.ar(
		in: WhiteNoise.ar(amp),
		trig: Impulse.kr(0),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: decay,
		coef: coef);
	Out.ar(0, [snd, snd]);
}).add;
)


(
Pdef(\paternn,
	Pbind(
		\instrument, \pluck,
		\scale, Scale.major,
		\degree, Prand([Pseq([0,0,4,0,5,4,2,1,0],4), Pseq([7,7,4,0,2,1,0],4)],inf),
		\dur, 0.25,
	)
).play;
)

(
Pdef(\patern2,
	Pbind(
		\instrument, \pluck,
		\scale, Scale.major,
		\degree, Pseq([0,0,4,0,5,4,2,1,0],inf)-8,
		\dur, Prand([0.25, 0.5, 1], inf),
	)
).play;
)



Scale.minor.postln;