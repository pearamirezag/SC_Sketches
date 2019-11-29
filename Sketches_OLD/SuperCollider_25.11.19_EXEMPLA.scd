
~scale = [0,2,5,9,12,14];
~root = 38+12;

(
~maxharm = 14;
SynthDef(\textureSynth, { |freq=440, numharm=4, clip=1, amp=1, outbus=100|
	var out, src, env, amps;

	// mutes
	amps = {|i| i<numharm}!~maxharm;
	amps = amps.collect{|item, i| item/(i+1)};

	// envelope
	env = EnvGen.ar(Env([0,1,0.5,0.1,0.01], [0.1,1,0.1,1], [1,-4,-4,-1]), timeScale:Rand(2,6), levelScale:0.5, doneAction:2);

	// source
	src = PinkNoise.ar(0.5);
	out = src * env;

	// filter
	out = RLPF.ar(out, (1..~maxharm)*freq, Rand(0.001, 0.01), mul:amps);
	out = Mix.new(out);

	// effects
	out = (out*2).tanh;
	out = out.clip2(clip);

	// spatialization
	out = Pan2.ar(out);
	Out.ar(outbus, amp * out);
}).add;
)

x = Synth.new(\textureSynth, [\outbus, 0, \amp, 0.2]);

(
Pdef(\yo, (
Pbind(\instrument, \textureSynth,
	\pat, Prand((0..~scale.size-1),60),
	\freq, Pcollect({|i| (~root + ~scale[i]).midicps}, Pstutter(1,Pkey(\pat))),
	\numharm, Prand((1..4), inf),
	\dur, 1,
	\amp, 0.2,
	\clip, 1,
	\outbus, 0
);
)
).play;

)