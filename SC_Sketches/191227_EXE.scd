s.boot;
p = ProxySpace.push(s);

{SinOsc.ar(440)*0.2}.play;
~out = {arg freq = 440; SinOsc.ar(freq*LFNoise0.kr(LFNoise0.kr(2).exprange(2,10)).exprange(0.2,1))*0.2};

(
	SynthDef.new(\sine,
		{
			arg freq = 440, atk = 0.1, dcy = 0.2, amp = 0.5, pan = 0;
			var sig, env;
			env = EnvGen.kr(Env.new([0,1,0],[atk,dcy]), doneAction:2);
			sig = SinOsc.ar(freq);
			sig = sig*env*amp;
			Out.ar(0, Pan2.ar(sig, pan));
			}).add;
	)

Synth.new(\sine);

Scale.directory;

(
Pdef(\paterns,
	Pbind(
		\instrument, \sine,
		\atk, 5,
		\amp, 0.02,
		\scale, Scale.partch_u2,
		\dcy, 5,
		\degree, Pstutter(Prand([2,3,1],inf),Prand([4, 0, 1, 1, 6], inf)),
		\octave, Pstutter(Prand([2,3],inf),Prand([4,5,3], inf)),
		\dur, Prand([0.2, 0.1, 0.2, 0.1, 0.2], inf),
		\pan, Prand([-1,-0.5,0,0.5,1],inf)
		)
).play;
)

Pfx

p.clock = TempoClock.default;
p.clock.tempo = 0.05;

s.meter;
s.plotTree;

~out.play;
~out.free;
~out.set(\freq, 2200);
