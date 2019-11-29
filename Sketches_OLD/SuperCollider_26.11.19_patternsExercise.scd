(
~maxharm = 14;
SynthDef(\textureSynth, { |freq=440, numharm=4, clip=1, amp=1, outbus=0|
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

x = Synth.new(\textureSynth, [\amp, 0.25]);
x.free;
s.meter;

(
a = Pdef( \yo,
	Pbind(
		\instrument, \textureSynth,
		\freq, Pseq(60+[0,1,2,3,4,5,6,7,8], 1).midicps,
		\dur, 3
	).play;
)
)



EnvGen.ar(Env([0,1,0.5,0.1,0.01], [0.1,1,0.1,1], [1,-4,-4,-1])).plot;
Env([0,1,0.5,0.1,0.01], [0.1,1,0.1,1], [1,-4,-4,-1]).plot;

(1..~maxharm) // [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ]

(1..~maxharm)*440 // [ 440, 880, 1320, 1760, 2200, 2640, 3080, 3520, 3960, 4400, 4840, 5280, 5720, 6160 ]