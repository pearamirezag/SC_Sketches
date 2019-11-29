(
SynthDef.new(\sawtooone, {
	arg freq=400, amp=0.1, out=0, gate=1, rel=2;
	var sig, freqCtrl, env;
	env = EnvGen.kr(Env.perc, doneAction:2);
	freqCtrl = freq * LFNoise1.kr(2!8).range(-0.25,0.25).midiratio;
	sig = VarSaw.ar(freqCtrl) * env * amp;
	sig = Splay.ar(sig);
	Out.ar(out,sig);
}).add;
)



x = Synth.new(\sawtooone);

/// Test con Routine

(
Routine.new({
	[60, 75, 57, 30].do({
		arg tooone;
		1.wait;
		x = Synth(\sawtooone, [\freq, tooone.midicps]);
	})
}).play;
)


(
(
{[60, 75, 57, 30, 62, 70].do({
		arg tooone;
	rrand(0.1,1).wait;
		x = Synth(\sawtooone, [\freq, tooone.midicps]);
	})
}).fork;
)

(
p = Pbind(
    \instrument, \sawtooone,
	\freq, Prand([[60, 75, 57], [30, 62, 70]],inf).midicps,
	\dur, 2
).play;
)




