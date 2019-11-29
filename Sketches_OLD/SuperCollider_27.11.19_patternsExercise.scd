(
SynthDef(\everythingrhodes,{|out= 0 freq = 440 amp = 0.1 gate=1 lforate = 4.85 lfowidth= 0.5 cutoff= 2000 rq=0.5 pan = 0.0|

//Electric Piano
	var pulse, filter, env;

	pulse = Pulse.ar(freq*[1,33.5.midiratio],[0.2,0.1],[0.7,0.3]);

	env = EnvGen.ar(Env.adsr(0.0,1.0,0.8,3.0),gate,doneAction:2);

	//keyboard tracking filter cutoff
	filter = BLowPass4.ar(pulse,(cutoff*(env.squared))+200+freq,rq);

	Out.ar(out,Pan2.ar(Mix(filter)*env*amp,pan));

//By Nick Collins, from Mitchell Sigman (2011) Steal this Sound
//http://www.sussex.ac.uk/Users/nc81/index.html
}).add;
)


x = Synth.new(\everythingrhodes);


(
Pdef(\roey,
	Pbind(
		\instrument, \everythingrhodes,
		\scale, Scale.minor,
		\degree, Pseq([0,0,3,3,1,4,3,1],1),
		\dur, Pshuf([0.25, 0.25, 0.5, 0.13,0.25],1)
	)
).play;
)

(
p = Pbind(
	\instrument, \everythingrhodes,
	\octave, 3,
    \degree, Ppatlace([
        Pseries(0, 1, 8),    // first, third etc. notes
        Pseries(2, 1, 7)    // second, fourth etc. notes
    ], inf),
	\legato, 1,
    \dur, 0.25
).play;
)

Pseries(0, 1, 8).flatten;
