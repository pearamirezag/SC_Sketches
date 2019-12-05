(
	s.boot;
	p = ProxySpace.push(s);
	)



(
SynthDef(\ring1,
	{
		arg f = 45, a = 9, d = 0.6, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;
)


(
SynthDef(\sinfb, {
	arg freq = 440, atk = 0.01, sus = 0, rel = 1, fb = 0, amp = 0.3, out = 0, pan=0;
	var sig, env;
	env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,1,2);
	sig = SinOscFB.ar(freq,fb,1);
	sig = sig*env;
	Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);


Synth.new(\sinfb);
Synth.new(\ring1); //Test the SynthDef


(
	a = Scale.minor;

	~sout = Pbind(
		\instrument, \sinfb,
		\scale, a,
		\degree, Pshuf([5,7,6,5,5,4,5,6,0], inf),
		\dur, Prand([0.25,0.5,0.25,0.13,0.5,1],inf),
		\pan, Pwhite(-1.0,1.0,inf),
		);

	)


~sout.play;
~sout.set(\rel, 0.1);
~sout.set(\rel, 0.2);
~sout.set(\fb, ~lfo);
~sout.clear;


~sout.fadeTime = 40;

p.clock = TempoClock.default;
p.clock.tempo = 5;

~lfo ={LFNoise1.kr(4,1,1).abs};
~lfo.scope;
~lfo.fadeTime = 10;

(
~patren = Pbind(
	\instrument, \ring1,
	\f, Prand([5,3,2,7,5,6,3],inf)*20,
	\dur, Prand([0.5,0.25,0.75,0.15],inf),
	\d, Pwhite(0.1, 0.9, inf),
	\a, Pwhite(0.1, 2.9, inf)
	);
	~patren.play;
)

~patren.fadeTime = 15;
p.clock = TempoClock.default;
p.clock.tempo = 2.0;


(
	~dronez =

	)
