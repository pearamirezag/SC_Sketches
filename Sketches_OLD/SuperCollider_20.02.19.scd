(
SynthDef( 'Ayahuasca',
	{  arg freq = 440, vol = 0.8;
		var lfofreq;
		lfofreq = Saw.kr(0.5, 0, 0.4);
		Out.ar(0, SinOsc.ar(freq*lfofreq, 0, vol))
	}
).add;
)

x = Synth('Ayahuasca');
x = Synth('Ayahuasca', ['freq',660]);
x = Synth('Ayahuasca', ['freq',880]);
y = Synth('Ayahuasca', ['freq',450]);
y.free;
x.free;

{SinOsc.ar(400 + SinOsc.ar(MouseX.kr(2,2000,1), 0, MouseY.kr(1,1000)), 0, 0.5)!2}.play


{ PMOsc.ar(MouseX.kr(300,900), 600, 3, 0, 0.1) }.play; // modulate carfreq

{ PMOsc.ar(300, MouseX.kr(300,900), 3, 0, 0.1) }.play; // modulate modfreq

{ PMOsc.ar(300, 550, MouseX.kr(0,20), 0, 0.1) }.play; // modulate index





(

SynthDef(\fmsynth, {arg outbus = 0, freq=440, carPartial=1, modPartial=1, index=3, mul=0.2, ts=1;

	var mod, car, env;

	// modulator frequency

	mod = SinOsc.ar(freq * modPartial, 0, freq * index );

	// carrier frequency

	car = SinOsc.ar((freq * carPartial) + mod, 0, mul );

	// envelope

	env = EnvGen.ar( Env.perc(0.01, 1), doneAction: 2, timeScale: ts);

	Out.ar( outbus, car * env)

}).add;

)





(
Pbind(
	\instrument, \fmsynth,
	\freq, Prand([1, 1.2, 2, 2.5, 3, 4], inf) * 200, // use freq instead of degree
	\carPartial, Pseq([4, 10, 40], inf),
	\modPartial, 0.1
).play;
)

(
Pbind(
	\instrument, \fmsynth,
	\freq, Prand([1, 1.2, 2, 2.5, 3, 4], inf) * 5000, // use freq instead of degree
	\carPartial, Pstutter(2,[0.0, 0.5, 0.10, 2, 2.5, 5]),
	\modPartial, Pexprand(0.1, 2, inf),
	\dur, Prand([0.1, 0.5,0.8,0.3,0.05,0.06,0.09,2], inf),
	\index, Prand([0.1, 0.5,0.8,0.3,0.05,0.06,0.09,2], inf)
).play;
)
