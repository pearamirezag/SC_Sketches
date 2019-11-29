(

	SynthDef(\Piano_rhodeySC, {
		//FM Rhodes Synthethizer
	    |
	    // standard meanings
	    out = 0, freq = 440, gate = 1, pan = 0, amp = 0.1,
	    // all of these range from 0 to 1
	    vel = 0.8, modIndex = 0.2, mix = 0.2, lfoSpeed = 0.4, lfoDepth = 0.1
	    |
	    var env1, env2, env3, env4;
	    var osc1, osc2, osc3, osc4, snd;

	    lfoSpeed = lfoSpeed * 12;

	    freq = freq * 2;

	    env1 = EnvGen.ar(Env.adsr(0.001, 1.25, 0.0, 0.04, curve: \lin));
	    env2 = EnvGen.ar(Env.adsr(0.001, 1.00, 0.0, 0.04, curve: \lin));
	    env3 = EnvGen.ar(Env.adsr(0.001, 1.50, 0.0, 0.04, curve: \lin));
	    env4 = EnvGen.ar(Env.adsr(0.001, 1.50, 0.0, 0.04, curve: \lin));

	    osc4 = SinOsc.ar(freq * 0.5) * 2pi * 2 * 0.535887 * modIndex * env4 * vel;
	    osc3 = SinOsc.ar(freq, osc4) * env3 * vel;
	    osc2 = SinOsc.ar(freq * 15) * 2pi * 0.108819 * env2 * vel;
	    osc1 = SinOsc.ar(freq, osc2) * env1 * vel;
	    snd = Mix((osc3 * (1 - mix)) + (osc1 * mix));
	    snd = snd * (SinOsc.ar(lfoSpeed) * lfoDepth + 1);

	    // using the doneAction: 2 on the other envs can create clicks (bc of the linear curve maybe?)
	    snd = snd * EnvGen.ar(Env.asr(0, 1, 0.1), gate, doneAction: 2);
	    snd = Pan2.ar(snd, pan, amp);

	    Out.ar(out, snd);
	//By Nathan Ho aka Snappizz
	//http://sccode.org/1-522
	}).add;

)

x = Synth.new(\sine_vintage);

(
	b = Scale.minor;

	Pdef(\patrosn,
		Pbind(
			\instrument, \Piano_rhodeySC,
			\scale, b,
			\degree, Pshuf([[0,2,4,6], [1,4,6], 0, 4, 5, 7, 3],inf),
			\root, 0,
			\octave, Pshuf([2,3,4],inf),
			\dur, Prand([0.25, 0.25, 0.13, 0.13, 0.5], inf)
			)).play;
)


s.boot;

b = Scale.minor;

(

    a = Scale.minor;

    p = Pbind(
		\instrument, \Piano_rhodeySC,
		\scale, Pfunc({ a }, inf),
		\sus, 0.5,
		\degree, 1,
		\degree, Pseq([8, 6, 6, 6, 6, 6, 7, 8, 5, 5, 5, 4, 4, 5, 6, 7, 8, 5, 6, 8, 7, 5, 5, 4],1)-1,
		\dur, Pseq([0.13, 0.25, 0.25,0.38, 0.63,0.38, 0.25, 0.38,0.5, 0.13, 0.25, 0.25,2, 0.25, 0.25, 0.38, 2, 0.25, 0.5, 0.25, 0.5, 0.25, 0.25, 1 ])
    );

    q = p.play;

)


s.boot;

a = Scale.major;
a.degrees;        // [ 0, 2, 4, 5, 7, 9, 11 ]
a.semitones;        // [ 0, 2, 4, 5, 7, 9, 11 ]
a.cents;        // [ 0, 200, 300, 500, 700, 900, 1100 ]
a.ratios;        // [ 1, 1.1224620483089, 1.2599210498937, 1.3348398541685, etc. ]

Pbind(\scale, a, \degree, Pseq((0..7) ++ (6..0) ++ [\rest], 1), \dur, 0.25).play;

// use non-standard tuning
a.tuning_(\just);
a.degrees;        // no change; degrees are independent of tuning
a.semitones;        // [ 0, 2.0391000173077, 3.1564128700055, 4.9804499913461, etc. ]
a.ratios.collect(_.round(0.001));    // [ 1, 1.125, 1.2, 1.333, 1.5, 1.667, 1.875 ]

Pbind(\scale, a, \degree, Pseq((0..7) ++ (6..0) ++ [\rest], 1), \dur, 0.25).play;
