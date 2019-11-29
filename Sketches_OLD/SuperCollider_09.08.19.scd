s.boot;

(
SynthDef.new(\grey, {
	arg freq = 100, dustfreq = 5, out = 0, amp = 1;
	var sig;
	sig = Resonz.ar(BrownNoise.ar(),freq) * Dust.kr(dustfreq!2, amp);
	Out.ar(out, sig);
}
).add;
)

(
SynthDef.new(\revb, {
	arg in = 5, out = 0, mix = 1, room = 3;
	var sig;
	sig = In.ar(in,2);
	sig = FreeVerb.ar(sig, mix, room);
	Out.ar(out, sig);
}
).add;
)


~fxbus = Bus.audio(s,1);
~srcbus = Bus.audio(s,1);

~srcbus = Group.new;
~fxbus = Group.after(~srcbus);


x = Synth.new(\grey, target: ~srcbus);
y = Synth.new(\revb, target: ~fxbus);

x.set(\freq, 5000);
x.set(\freq, 10000, \dustfreq, 30);
x.set(\freq, 10000, \dustfreq, 30, \amp, 5);
x.set(\out, 5);
x.set(\out, 0);

y.set(\mix, 1);
y.set(\mix, 0.6, \room, 0.99);
x.set(\dustfreq, 50);

s.scope;
s.plotTree;


Pbind(\degree, 6, \dur, 0.75).play;

Pbind(
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7],inf),
	\dur,Pseq([0.2, 0.5, 0.2, 0.7, 0.7, 0.2],inf

)).play;

(
Pbind(
	\degree,Pseq([0, 1, 2, 3, 4, 5, 6, 7],inf),
	\dur,Pseq([0.2, 0.5, 0.2, 0.7, 0.7, 0.2],inf),
	).play;
)


(
Pbind(
	\degree,Prand([0, 2, 3, 5, 7, 8, 11, 12],inf),
	\dur,Prand([0.2, 0.5, 0.2, 1, 0.9],inf),
	\amp, Pwhite(100,1000)/1000,
	\legato, Prand([0.1, 0.4, 0.1, 0.9, 0.9,0.2, 0.5], inf),
	).trace.play;
)

(
 Pbind(
 \note, Pslide([0, 2, 3, 5, 7, 8, 11, 12], 7, 5, 1),
 \dur, 0.15;
 ).trace.play;
)

(
 Pbind(
 \note, Pseries(0, 6 ,6),
 \dur, 0.15;
 ).trace.play;
)

(
 Pbind(
 \note, Pseq([0, 2, 3, 5, 7, 8, 11, 12], inf),
 \dur, Pgeom(0.1, 1.1, 25);
 ).play;
 )

(
Pbind(
	\scale, Scale.harmonicMinor,
 \degree, Pseq([[−7, 3, 7, 10], [0, 3, 5, 8]], inf),
	\dur, Pgeom(0.1, 1.02, 25),
	\ctranspose, Pseq(([-12, 0, 12]),inf),
 \legato, 0.4,
 \strum, 0.05// try 0, 0.1, 0.2, etc
 ).trace.play;

)


(
{
 "one thing".postln;
 2.wait;
 "another thing".postln;
 1.5.wait;
 "one last thing".postln;
 }.fork;
)


