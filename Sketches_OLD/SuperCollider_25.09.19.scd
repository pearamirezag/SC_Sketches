s.boot;

(
SynthDef.new(\analogue, {
	arg freq = 440, amp = 0.3, out = 0;
	var sig, freqCtrl, env;
	env = EnvGen.kr(
		Env.new([0,1,0],[2,2],[2,-2]),doneAction:2);
	freqCtrl = freq * LFNoise1.kr(2!8).range(-0.25, 0.25).midiratio;
	sig = VarSaw.ar(freqCtrl) * amp * env;
	sig = Splay.ar(sig);
	Out.ar(out, sig);
}).add;
)

Synth.new(\analogue);
s.meter;

(
[49,56,68,65].do({
	arg note, index;
	Synth.new(\analogue, [\freq, (note+0).midicps]);
})
)

(
({rrand(40,90).round(2)}!8).do({
	arg note, index;
	Synth.new(\analogue, [\freq, (note+0).midicps]);
})
)

