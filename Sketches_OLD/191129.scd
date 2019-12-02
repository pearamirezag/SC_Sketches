s.boot;

(
	SynthDef.new(\gery,
		{
			arg freq = 440, atk = 0.005, rel = 0.3, hold = 6.0, amp = 0.7, pan = 0, transitionTime = 0.875, freqFilter = 800, resFilter = 0.2;
			var sig, env;
			env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, hold, rel], \sine)); // Envelope
			sig = Blip.ar(freq, ExpRand(10,400))*env;
			sig = Pan2.ar(sig, Line.ar(0,pan, transitionTime), amp);
			sig = DFM1.ar(sig,freqFilter,resFilter);

			DetectSilence.ar(sig.sum, 0.001, doneAction:2); // This is intended to release synths when they become silent.
			Out.ar(0, Limiter.ar(sig,0.1));
			}).add;

)

x = Synth.new(\gery);

(	a = Scale.minor;

		p = Pbind(
			\instrument, \gery,
			\scale, a,
			\degree, Prand([0,1,3,1,4,6,5], inf),
			\root, 1,
			\octave, 4,
			\pan,  Prand([ Pwhite(-1.0, -0.5, 1), Pwhite(0.5, 1.0, 1) ], inf),
			\transitionTime, Prand([0.875,2.0], inf),
			\atk, Pwhite(15.0, 45.0, inf), // The possible durations of the Attack part of the amplitude envelope.
			\hold, Pwhite(4.0, 14.0, inf), // This is where the Sustain or Hold part of the envelope gets made.
			\rel, Pwhite(30.0, 60.0, inf), // The realease goes here.
			\freqFilter, Pwhite(60, 1500, inf),
			\dur, Pwhite(0.25,10.0, inf),

			);
	p.play;
)

{EnvGen.kr(Env.new([0, 1, 1, 0], [0.005, 6, 0.3], \sine))}.plot;

s.plotTree;
